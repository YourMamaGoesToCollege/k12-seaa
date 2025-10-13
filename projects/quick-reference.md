# Project Planning Quick Reference Card

## INVEST Principles (1-Page Summary)

### User Story Format
```
As a [user role]
I want [functionality]
So that [business value]
```

### INVEST Checklist

✅ **I - Independent**
- Can be developed in any order
- No blocking dependencies on other stories
- If dependencies exist, combine or reorder

✅ **N - Negotiable**
- Focus on "what" and "why", not "how"
- Implementation details are flexible
- Discuss solutions during sprint planning

✅ **V - Valuable**
- Delivers clear value to users, business, or technical capability
- Always articulate the benefit
- If no value, question if story is needed

✅ **E - Estimable**
- Team can estimate relative effort
- If not estimable: needs refinement or spike
- Use story points, not hours

✅ **S - Small**
- Completable within 2-5 days (one sprint)
- Can be demoed to stakeholders
- If too large, split using CRUD, workflow, or role

✅ **T - Testable**
- Clear, objective acceptance criteria
- Use Given/When/Then or checklist format
- QA can verify without ambiguity

---

## Work Item Hierarchy

```
Initiative (6-18 months)
    ↓
Epic (2-6 months, 10-50 stories)
    ↓
Feature (2-4 weeks, 5-15 stories)
    ↓
User Story (2-5 days, INVEST format)
    ↓
Task (2-8 hours, implementation)
```

---

## Extraction Process (5 Steps)

### Step 1: Identify Initiatives
**Sources:** Business cases, strategic plans, compliance mandates  
**Output:** 1-3 strategic goals with success metrics  
**K12-SEAA Example:** "Modernize K12 Student Assistance Platform"

### Step 2: Break into Epics
**Sources:** Feature inventory, user journeys, domain analysis  
**Output:** 3-10 large feature sets per initiative  
**K12-SEAA Example:** "ESA+ Application & Enrollment" (20+ features)

### Step 3: Define Features
**Sources:** Epic requirements, business rules, workflows  
**Output:** 5-15 capabilities per epic  
**K12-SEAA Example:** "Income Verification" (6 stories)

### Step 4: Write User Stories
**Sources:** Feature requirements, acceptance criteria  
**Output:** 5-20 INVEST-compliant stories per feature  
**K12-SEAA Example:** "As a parent, I want to enter household income..."

### Step 5: Create Tasks
**Sources:** Story technical requirements  
**Output:** 3-10 implementation tasks per story  
**K12-SEAA Example:** "Create income API endpoint" (2 hours)

---

## Using AI Tools

### Gemini (Requirements Capture)

**Input Template:**
```
Context: [Project domain]
Source: [High-level description]
Output Format: INVEST-compliant user stories
Task: Generate stories for [feature name]
Include: Edge cases, validation rules, Given/When/Then criteria
```

**Benefit:** 30% reduction in requirements drafting time

**Human Review Required:**
- Validate business rules
- Add technical constraints
- Adjust priorities
- Estimate story points

---

### GitHub Copilot (Code Generation)

**Use Cases:**
- Code generation (20-40% productivity boost)
- Unit test generation
- Documentation generation
- Code refactoring suggestions

**Benefit:** 4,267% ROI based on K12-SEAA analysis

**Mandatory:** 100% human review before merge

---

## Common Story Splitting Strategies

1. **By Workflow Steps**
   - Registration → Profile → Application → Review → Submit

2. **By CRUD Operations**
   - Create → Read → Update → Delete

3. **By User Roles**
   - Parent view → Admin view → School view

4. **By Business Rules**
   - Simple case → Complex case with exceptions

5. **By Data Attributes**
   - Basic info → Additional info → Special cases

6. **By Acceptance Criteria**
   - Each criterion becomes separate story

---

## Acceptance Criteria Formats

### Format 1: Given/When/Then
```
Given: [initial state]
When: [action occurs]
Then: [expected outcome]
```

### Format 2: Checklist
```
- [ ] Criterion 1 (specific, testable)
- [ ] Criterion 2
- [ ] Criterion 3
```

### Format 3: Scenarios
```
Scenario 1: Happy path
- Expected behavior

Scenario 2: Edge case
- Expected behavior
```

---

## Story Sizing Guide

| Size | Duration | Description | Example |
|------|----------|-------------|---------|
| 1 | 2-4 hours | Trivial change | Update label text |
| 2 | 4-8 hours | Simple story | Add new field to form |
| 3 | 1-2 days | Standard story | Create basic CRUD page |
| 5 | 2-3 days | Complex story | Implement validation workflow |
| 8 | 3-5 days | Very complex | Integration with external API |
| 13 | 5+ days | Too large! | Split into smaller stories |

**Rule of Thumb:** Most stories should be 2-5 points

---

## Definition of Done Checklist

- [ ] Code complete and committed to feature branch
- [ ] Unit tests written and passing (>80% coverage)
- [ ] Integration tests passing
- [ ] Code reviewed and approved by peer
- [ ] All acceptance criteria verified by QA
- [ ] No critical or high-severity bugs
- [ ] Deployed to staging environment
- [ ] Demo'd to Product Owner (accepted)
- [ ] Documentation updated (if applicable)
- [ ] Merged to main branch

---

## Story Refinement Checklist

**Before Story is "Ready":**

- [ ] Follows "As a [role], I want [function], so that [value]" format
- [ ] INVEST criteria validated (I-N-V-E-S-T)
- [ ] Acceptance criteria are specific and testable
- [ ] Estimated by development team (story points)
- [ ] Priority assigned by Product Owner
- [ ] Dependencies documented
- [ ] UI/UX mockups available (if needed)
- [ ] Technical approach discussed
- [ ] Product Owner available during sprint

---

## K12-SEAA Context

### Project Overview
- **Timeline:** 28 weeks (Oct 15, 2025 - May 1, 2026)
- **Scope:** 110+ features across 6 capability areas
- **Team:** 6-8 FTE
- **Deadline:** May 1, 2026 (HARD regulatory deadline)

### 6 Capability Areas (Epics)
1. Household & Student Management (15+ features)
2. School Management (20+ features)
3. Provider Management (12+ features)
4. Admin Portal Operations (30+ features)
5. Payment & Financial Systems (18+ features)
6. Verification & Compliance (15+ features)

### Key Programs
- **ESA+** (Education Student Accounts Plus)
- **Opportunity Scholarship**
- **Grants**
- **Loans**

### Implementation Phases (9 Phases)
- **Phase 1-6:** Development (Weeks 1-22)
- **Phase 7-8:** Testing & UAT (Weeks 23-26)
- **Phase 9:** Production Launch (Weeks 27-28)

---

## Templates (Copy & Paste)

### User Story Template
```markdown
## Story: [Title]

**As a** [user role]
**I want** [functionality]
**So that** [business value]

### Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

### Technical Notes
- API: [endpoints]
- Database: [tables]
- Dependencies: [systems]

### Definition of Done
- [ ] Code complete and reviewed
- [ ] Tests written and passing
- [ ] Acceptance criteria verified
- [ ] Demo'd to Product Owner

**Story Points:** [1, 2, 3, 5, 8]
**Priority:** [High, Medium, Low]
**Sprint:** [Sprint #]
```

### Epic Template
```markdown
# Epic: [Name]

## Value Proposition
[What users/business gains]

## Acceptance Criteria
- [ ] High-level outcome 1
- [ ] High-level outcome 2

## Features
1. Feature: [name]
2. Feature: [name]

## Dependencies
[Other epics or external systems]

**Target Release:** [Quarter/Date]
**Estimated Duration:** [Weeks]
```

---

## AI Business Case Summary

### GitHub Copilot for Business
- **Cost:** $30/user/month ($2,880/year for 8 developers)
- **Benefit:** 20-40% productivity increase
- **ROI:** 4,267%
- **Security:** No training on client data, enterprise-grade

### Randstad Gemini Instance
- **Cost:** $0 (absorbed by Randstad)
- **Benefit:** 30% reduction in requirements drafting time
- **Use Case:** INVEST-compliant story generation
- **Security:** Secured data boundary, no external LLM

### Recommendation
✅ **APPROVE** both tools  
✅ Implement with 100% human oversight  
✅ Track metrics monthly  
✅ Review quarterly  

---

## Key Principles to Remember

1. **Start with Why** - Always articulate business value first
2. **Top-Down Planning** - Initiative → Epic → Feature → Story → Task
3. **User-Centric Stories** - Focus on user needs, not technical implementation
4. **Keep Stories Small** - 2-5 days maximum
5. **Make Testable** - Clear acceptance criteria are non-negotiable
6. **AI is a Tool** - Accelerates drafting, but humans validate
7. **Iterate and Refine** - First pass won't be perfect
8. **Collaborate** - Stories are conversation starters, not contracts

---

## Resources

- **[Full INVEST Guide](invest-format-guide.md)** - Comprehensive principles explanation
- **[Work Item Hierarchy](work-item-hierarchy.md)** - Detailed structure guide
- **[Project Planning Guide](project-planning-guide.md)** - Step-by-step extraction
- **[AI Business Case Review](ai-business-case-review.md)** - Detailed AI tool analysis
- **[Comprehensive Implementation Plan](../stakeholder-decision/comprehensive-implementation-plan.md)** - K12-SEAA roadmap

---

## Emergency Contact Points

**Project Manager:** [Name]  
**Product Owner:** [Name]  
**Technical Lead:** [Name]  
**Scrum Master:** [Name]

---

**Version:** 1.0  
**Last Updated:** October 2025  
**Classification:** Internal - Team Distribution

---

### Print This Page for Your Desk! 📋
