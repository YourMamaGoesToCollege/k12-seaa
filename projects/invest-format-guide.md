# INVEST Format Guide for User Story Creation

## Overview

The INVEST acronym represents six key characteristics that make user stories effective and manageable in Agile development. This format ensures work items are well-defined, actionable, and deliver value to stakeholders.

## The INVEST Principles

### **I - Independent**

**Definition:** User stories should be self-contained and not dependent on other stories being completed first.

**Why It Matters:**
- Allows flexible prioritization
- Enables parallel development by multiple teams
- Reduces complexity in sprint planning
- Minimizes blocking issues

**Example from K12-SEAA:**

❌ **Poor (Dependent):**
- Story 1: "As a parent, I want to create an account"
- Story 2: "As a parent, I want to log in" (depends on Story 1 being deployed)

✅ **Good (Independent):**
- Story 1: "As a parent, I want to create an account and log in for the first time"
- Story 2: "As a returning parent, I want to log in to access my ESA+ account"

**Practical Tips:**
- Avoid "Part 1" and "Part 2" stories
- If dependencies exist, consider combining stories or reordering
- Use feature toggles to deploy incomplete features safely

---

### **N - Negotiable**

**Definition:** User stories are not rigid contracts. Details can be discussed, refined, and adjusted during development.

**Why It Matters:**
- Encourages collaboration between product owners and developers
- Allows for creative solutions
- Adapts to changing requirements or new insights
- Focuses on the "what" and "why" rather than the "how"

**Example from K12-SEAA:**

❌ **Poor (Too Prescriptive):**
```
As an admin, I want a dropdown menu with exactly 15 options
displayed alphabetically, using a blue color (#0066CC), positioned
in the top-right corner, that opens downward with a fade animation
lasting 300ms.
```

✅ **Good (Negotiable):**
```
As an admin, I want to filter ESA+ applications by status
so that I can efficiently manage my workflow.

Acceptance Criteria:
- Can filter by: Pending, Approved, Rejected, Under Review
- Filter selections persist during the session
- Clear indication of active filters
```

**Practical Tips:**
- Write the story with the problem, not the solution
- Include acceptance criteria, but leave implementation details flexible
- Discuss technical approaches during sprint planning or refinement
- Be open to alternative solutions that achieve the same goal

---

### **V - Valuable**

**Definition:** Every story must deliver clear value to users, stakeholders, or the business.

**Why It Matters:**
- Ensures development effort is purposeful
- Helps prioritize work based on impact
- Keeps team motivated by delivering meaningful results
- Reduces "nice-to-have" features that drain resources

**Example from K12-SEAA:**

❌ **Poor (No Clear Value):**
```
As a developer, I want to refactor the database connection layer
to use a factory pattern.
```

✅ **Good (Clear Value):**
```
As a parent, I want to receive email notifications when my
ESA+ application status changes so that I stay informed without
having to log in repeatedly.

Business Value: Reduces support calls by 30% and improves
parent satisfaction.
```

**Practical Tips:**
- Always start with a user role: "As a [role]..."
- Clearly state the benefit: "...so that [value]"
- If you can't articulate value, question whether the story is needed
- Technical stories can provide value by reducing risk or enabling future features

**Value Categories:**
1. **Direct User Value** - Features users interact with (applications, dashboards)
2. **Business Value** - Operational efficiency, cost reduction, compliance
3. **Technical Value** - Performance, security, maintainability
4. **Enabler Value** - Infrastructure or architecture that enables future features

---

### **E - Estimable**

**Definition:** The development team must be able to estimate the relative size or effort required to complete the story.

**Why It Matters:**
- Essential for sprint planning and capacity management
- Helps identify unclear or overly complex requirements
- Enables realistic commitments and deadlines
- Facilitates velocity tracking

**Example from K12-SEAA:**

❌ **Poor (Not Estimable):**
```
As an admin, I want the system to handle all ESA+ workflow scenarios.
```
*Too vague - team cannot estimate without more detail*

✅ **Good (Estimable):**
```
As an admin, I want to approve or reject an ESA+ application
so that families receive timely decisions.

Acceptance Criteria:
- Display application details (student, household, income verification)
- Provide "Approve" and "Reject" buttons
- Require rejection reason when rejecting
- Send automated email notification upon decision
- Update application status in database
```

**Common Estimation Blockers:**
1. **Insufficient Requirements** - Needs refinement session
2. **Technical Unknowns** - Requires research spike
3. **External Dependencies** - Identify dependencies, estimate separately
4. **Too Large** - Break into smaller stories

**Practical Tips:**
- Use relative sizing (story points) rather than hours
- If estimate varies widely among team members, discuss assumptions
- Create "spike" stories for research/investigation (time-boxed)
- Aim for stories that are 2-5 days of effort

---

### **S - Small**

**Definition:** Stories should be small enough to complete within a single sprint (typically 1-2 weeks).

**Why It Matters:**
- Provides faster feedback
- Reduces risk of incomplete work at sprint end
- Makes progress more visible
- Easier to test and deploy
- Simplifies estimation accuracy

**Example from K12-SEAA:**

❌ **Poor (Too Large - Epic):**
```
As a parent, I want to apply for ESA+ funding.
```
*This would take multiple sprints and should be an epic*

✅ **Good (Right-Sized Stories):**

**Epic:** ESA+ Application Process

**Stories:**
1. "As a parent, I want to provide household income information on the application"
2. "As a parent, I want to add student information (name, DOB, school) to the application"
3. "As a parent, I want to upload supporting documents for income verification"
4. "As a parent, I want to review and submit my completed application"
5. "As a parent, I want to save my application as draft and return later"

**Sizing Guidelines:**
- **Too Small (< 1 day):** Might be a task, not a story
- **Just Right (2-5 days):** Perfect for sprint work
- **Too Large (> 1 week):** Should be split or is actually an epic

**Splitting Strategies:**

1. **By Workflow Steps**
   - Registration → Profile → Application → Review → Submit

2. **By CRUD Operations**
   - Create application → Read application → Update application → Delete draft

3. **By User Roles**
   - Parent view → Admin view → School view

4. **By Business Rules**
   - Simple case (no dependents) → Complex case (multiple dependents)

5. **By Data Attributes**
   - Basic student info → Additional student info → Special needs info

6. **By Acceptance Criteria**
   - Each criterion becomes a story

---

### **T - Testable**

**Definition:** Clear acceptance criteria must exist that allow verification the story is complete and working correctly.

**Why It Matters:**
- Defines "done" unambiguously
- Enables effective QA testing
- Prevents scope creep during development
- Supports automated testing
- Provides basis for demo to stakeholders

**Example from K12-SEAA:**

❌ **Poor (Not Testable):**
```
As a parent, I want a better dashboard experience.
```
*Subjective - what does "better" mean?*

✅ **Good (Testable):**
```
As a parent, I want to see my ESA+ account balance and recent
transactions on my dashboard.

Acceptance Criteria:
✓ Display current account balance in dollars (e.g., "$5,234.00")
✓ Show last 10 transactions with date, description, and amount
✓ Display "No transactions" message if account is new
✓ Balance updates immediately after transaction approval
✓ Transactions sorted by date, most recent first
✓ Load dashboard within 2 seconds
```

**Writing Effective Acceptance Criteria:**

**Format 1 - Given/When/Then (BDD Style)**
```
Given I am a logged-in parent with an active ESA+ account
When I navigate to the dashboard
Then I see my current balance displayed prominently
And I see my last 10 transactions listed below the balance
```

**Format 2 - Checklist Style**
```
Acceptance Criteria:
✓ User can enter household size (1-20 members)
✓ System validates household size is a positive integer
✓ Error message displays if invalid input
✓ Household size saves automatically
✓ Household size persists across sessions
```

**Format 3 - Scenario-Based**
```
Scenario 1: New account with no transactions
- Dashboard shows balance of $0.00
- Message: "No transactions yet. Your account is active and ready."

Scenario 2: Active account with transactions
- Dashboard shows current balance
- Lists transactions with date, vendor, amount
- Clicking transaction shows full details
```

**Testability Checklist:**
- [ ] Can QA verify each acceptance criterion objectively?
- [ ] Are success conditions clearly defined?
- [ ] Are edge cases and error conditions covered?
- [ ] Can criteria be automated in test scripts?
- [ ] Is "done" unambiguous?

---

## Applying INVEST to K12-SEAA Project

### Sample Epic: ESA+ Application Management

**Epic Description:**
Enable families to apply for ESA+ funding, track their application status, and manage their accounts through a secure online portal.

**Breaking Down into Stories:**

#### Story 1: Household Income Entry ✅ INVEST Compliant
```
As a parent applying for ESA+, I want to enter my household income
information so that NCSEAA can determine my eligibility.

Acceptance Criteria:
- Form includes fields: gross annual income, household size, employment status
- Income validation: positive number, max $999,999
- Household size validation: 1-20 members
- Real-time validation with clear error messages
- Auto-save draft every 30 seconds
- "Save & Continue" button proceeds to next step
- Data persists if user navigates away

INVEST Check:
✓ Independent - Can be developed without other application forms
✓ Negotiable - UI/UX details flexible during development
✓ Valuable - Critical for eligibility determination
✓ Estimable - Team estimates 3 story points (2-3 days)
✓ Small - Can complete in single sprint
✓ Testable - Clear, objective acceptance criteria
```

#### Story 2: Student Information Entry ✅ INVEST Compliant
```
As a parent, I want to add student information to my ESA+
application so that NCSEAA knows which child the funding is for.

Acceptance Criteria:
- Form includes: student name, DOB, grade, school name
- DOB validation: student must be K-12 age eligible
- School dropdown populated from approved school list
- Can add multiple students (up to 5)
- Each student can be edited or removed
- Clear indication of required fields
- "Add Another Student" button for multiple children

INVEST Check:
✓ Independent - No dependency on income entry
✓ Negotiable - Number of students per form is negotiable
✓ Valuable - Required for application processing
✓ Estimable - Team estimates 5 story points (3-4 days)
✓ Small - Completable within sprint
✓ Testable - Specific validation rules and UI elements
```

---

## Common INVEST Violations and How to Fix Them

### Problem: Story is Not Independent

**Example:**
- Story A: "Build REST API endpoint for applications"
- Story B: "Build UI form to call application API"

**Solution:**
Combine into vertical slice: "As a parent, I want to submit my application via the online form"
- Includes both backend API and frontend UI
- Delivers end-to-end functionality

---

### Problem: Story is Not Negotiable (Too Technical)

**Example:**
"Implement repository pattern with Unit of Work in the data access layer using Entity Framework Core"

**Solution:**
Reframe with business value: "As a developer, I want a consistent data access pattern so that queries are testable and maintainable"
- Then negotiate the specific pattern during refinement

---

### Problem: Story Has No Clear Value

**Example:**
"Upgrade all NuGet packages to latest versions"

**Solution:**
Connect to value: "As a developer, I want to upgrade security-critical NuGet packages so that we address known vulnerabilities identified in the latest security scan"

---

### Problem: Story is Not Estimable

**Example:**
"Integrate with state residency verification system"

**Solution:**
Create a research spike first:
- Spike: "Investigate state residency API integration requirements" (time-boxed to 2 days)
- After spike, create estimable implementation stories

---

### Problem: Story is Too Large

**Example:**
"Build complete ESA+ expense tracking and reporting system"

**Solution:**
Create epic with smaller stories:
1. "Record individual expense transaction"
2. "View expense history"
3. "Generate monthly expense report"
4. "Export expenses to CSV"

---

### Problem: Story is Not Testable

**Example:**
"Improve system performance"

**Solution:**
Add specific, measurable criteria:
"As a user, I want dashboard to load within 2 seconds so that I have a responsive experience"
- Acceptance Criteria: Dashboard loads in < 2 seconds with 10 concurrent users

---

## Tools and Templates

### Story Template
```markdown
**Title:** [Concise description - 5-10 words]

**As a** [user role]
**I want** [functionality]
**So that** [business value/benefit]

**Acceptance Criteria:**
- [ ] Criterion 1 (testable condition)
- [ ] Criterion 2 (testable condition)
- [ ] Criterion 3 (testable condition)

**Technical Notes:**
[Optional: API endpoints, database tables, external dependencies]

**Definition of Done:**
- [ ] Code complete and peer reviewed
- [ ] Unit tests written and passing
- [ ] Integration tests passing
- [ ] Acceptance criteria verified by QA
- [ ] Deployed to staging environment
- [ ] Accepted by Product Owner
```

### Story Refinement Checklist
- [ ] Story follows "As a [role], I want [function], so that [value]" format
- [ ] INVEST criteria met (Independent, Negotiable, Valuable, Estimable, Small, Testable)
- [ ] Acceptance criteria are clear and testable
- [ ] Story is estimated by development team
- [ ] Dependencies identified and documented
- [ ] Technical approach discussed (if needed)
- [ ] Priority assigned by Product Owner

---

## Integration with AI Tools

As outlined in the [AI Business Case](../AI%20Business%20Case.pdf), leveraging AI tools can accelerate INVEST-compliant story creation:

### Using Gemini for Requirements Capture
1. **Input:** High-level feature description or meeting notes
2. **Output:** Structured epic and user stories in INVEST format
3. **Human Review:** Validate accuracy, adjust priorities, refine acceptance criteria

### Using GitHub Copilot for Implementation
1. Stories provide clear requirements
2. Copilot generates code based on story acceptance criteria
3. Developers focus on business logic rather than boilerplate
4. Human oversight ensures quality and security

### Benefits
- 30% reduction in requirements drafting time
- Consistent story format across all team members
- Clear acceptance criteria accelerate development
- Improved communication between business and technical teams

---

## References

- [AI Business Case](../AI%20Business%20Case.pdf) - Gemini usage for INVEST story creation
- [Comprehensive Implementation Plan](../stakeholder-decision/comprehensive-implementation-plan.md)
- [Presentation Deck](../stakeholder-decision/presentation-deck.md)

---

**Author:** Technical Architecture Team  
**Last Updated:** October 2025  
**Version:** 1.0  
**Classification:** Internal - Team Distribution
