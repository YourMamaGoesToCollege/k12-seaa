#!/usr/bin/env node
// axereport-processor.js
// Reads axe JSON reports and creates/updates Azure DevOps work items for critical/serious violations.
// This script is a starter: it includes a stubbed LLM call that you can replace with a real one.

const fs = require('fs');
const path = require('path');
const crypto = require('crypto');
const axios = require('axios');

if (process.argv.length < 3) {
  console.error('Usage: node scripts/axereport-processor.js <a11y-report.json>');
  process.exit(2);
}

const reportPath = process.argv[2];
if (!fs.existsSync(reportPath)) {
  console.error('File not found:', reportPath);
  process.exit(2);
}

const report = JSON.parse(fs.readFileSync(reportPath, 'utf8'));
const violations = report.violations || [];

// Filter by impact
const interesting = violations.filter(v => ['critical', 'serious'].includes(v.impact));

if (interesting.length === 0) {
  console.log('No critical/serious violations found.');
  process.exit(0);
}

// Azure DevOps settings via env
const AZDO_ORG_URL = process.env.AZDO_ORG_URL; // e.g. https://dev.azure.com/yourOrg
const AZDO_PROJECT = process.env.AZDO_PROJECT;
const AZDO_PAT = process.env.AZDO_PAT; // Personal Access Token

if (!AZDO_ORG_URL || !AZDO_PROJECT || !AZDO_PAT) {
  console.error('Missing Azure DevOps settings: set AZDO_ORG_URL, AZDO_PROJECT, AZDO_PAT');
  process.exit(2);
}

const auth = Buffer.from(':' + AZDO_PAT).toString('base64');

async function createWorkItem(title, description, tags) {
  const url = `${AZDO_ORG_URL}/${AZDO_PROJECT}/_apis/wit/workitems/$Issue?api-version=6.0`;
  const ops = [
    { op: 'add', path: '/fields/System.Title', value: title },
    { op: 'add', path: '/fields/System.Description', value: description },
    { op: 'add', path: '/fields/System.Tags', value: tags.join(';') }
  ];
  try {
    const res = await axios.post(url, ops, {
      headers: {
        'Content-Type': 'application/json-patch+json',
        Authorization: `Basic ${auth}`
      }
    });
    return res.data;
  } catch (err) {
    console.error('Failed to create work item:', err?.response?.data || err.message);
    return null;
  }
}

function nodeHash(node) {
  const s = `${node.target?.join(',') || ''}|${node.html || ''}|${node.failureSummary || ''}`;
  return crypto.createHash('sha1').update(s).digest('hex');
}

(async function main() {
  for (const v of interesting) {
    // For each node in violation, create an issue per node to give context
    for (const node of v.nodes || []) {
      const hash = nodeHash(node);
      const title = `[a11y][${v.impact}] ${v.id} — ${node.target?.[0] || 'unknown selector'}`;

      // Minimal description with instructions
      const description = `
<p><strong>Rule:</strong> ${v.id} - ${v.help}</p>
<p><strong>Impact:</strong> ${v.impact}</p>
<p><strong>HTML snippet:</strong></p>
<pre>${escapeHtml(node.html || '')}</pre>
<p><strong>Target(s):</strong> ${node.target?.join(', ')}</p>
<p><strong>Failure summary:</strong> ${node.failureSummary || ''}</p>
<p><strong>Suggested next step:</strong> Reproduce using Storybook or Playwright route and add a jest-axe or Playwright a11y test. Assign to the owning frontend team.</p>
`;

      // Optionally call LLM to generate remediation suggestion (stubbed)
      const remediation = await generateRemediationSuggestionStub(v, node);
      const fullDescription = description + '\n<hr />\n' + '<p><strong>LLM suggestion:</strong></p><pre>' + escapeHtml(remediation) + '</pre>';

      // Create Azure DevOps work item
      console.log('Creating work item for', title);
      const wi = await createWorkItem(title, fullDescription, ['accessibility', `a11y-${v.impact}`, `a11y-${hash.slice(0,8)}`]);
      if (wi) console.log('Created work item', wi.id);
    }
  }
})();

function escapeHtml(s) {
  return (s || '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
}

async function generateRemediationSuggestionStub(v, node) {
  // IMPORTANT: Replace this stub with a call to your internal LLM or remediation engine.
  // Keep payload minimal and remove any PII before sending to external services.
  return `Suggested fix for rule ${v.id}: Ensure the element has a visible label or use semantic element. Example: replace custom control with <button> and add aria-label if necessary.`;
}
