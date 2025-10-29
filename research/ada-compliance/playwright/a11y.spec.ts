import { test, expect } from '@playwright/test';
import AxeBuilder from '@axe-core/playwright';

// Example Playwright accessibility test using axe-core
// Run with: npx playwright test research/ada-compliance/playwright/a11y.spec.ts

test.describe('Accessibility checks', () => {
  test('Home / critical flows have no violations', async ({ page }) => {
    // Replace with your app preview URL or local dev server
    const url = process.env.PREVIEW_URL || 'http://localhost:4200';
    await page.goto(url, { waitUntil: 'networkidle' });

    // Run axe
    const accessibilityScanResults = await new AxeBuilder({ page }).analyze();

    // Save a11y JSON for CI artifact processing
    const fs = require('fs');
    const path = require('path');
    const outDir = process.env.AXE_OUTDIR || 'research/ada-compliance/artifacts';
    if (!fs.existsSync(outDir)) fs.mkdirSync(outDir, { recursive: true });
    const outPath = path.join(outDir, `a11y-report-${Date.now()}.json`);
    fs.writeFileSync(outPath, JSON.stringify(accessibilityScanResults, null, 2));
    console.log('Saved axe report to', outPath);

    // Fail on any critical/serious violations
    const blocking = (accessibilityScanResults.violations || []).filter((v: any) => v.impact === 'critical' || v.impact === 'serious');
    expect(blocking.length, `Critical/Serious accessibility violations: ${blocking.length}`).toBe(0);
  });
});
