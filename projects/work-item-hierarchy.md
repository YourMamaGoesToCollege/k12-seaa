# Work Item Hierarchy Guide

## Overview

Understanding the hierarchy of work items is critical for effective project planning and Agile execution. This document explains how to structure work from strategic initiatives down to implementation tasks, with specific examples from the K12-SEAA modernization project.

## The Hierarchy Pyramid

```
┌─────────────────────────────────────────────┐
│         INITIATIVE (Strategic Goal)          │  Duration: 6-18 months
│            1-3 per organization              │  Example: "Modernize K12-SEAA Platform"
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│           EPIC (Large Feature Set)           │  Duration: 2-6 months
│              3-10 per initiative             │  Example: "ESA+ Application Management"
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│         FEATURE (Product Capability)         │  Duration: 2-4 weeks
│                5-15 per epic                 │  Example: "Income Verification"
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│        USER STORY (Requirement/Need)         │  Duration: 2-5 days
│               5-20 per feature               │  Example: "Enter household income"
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│       TASK (Implementation Activity)         │  Duration: 2-8 hours
│              3-10 per user story             │  Example: "Create income API endpoint"
└─────────────────────────────────────────────┘
```

---

## Level 1: Initiative

### Definition
A strategic business goal or objective that drives significant organizational change or value delivery. Initiatives typically span multiple quarters and involve multiple teams.

### Characteristics
- **Duration:** 6-18 months
- **Scope:** Portfolio-level planning
- **Owner:** Executive leadership or PMO
- **Measurement:** Business outcomes (revenue, cost savings, compliance, customer satisfaction)
- **Budget:** $500K - $5M+ typically

### K12-SEAA Example

**Initiative: Modernize K12 Student Assistance Platform**

**Business Context:**
Replace legacy systems with modern, secure, cloud-based platform to serve North Carolina families seeking education assistance.

**Success Metrics:**
- Launch by May 1, 2026 (hard deadline)
- Process 50,000+ applications annually
- 99.9% uptime
- Reduce application processing time by 40%
- Achieve 90% parent satisfaction rating
- Full compliance with NC state regulations

**Budget:** $2.5M - $3M

**Key Stakeholders:**
- CFO leadership
- NCSEAA leadership
- IT Department
- Parent users
- Schools and providers
- State compliance officers

**Strategic Alignment:**
- Supports digital transformation goals
- Enhances citizen services
- Improves operational efficiency
- Reduces technical debt

---

## Level 2: Epic

### Definition
A large body of work that can be broken down into smaller user stories. Epics typically represent a major feature set or functional area of the product.

### Characteristics
- **Duration:** 2-6 months
- **Scope:** Multiple sprints
- **Owner:** Product Owner or Product Manager
- **Measurement:** Feature completion, user adoption
- **Stories:** 10-50 user stories typically

### K12-SEAA Examples

#### Epic 1: ESA+ Application & Enrollment
**Description:**
Enable families to apply for Education Student Accounts Plus (ESA+) funding through an online portal, including household information, student details, income verification, and document uploads.

**Value Proposition:**
- Families can apply 24/7 without visiting offices
- Reduce paper-based processing by 90%
- Accelerate application decisions from weeks to days

**Acceptance Criteria:**
- ✓ Parents can create account and log in securely
- ✓ Complete application includes all required sections
- ✓ Supporting documents uploaded and verified
- ✓ Application status visible in real-time
- ✓ Email notifications at key milestones
- ✓ Admin can review, approve, or reject applications

**Related Epics:**
- ESA+ Account Management
- ESA+ Expense Tracking
- ESA+ Renewal Processing

---

#### Epic 2: Opportunity Scholarship Management
**Description:**
Complete workflow for Opportunity Scholarship program from application through award distribution, including income verification, school verification, and payment processing.

**Value Proposition:**
- Streamlined scholarship process for low-income families
- Automated eligibility checks
- Integration with payment systems (ClassWallet)

**Acceptance Criteria:**
- ✓ Income-based eligibility calculated automatically
- ✓ School verification integrated
- ✓ Award amounts calculated per tier/grade
- ✓ Payment processed within required timeframes
- ✓ Compliance reporting automated

---

#### Epic 3: Admin Portal & Operations
**Description:**
Comprehensive admin tools for NCSEAA staff to process applications, manage awards, handle exceptions, generate reports, and monitor program compliance.

**Value Proposition:**
- Centralized operational dashboard
- Automated workflows reduce manual effort by 60%
- Real-time reporting for decision-making

**Acceptance Criteria:**
- ✓ Dashboard shows key metrics (applications, awards, disbursements)
- ✓ Queue management for pending applications
- ✓ Exception handling workflows
- ✓ Audit trail for all actions
- ✓ Custom report generation
- ✓ User access control by role

---

## Level 3: Feature

### Definition
A specific product capability or functional component that delivers value to users. Features are smaller than epics but larger than user stories.

### Characteristics
- **Duration:** 2-4 weeks (1-2 sprints)
- **Scope:** Multiple user stories
- **Owner:** Product Owner
- **Measurement:** Feature functionality complete, acceptance criteria met
- **Stories:** 5-15 user stories typically

### K12-SEAA Examples

#### Feature 1: Income Verification
**Epic:** ESA+ Application & Enrollment  
**Description:** Capture, validate, and verify household income information for eligibility determination.

**User Stories:**
1. As a parent, I want to enter my household income details
2. As a parent, I want to upload W2s and pay stubs for verification
3. As an admin, I want to review income documentation
4. As an admin, I want to approve or request additional documentation
5. As a parent, I want to see my income verification status
6. As a system, I want to calculate income against eligibility thresholds

---

#### Feature 2: Student Information Management
**Epic:** ESA+ Application & Enrollment  
**Description:** Collect and maintain student demographic and enrollment information.

**User Stories:**
1. As a parent, I want to add student information (name, DOB, grade)
2. As a parent, I want to add multiple students to one application
3. As a parent, I want to edit student information before submission
4. As a parent, I want to select the student's school from approved list
5. As an admin, I want to verify student enrollment status
6. As a system, I want to validate student age against grade level

---

#### Feature 3: Document Upload & Management
**Epic:** ESA+ Application & Enrollment  
**Description:** Secure upload, storage, and retrieval of supporting documents.

**User Stories:**
1. As a parent, I want to upload PDF or image documents
2. As a parent, I want to see which documents are required vs optional
3. As a parent, I want to see upload progress and confirmation
4. As an admin, I want to view all uploaded documents for an application
5. As an admin, I want to request specific missing documents
6. As a system, I want to scan uploads for viruses
7. As a system, I want to enforce file size and type restrictions

---

## Level 4: User Story

### Definition
A requirement or need expressed from the user's perspective, following the "As a [role], I want [function], so that [value]" format. User stories should follow INVEST principles.

### Characteristics
- **Duration:** 2-5 days
- **Scope:** Single sprint
- **Owner:** Development Team
- **Measurement:** Acceptance criteria met, story points completed
- **Tasks:** 3-10 implementation tasks typically

### K12-SEAA Examples

See [INVEST Format Guide](invest-format-guide.md) for detailed user story examples and best practices.

#### Example Story 1
```
Title: Enter Household Income Information

As a parent applying for ESA+, I want to enter my household income
information so that NCSEAA can determine my eligibility.

Acceptance Criteria:
- Form includes: gross annual income, household size, employment status
- Income validation: positive number, max $999,999
- Household size validation: 1-20 members
- Real-time validation with clear error messages
- Auto-save draft every 30 seconds
- "Save & Continue" proceeds to next step

Story Points: 3
Priority: High
Dependencies: None
```

---

## Level 5: Task

### Definition
A specific technical activity or implementation step required to complete a user story. Tasks are assigned to individual developers and tracked during sprint execution.

### Characteristics
- **Duration:** 2-8 hours
- **Scope:** Portion of a user story
- **Owner:** Individual developer
- **Measurement:** Task completion (done/not done)
- **Granularity:** Specific enough for daily stand-ups

### K12-SEAA Examples

**User Story:** Enter Household Income Information

**Tasks:**
1. Create `IncomeInformation` TypeScript interface/model
2. Design income entry form component in Angular
3. Implement form validation rules (client-side)
4. Create REST API endpoint `POST /api/applications/income`
5. Implement server-side validation in .NET controller
6. Create `Income` entity and database migration
7. Add auto-save functionality (debounced)
8. Write unit tests for validation logic
9. Write integration tests for API endpoint
10. Update documentation

**Task Assignment Example:**
```
Task: Create REST API endpoint POST /api/applications/income
Assigned To: Jane Developer
Estimated Hours: 4
Status: In Progress
Blockers: None
Notes: Using existing ApplicationController pattern
```

---

## Extraction Process: From Initiatives to Tasks

### Step 1: Identify Strategic Initiatives

**Sources:**
- Executive strategic plans
- Business case documents
- Compliance requirements
- Stakeholder vision workshops

**Questions to Ask:**
- What are our top 3-5 business priorities this year?
- What problems are we solving for users?
- What regulatory or compliance needs exist?
- What technical debt must be addressed?

**K12-SEAA Example:**
From stakeholder meetings and [AI Business Case](../AI%20Business%20Case.pdf):
- Initiative: "Modernize K12 Student Assistance Platform"

---

### Step 2: Break Initiatives into Epics

**Sources:**
- Feature inventory (110+ features documented in [Comprehensive Implementation Plan](../stakeholder-decision/comprehensive-implementation-plan.md))
- User journey maps
- Domain-driven design analysis
- Existing system functionality audit

**Questions to Ask:**
- What major functional areas exist?
- What user workflows need to be supported?
- What are the logical groupings of features?

**K12-SEAA Example:**
From the 110+ feature inventory, we identified 6 capability areas:
1. Household & Student Management (15+ features)
2. School Management (20+ features)
3. Provider Management (12+ features)
4. Admin Portal Operations (30+ features)
5. Payment & Financial Systems (18+ features)
6. Verification & Compliance (15+ features)

Each capability area becomes an Epic or set of related Epics.

---

### Step 3: Define Features within Epics

**Sources:**
- Epic acceptance criteria
- User personas and scenarios
- Business rules documentation
- Process flow diagrams

**Questions to Ask:**
- What specific capabilities must users have?
- What business rules govern this area?
- What data is required?
- What integrations are needed?

**K12-SEAA Example:**
Epic: ESA+ Application & Enrollment
- Feature 1: Account Creation & Authentication
- Feature 2: Household Information Capture
- Feature 3: Student Information Management
- Feature 4: Income Verification
- Feature 5: Document Upload & Management
- Feature 6: Application Review & Submission
- Feature 7: Status Tracking & Notifications

---

### Step 4: Create User Stories for Features

**Sources:**
- Feature requirements
- User acceptance criteria
- User feedback/research
- Domain experts

**Process:**
1. Run collaborative story-writing workshops
2. Use AI tools (Gemini) to draft initial stories (as per AI Business Case)
3. Refine stories with development team
4. Validate stories meet INVEST criteria
5. Add acceptance criteria
6. Estimate story points

**K12-SEAA Example:**
Feature: Income Verification
- Story 1: Enter household income details
- Story 2: Upload income documentation
- Story 3: Review income verification (admin)
- Story 4: Request additional documentation (admin)
- Story 5: View income verification status (parent)
- Story 6: Calculate eligibility based on income

---

### Step 5: Decompose Stories into Tasks

**Sources:**
- Technical architecture documentation
- Development standards
- Definition of Done checklist

**Process:**
1. Development team breaks stories into technical tasks during sprint planning
2. Tasks should be small enough to complete in 2-8 hours
3. Include tasks for: coding, testing, documentation, code review

**K12-SEAA Example:**
Story: Enter household income details
- Task 1: Create data model
- Task 2: Design UI component
- Task 3: Implement validation
- Task 4: Create API endpoint
- Task 5: Database migration
- Task 6: Unit tests
- Task 7: Integration tests
- Task 8: Documentation

---

## Using AI for Work Item Extraction

Per the [AI Business Case](../AI%20Business%20Case.pdf), Gemini can accelerate this process:

### Input to Gemini
```
High-level feature description: "Families need to apply for ESA+ 
funding by providing household information, student details, and 
income verification. Applications must be reviewed by NCSEAA staff 
who can approve or reject with reasons."
```

### Gemini Output (Draft)
```
EPIC: ESA+ Application Management

Feature 1: Application Form Completion
- Story 1: As a parent, I want to create an account...
- Story 2: As a parent, I want to enter household information...
- Story 3: As a parent, I want to add student details...
[continues with full INVEST-compliant stories]

Feature 2: Application Review & Decision
- Story 1: As an admin, I want to view pending applications...
- Story 2: As an admin, I want to approve applications...
[continues...]
```

### Human Review & Refinement
1. Validate stories align with business rules
2. Adjust priorities based on stakeholder input
3. Add technical constraints or dependencies
4. Refine acceptance criteria based on domain knowledge
5. Estimate and sequence for sprint planning

**Benefit:** 30% reduction in requirements drafting time (per AI Business Case)

---

## Practical Guidelines

### Initiative Guidelines
- Limit to 1-3 active initiatives per organization
- Each initiative should have executive sponsor
- Define clear success metrics and timelines
- Allocate dedicated budget and resources

### Epic Guidelines
- Epics should deliver cohesive functionality
- Each epic should have clear acceptance criteria
- Avoid epics that span multiple initiatives
- Estimate at high level (T-shirt sizes: S/M/L)
- Track epic progress with burn-down charts

### Feature Guidelines
- Features should be independently valuable
- Sequence features to enable vertical slices
- Consider dependencies when prioritizing
- Aim for 2-4 week delivery cycles

### User Story Guidelines
- Follow INVEST principles (see [INVEST Format Guide](invest-format-guide.md))
- Include clear acceptance criteria
- Estimate using story points
- Ensure stories are testable
- Size for 2-5 day completion

### Task Guidelines
- Tasks are technical implementation steps
- Assign to individual developers
- Track in daily stand-ups
- Include testing and documentation tasks
- Update status frequently (todo/in-progress/done)

---

## Tools and Templates

### Initiative Template
```markdown
# Initiative: [Name]

## Business Context
[Why this initiative matters to the organization]

## Success Metrics
- Metric 1: [measurable outcome]
- Metric 2: [measurable outcome]
- Metric 3: [measurable outcome]

## Timeline
Start Date: [date]
Target Completion: [date]
Milestones: [key milestones]

## Budget
Estimated: $[amount]
Approved: $[amount]

## Key Stakeholders
- Executive Sponsor: [name]
- Product Owner: [name]
- Technical Lead: [name]

## Related Epics
- Epic 1: [name]
- Epic 2: [name]
```

### Epic Template
```markdown
# Epic: [Name]

## Description
[What this epic delivers]

## Value Proposition
[Why this matters to users/business]

## Acceptance Criteria
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Related Features/Stories
- Feature 1: [name]
- Feature 2: [name]

## Dependencies
[Other epics or external dependencies]

## Target Release
[Quarter or date]
```

---

## K12-SEAA Complete Example

### Initiative
**Modernize K12 Student Assistance Platform**

### Epic
**ESA+ Application & Enrollment** (One of multiple epics)

### Feature
**Income Verification** (One of 7 features in this epic)

### User Story
**Enter Household Income Information** (One of 6 stories in this feature)

### Tasks
1. Create `IncomeInformation` model
2. Design income entry form
3. Implement form validation
4. Create API endpoint
5. Database migration
6. Auto-save functionality
7. Unit tests
8. Integration tests
9. Documentation
10. Code review

### Sprint Planning
- Sprint 5, Week 1: Tasks 1-4
- Sprint 5, Week 2: Tasks 5-10

---

## References

- [INVEST Format Guide](invest-format-guide.md) - Detailed user story guidance
- [AI Business Case](../AI%20Business%20Case.pdf) - AI-assisted requirements extraction
- [Comprehensive Implementation Plan](../stakeholder-decision/comprehensive-implementation-plan.md) - Complete feature inventory
- [Presentation Deck](../stakeholder-decision/presentation-deck.md) - Implementation roadmap and phases

---

**Author:** Technical Architecture Team  
**Last Updated:** October 2025  
**Version:** 1.0  
**Classification:** Internal - Team Distribution
