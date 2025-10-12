---
title: "College Find Inc + N. Carolina SEAA - DDD research ESA+ OS"
source: "https://chatgpt.com/g/g-p-68dbcaa404cc8191a7e63a2b17ba6164/c/68e906f5-b06c-832f-8edc-fbd7b9e7bbcb"
---

**You:**

Narrow DDD Research

Do you have enough information in this project and attachments and other chats to go through the CFI website and the North Carolina SEA a website to extract domain specific items. What I mean by this is that I need all of the domain driven design details to understand the K12 process. Later I will create diagrams and show all the different parts and pieces of the domain and their relationships using their terminology. I need this research to focus on ESA+ and Opportunity Scholarships (OS) only - no other programs (e.g., loans, 529, etc.)

Many times I use a noun/verb exercise where I extract all the nouns which are the what parked in pieces of a domain. Please categorize the nouns into logical domain groups. Provide a "description" from a business context and/or use-case perspective. Provide the web page source URL as part of the documentation (used to do further research). Verify that these are real domain items. Please also identify aggregates (DDD) and include these items in our initial domain model.

The verbs indicate some actions or events or even processes or workflows, etc. that use or consume the what the nouns, etc. Please identify the "action" and/or "workflow" the verbs represent or belong to. Please categorize the actions and/or workflows - provide details and their relationship to domain items.

Do you have the URLs needed? Are you capable of looking at all of the webpage or pages of a website if you’re given the entry point searching through all the link etc. do you have that capability like deep research I mean deep deep research.

* * *

**ChatGPT:**

I can absolutely start the deep domain-driven design (DDD) research on ESA+ and Opportunity Scholarship (OS) for NC. It’s a pain, but I signed up for this. Here’s how I’d approach and what I already found. (We’ll refine and expand together.)

* * *

## What I can do (and limitations)

* I _can_ crawl and parse public web pages (via search) to extract nouns, verbs, domain concepts, business rules, workflows, etc.

* I _cannot_ access private internal systems, unpublished docs, or anything behind authentication unless you supply it.

* The public NCSEAA / K12 site is already giving good domain clues; I’ll use that as seed.

* If you can provide attachments (PDFs, internal rules, statutes, existing docs) I can ingest them too.

* Deep research is iterative: I’ll iterate extracting domain items, then pass to you for validation, then refine.

So yes — I have enough to begin, though the domain model will evolve as you (or internal docs) refine.

* * *

## What I’ve found so far: Domain items, aggregates, actions/workflows (preliminary)

Below is a first pass. Expect errors, missing items, ambiguous ones. We’ll refine.

I’ll cover **ESA+** first (since you said focus on ESA+ and OS). Then I’ll touch OS where relevant and how they might overlap or differ. I’ll also note where I’m using sources.

* * *

### ESA+ domain — nouns (entities, value objects, concepts) & their descriptions

Here are candidate domain nouns (things) from the public documentation:

| Noun / Concept | Description / Business Meaning / Use Case | Notes / source URL |
| --- | --- | --- |
| Student | The child/learner for whom the scholarship/ESA+ is applied | fundamental actor |
| Family / Parent | Guardian / applicant who applies and manages the student’s scholarship | interacts via MyPortal etc |
| Eligibility Determination | Document from public school stating student has a disability and qualifies for special education services | ESA+ requires this. [k12.ncseaa.edu+2k12.ncseaa.edu+2](https://k12.ncseaa.edu/the-education-student-accounts/?utm_source=chatgpt.com) |
| Award / Scholarship | The grant / funding (ESA+ funds) assigned to a qualified student | key financial “what” |
| Program Rules / Statutes | The legal/regulatory constraints and business rules governing the program | “Program Rules and Requirements” page [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com) |
| Parent Agreement | The contract / agreement that parent must sign annually, including responsibilities | part of rules [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com) |
| MyPortal Account / MyPortal | The system interface for families/administrators to manage application, status, to-dos | seed for UI boundary [k12.ncseaa.edu+2k12.ncseaa.edu+2](https://k12.ncseaa.edu/the-education-student-accounts/?utm_source=chatgpt.com) |
| Award Offer / Notification | The act of telling a family a scholarship is awarded (or not) | in awarding workflow [k12.ncseaa.edu+1](https://k12.ncseaa.edu/the-education-student-accounts/awarding-process/?utm_source=chatgpt.com) |
| Acceptance / Decline | Parent’s choice to accept or reject the award | in “next steps” page [k12.ncseaa.edu](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/?utm_source=chatgpt.com) |
| Eligible School / School (Direct Payment / Reimbursement / Home School) | The schools or schooling modality where the student will be enrolled | school choice domain. [NCSEAA+2k12.ncseaa.edu+2](https://www.ncseaa.edu/8331-2/?utm_source=chatgpt.com) |
| Provider / Service Provider | Tutors, therapists, transportation providers that can accept ESA+ payments | there is an enrollment process for providers. [k12.ncseaa.edu+1](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/service-providers/enrollment/?utm_source=chatgpt.com) |
| Provider Enrollment / Credential | The process and credentials for a provider to qualify to be paid via ESA+ | part of “Service Providers” domain [k12.ncseaa.edu](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/service-providers/enrollment/?utm_source=chatgpt.com) |
| ClassWallet Account / Wallet / Platform | The digital wallet / payment platform used to manage ESA+ funds | NC uses ClassWallet as the platform. [ClassWallet+2k12.ncseaa.edu+2](https://classwallet.com/press_releases/north-carolina-selects-classwallet-to-support-states-esa-program/?utm_source=chatgpt.com) |
| Vendor / Vendor Catalog / Marketplace | Vendors offering allowable goods/services purchasable via ClassWallet | implied in how funds are used (marketplace) [k12.ncseaa.edu+1](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/?utm_source=chatgpt.com) |
| Allowable Expense / Qualified Expense | The category of goods/services that ESA+ funds can legally pay for | many “what can you pay for” pages. [k12.ncseaa.edu+3k12.ncseaa.edu+3k12.ncseaa.edu+3](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/?utm_source=chatgpt.com) |
| Non-allowable Expense / Prohibited Expense | The “business rule negative” counterpart | from rules page. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com) |
| Rollover / Remaining Funds / Balance | The leftover funds from one year, possibly carried forward under rules | rules page describes rollover constraints. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com) |
| Minimum Spending Requirement | A threshold a family must spend to maintain eligibility | in rules page. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com) |
| Lottery / Waitlist | The mechanism for awarding when more eligible students than funding allows | awarding process page. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/awarding-process/?utm_source=chatgpt.com) |
| Payment Disbursement / Payment Schedule | The schedule and method by which funds are sent to schools / providers / via wallet | in awarding process and funding pages. [k12.ncseaa.edu+2k12.ncseaa.edu+2](https://k12.ncseaa.edu/the-education-student-accounts/awarding-process/?utm_source=chatgpt.com) |
| Re-evaluation / Continuing Eligibility | Periodic re-verification of disability documentation to remain eligible | “Continuing Eligibility” is a concept. [k12.ncseaa.edu](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/?utm_source=chatgpt.com) |
| LEA Release (Local Education Agency Release) | Legal release from public school special education services as condition for receiving ESA+ | program rules. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com) |
| Refund / Return of Funds | Non-used or misused funds returned to the authority | rollover, and rules mention returning funds. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com) |
| Tax Reporting / 1099-G | The tax reporting of funds used for non-tuition allowable expenses | in rules. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com) |

From this list, we can start clustering into domain aggregates or bounded contexts.

* * *

### Aggregate / bounded context suggestions for ESA+

In DDD, an _aggregate_ is a cluster of domain objects around a root that enforce invariants. Here are candidate aggregates:

1. **ScholarshipAccount (or ESAAccount) Aggregate**

    * Root: ScholarshipAccount (for a student)

    * Contains: balance, rollover rules, minimum spending requirement, list of transactions (expense, payment), state (active, inactive, terminated)

    * Invariants: you cannot overspend beyond balance, you must meet minimum spend, you cannot roll over beyond cap, etc.

2. **Application / Awarding Aggregate**

    * Root: Application

    * Contains: eligibility determination document, status (submitted, under review, awarded, declined, waitlisted), lottery result, award offer

    * Invariants: only eligible applications get a lottery entry; award must be accepted to activate funding; deadlines must be respected.

3. **Provider / Vendor Enrollment Aggregate**

    * Root: Provider

    * Contains: credentials, services offered, enrollment status, contract, invoices

    * Invariants: provider must be credentialed, must be enrolled before payments accepted; must appear in marketplace.

4. **SchoolChoice / Enrollment Aggregate**

    * Root: SchoolChoice

    * Contains: school entity, enrollment type (direct pay, reimbursement, home school), choice date, transfer history

    * Invariants: must select school by certain date (Aug 1); changing after that requires special handling; school must be eligible.

5. **ParentAgreement / Compliance Aggregate**

    * Root: ParentAgreement

    * Contains: signed agreement, compliance state, sanctions, release (LEA), policy violations

    * Invariants: if parent fails obligations, contract can be terminated; must sign LEA when applicable, etc.

You might even split a **Rules / Policy** bounded context (the statutes, program rules) from the operational domain; those objects feed into validations.

Also, **Transaction** or **Payment** can be a smaller module, though linked to ScholarshipAccount or Provider aggregates.

* * *

### Verbs / Actions / Workflows

These are verbs / processes / events that act on the nouns. I group them into workflows.

#### Application & Awarding Workflows

* **Create MyPortal Account**

* **Submit Application** (application -> status “submitted”)

* **Upload Eligibility Determination Document**

* **Validate Eligibility** (system/authority checks the document, rules)

* **Lottery / Random Selection**

* **Offer Award** (generate award offers)

* **Accept / Decline Award**

* **Notify via MyPortal**

* **Enroll in School / Choose School**

* **Check To-Do Tasks / Complete Requirements**

* **Send Payment / Disburse Funds** (to school or wallet)

* **Renew / Re-apply for next year**

* **Re-evaluate Disability (continuing eligibility)**

* **Cancel / Terminate Scholarship** (due to noncompliance, failure to spend, etc.)

* **Refund / Return Funds** (unused or misused funds)

#### Fund / Payment / Expense Workflows

* **List Allowable Expenses / Vendor Catalog**

* **Submit Purchase Request** (student/family selects item)

* **Vendor / Provider Invoice Submission**

* **Approve Expense** (check against rules)

* **Execute Payment** (via ClassWallet to vendor)

* **Track Transaction / Ledger Entry**

* **Roll Over Unused Balance**

* **Report to IRS / Tax Reporting**

#### Provider / Vendor Workflows

* **Register / Enroll as Provider**

* **Submit Credentials**

* **Approval / Credential Validation**

* **Be Listed in Provider Directory**

* **Receive Invoices / Payments**

* **Dispute / Adjustments**

#### School Enrollment / Choice Workflows

* **Select School**

* **Register / Confirm Enrollment**

* **Switch / Transfer School**

* **Validate School Eligibility (direct pay, reimbursement, registration with DNPE, etc.)**

* **Ensure enrollment by deadline or lose award**

#### Compliance & Monitoring Workflows

* **Validate Minimum Spending**

* **Enforce Prohibited Expenses**

* **Audit / Compliance Check**

* **Terminate / Suspend Participation**

* **Re-evaluation of eligibility every X years**

* * *

### Opportunity Scholarship (OS) — key domain differences / overlaps

From the NCSEAA site (K12 home page) I see that OS is the sibling program. [k12.ncseaa.edu](https://k12.ncseaa.edu/?utm_source=chatgpt.com)

Some overlapping domain items and differences:

* **Direct Payment School**: OS funds must go to direct payment nonpublic schools (family cannot use OS for home school or reimbursement). [NCSEAA+1](https://www.ncseaa.edu/8331-2/?utm_source=chatgpt.com)

* **Income Verification**: OS program likely has income-based eligibility / verification. (Because there is an “Income Verification” link under Opportunity Scholarship section on NCSEAA site) [k12.ncseaa.edu](https://k12.ncseaa.edu/?utm_source=chatgpt.com)

* **How to Apply / Awarding Process**: Similar application / awarding workflows but with different eligibility criteria. [k12.ncseaa.edu+1](https://k12.ncseaa.edu/?utm_source=chatgpt.com)

* **School choice**: OS does _not_ allow home schooling or reimbursement schools; must attend direct payment schools. [NCSEAA](https://www.ncseaa.edu/8331-2/?utm_source=chatgpt.com)

* **Disbursement**: OS funds are sent to direct payment schools twice per year. [k12.ncseaa.edu+1](https://k12.ncseaa.edu/the-education-student-accounts/awarding-process/?utm_source=chatgpt.com)

Thus, OS will share aggregates like Application, SchoolChoice, Payment, but with different validation rules, eligibility criteria, and constraints.

So in your domain model, you might have **Program** as an abstraction, with concrete “ESA+ Program” and “OpportunityScholarship Program” subclasses or modules.

* * *

### Preliminary Domain Model (Sketch)

Here’s a rough sketch in textual form. You will refine into diagrams as you like.

```
[Program]  (abstract)
   ├─ ESAPlusProgram
   └─ OpportunityScholarshipProgram

Application (aggregate)
   • studentId
   • familyId
   • eligibilityDocument
   • status (submitted / underReview / awarded / waitlisted / declined)
   • lotteryRank
   • associated Program

ScholarshipAccount (aggregate)  — only for ESA+
   • studentId
   • balance
   • transactions (expense, payment)
   • rollover allowance
   • minimumSpendRequirement
   • state (active, suspended, terminated)

Provider (aggregate)
   • providerId
   • type (tutor, therapy, transport)
   • credentials
   • enrollmentStatus
   • serviceOfferings
   • contract / approvalDate

SchoolChoice (entity / part of Application or part of separate Enrollment)
   • studentId
   • chosenSchoolId
   • schoolType (directPay / reimbursement / homeSchool)
   • choiceDate
   • transferHistory

ParentAgreement (entity)
   • studentId
   • agreementSignedDate
   • fields: LEARelease, complianceFlags, terminationClause

ExpenseTransaction / PaymentTransaction
   • transactionId
   • date
   • amount
   • vendorId / providerId
   • status (pending, approved, paid, rejected)
   • expenseType

Vendor / MarketplaceItem (value object or small aggregate)
   • itemId
   • description
   • category (tuition, curriculum, therapy, etc.)
   • vendorId
   • cost
   • eligibilityFlag (allowed or not)

Audit / ComplianceRecord
   • recordId
   • date
   • findings
   • action (warning, termination, refund)

Renewal / ReEvaluation (process entity)
   • studentId
   • year
   • reevalDocument
   • status (pending, passed, failed)

TaxReporting (value / event)
   • studentId / familyId
   • year
   • amountReported  (for non-tuition expenses)
```

In this model, **Application**, **ScholarshipAccount**, **Provider**, **SchoolChoice**, **ParentAgreement**, **ExpenseTransaction** are key aggregates/entities.

Bounded contexts might split:

* Application & Awarding context

* Fund / Wallet / Payment context

* Provider / Vendor context

* Compliance / Audit context

* School / Enrollment context

* * *

## What more I need & next steps

To refine and make this DDD model robust, I need:

1. **Program statutes & rules** (legal text) for both ESA+ and OS (to capture edge conditions).

2. **Internal process docs / flowcharts** (if you have them) for NCSEAA staff, adjudication, audits, etc.

3. **Data dictionary or existing DB schema** if available.

4. **Edge cases, exceptions, prior violations, appeals processes** you encounter in real operations.

5. Your preferences in naming, granularity, and constraints.

If you give me those, I can produce clean, production-grade domain diagrams, contexts, event flows, etc.

If you like, I can now do the same noun/verb extraction for the OS program and merge with ESA+, produce a unified domain model draft and send you a diagram (in text/PlantUML). Do you want me to do that next?

* * *

**You:**

Please review and deep research on the following URL and linked resources informations.

URL: <https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/resources/>

Update the current domain findings.

* * *

**ChatGPT:**

I poked around the **ESA+ Resources** page and linked materials. The system’s domain is more nuanced (and messier) than my first draft. Here’s an updated, deeper set of domain items, aggregates, actions, invariants, edge cases, and relationships. (Yes, I dragged myself out of code to do this.)

I’ll first highlight new or refined domain elements gleaned from the “Resources” page and associated documents. Then I’ll fold them into the the prior domain model, showing added complexity and constraints.

* * *

## Key New / Refined Domain Findings from the Resources Page

The URL you gave — _ESA+ Program Resources_ — is a hub linking forms, guides, and policies. [k12.ncseaa.edu](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/resources/)

From those resources + linked pages, here are domain refinements:

### New / Refined Nouns / Concepts & Descriptions

| Concept | Description / Business Role | Observations & Source |
| --- | --- | --- |
| _Parent Guide to Allowable Expenses_ | A structured policy document listing what can or cannot be bought with ESA+ funds (and under which conditions) | Helps define “allowable expense” boundaries. [k12.ncseaa.edu](https://k12.ncseaa.edu/media/0ckgxt0f/parentguideae2526final.pdf?utm_source=chatgpt.com) |
| _Rejection Codes_ | Codes indicating why a purchase (order/invoice) was rejected | Essential for transaction validation & error handling. [k12.ncseaa.edu](https://k12.ncseaa.edu/media/0ckgxt0f/parentguideae2526final.pdf?utm_source=chatgpt.com) |
| _Contract for Transportation Services_ | A signed agreement between parent and transport provider needed for using ESA+ funds for transportation | Formalizes a sub-agreement for a class of service. [k12.ncseaa.edu](https://k12.ncseaa.edu/media/0ckgxt0f/parentguideae2526final.pdf?utm_source=chatgpt.com) |
| _Used Technology / “Used” Items_ | The policy allows used technology items in certain cases | Adds nuance to “product” category. [k12.ncseaa.edu](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/educational-technology/?utm_source=chatgpt.com) |
| _Accessory Purchase Conditions_ | Accessories must be bought within 30 calendar days of main device order (if not bundled), and only once every three years | Adds a time constraint, variant, lifecycle rule. [k12.ncseaa.edu](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/educational-technology/?utm_source=chatgpt.com) |
| _Enrollment Path / School Options_ | The domain of school modalities: Direct Payment School, Reimbursement School, Home School, Co-enrollment | More precise classification of “school choice” domain. [k12.ncseaa.edu+2k12.ncseaa.edu+2](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/resources/) |
| _Misuse of State Funds Policy_ | A document/policy that defines misuse, sanctions, recourse | This is part of compliance / enforcement domain. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/resources/?utm_source=chatgpt.com) |
| _LEA Release_ (Local Education Agency Release) | The formal waiver by parents giving up full public school special education services while in ESA+ | A required legal contract in some cases. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com) |
| _Minimum Spending Requirement_ | A threshold ($1,000 per year) that parents must expend from ESA+ on allowable items to maintain renewal eligibility | A “floor” constraint on account usage. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com) |
| _Rollover / Roll-forward Funds_ | Policy about carrying leftover funds to next year, with caps and conditions | Has rules depending on award level. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com) |
| _Tax Reporting (1099-G)_ | ESA+ non-tuition spending is reported to IRS; NC allows some state deduction | Financial reporting obligations. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com) |
| _Summer Expense Period / ClassWallet Suspension_ | The system (ClassWallet) is disabled mid-June for fiscal close; families must plan purchases before that | Introduces a time window risk. [k12.ncseaa.edu+1](https://k12.ncseaa.edu/media/rnnowt2w/plan-for-summer-expenses-final_for-rollover-notificiationsfin.pdf?utm_source=chatgpt.com) |
| _Purchase Lifecycle (Submit, Review, Approve, Pay, Reject)_ | The state of a purchase request (order or invoice) moving through steps, possibly being rejected | More concrete in the “Parent Guide” documentation. [k12.ncseaa.edu](https://k12.ncseaa.edu/media/0ckgxt0f/parentguideae2526final.pdf?utm_source=chatgpt.com) |
| _Curricula Vendor / Product Vendor (outside marketplace)_ | The behavior for vendors outside ClassWallet marketplace (upload invoice, match, review) | Expands the vendor / purchase path domain. [k12.ncseaa.edu](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/curriculum/?utm_source=chatgpt.com) |
| _Supplemental Services via Schools_ | Schools themselves may provide tutoring or therapy that families pay via ESA+ (if schools also enroll as providers) | Blurs distinction between “school” and “service provider.” [k12.ncseaa.edu](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/educational-therapy/?utm_source=chatgpt.com) |

These enrich the domain, especially in the “expenses / purchase / compliance” side.

### New / Refined Actions / Workflows / Processes

From the resources, actions get flesh:

* **Submit Purchase Request / Order / Invoice**  
    Parent initiates a request (via ClassWallet or external vendor route) to spend ESA+ funds.  
    Must specify category, item, attach invoice or screenshot when off-marketplace. [k12.ncseaa.edu+3k12.ncseaa.edu+3k12.ncseaa.edu+3](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/curriculum/?utm_source=chatgpt.com)

* **Review / Approve / Reject Purchase**  
    SEAA staff or system evaluates whether request fits allowable rules; either approves or rejects with a rejection code. [k12.ncseaa.edu+2k12.ncseaa.edu+2](https://k12.ncseaa.edu/media/0ckgxt0f/parentguideae2526final.pdf?utm_source=chatgpt.com)

* **Execute Payment to Vendor or Provider**  
    Once approved, funds move (ClassWallet, “pay vendor”) to the accepted party.

* **Enforce Accessory Timing Rules**  
    System must check whether accessory orders are timely (within 30 days) or violate the 3-year limit for accessories.

* **Transport Contract Management**  
    Parent and transportation provider sign a contract; first invoice must include the contract; must store that contract.

* **Rollback / Return / Refund of Misused Funds**  
    If misuse or disallowed purchase, funds may be returned or clawed back under misuse policy.

* **Rolling Over / Carry Forward Funds**  
    At year-end, system must compute how much can roll over (or must be returned) based on award level, cap, etc.

* **Affidavit / Parent Declaration / Signature**  
    Before or when funds are released, parent must sign an affidavit (declaration) that they understand rules and will abide.

* **Annual Renewal & Eligibility Re-evaluation**  
    Parent must reapply/renew, and submit continuing eligibility (especially on disability documentation every 3 years).

* **Suspend / Terminate Scholarship**  
    If rules broken (e.g. failure to meet minimum spending, misuse, failure to sign release) then scholarship may be suspended or terminated.

* **Summer Period Shutdown**  
    The system (ClassWallet) closes for mid-June fiscal year end, prohibits purchases during that time. Parents must plan before that.

* **Vendor / Provider Enrollment**  
    (Reaffirmed) Providers must register/enroll to accept ESA+ funds.

* **Vendor Payment / Review for Outside Marketplace Orders**  
    For off-marketplace vendors, parent must upload invoice/cart screenshot, system matches/validates, then staff reviews.

### Invariants, Rules, Business Constraints

* Must spend at least **$1,000** on allowable items (tuition or other) per year or lose future eligibility. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com)

* Accessory purchases allowed only within 30 days of main device purchase (if not bundled) and only once every three years. [k12.ncseaa.edu](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/educational-technology/?utm_source=chatgpt.com)

* Rollover only allowed for students who received the **higher award** (e.g. $17,000). Base award students ($9,000) cannot carry unused funds. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com)

* Rollover is capped: “may roll over up to $4,500” and total balance may not exceed $30,000. [k12.ncseaa.edu+1](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com)

* ClassWallet marketplace is the **only** place to buy products with ESA+ funds, except for off-marketplace vendors via the “Pay Vendor / upload invoice” flow. [k12.ncseaa.edu+2k12.ncseaa.edu+2](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/?utm_source=chatgpt.com)

* Providers (tutors, therapists, transport) **must enroll** with SEAA to accept ESA+ funds. [k12.ncseaa.edu+3k12.ncseaa.edu+3k12.ncseaa.edu+3](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/allowable-expenses/educational-therapy/?utm_source=chatgpt.com)

* Transportation requires a **signed contract** between parent & provider; include student name and terms and be submitted with first invoice. [k12.ncseaa.edu](https://k12.ncseaa.edu/media/0ckgxt0f/parentguideae2526final.pdf?utm_source=chatgpt.com)

* Expenditures must support **core academic subjects** (math, science, English/language arts, social studies, foreign language). [k12.ncseaa.edu+3k12.ncseaa.edu+3k12.ncseaa.edu+3](https://k12.ncseaa.edu/media/0ckgxt0f/parentguideae2526final.pdf?utm_source=chatgpt.com)

* For nonpublic / home school full-time ESA+, parents must sign the **LEA Release** (give up public special ed services). [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com)

* ESA+ funds used for non-tuition/required fees must be reported to IRS (Form 1099-G) and state rules allow deduction only if included as federal income. [k12.ncseaa.edu](https://k12.ncseaa.edu/the-education-student-accounts/program-rules-and-requirements/?utm_source=chatgpt.com)

* * *

## Updated Domain Model Sketch (Incorporating New Findings)

I will update the earlier aggregates/entities and show new relationships, constraints, and flows.

> **📖 For Enhanced Aggregate Details:** See [aggregate-details-enhancement.md](./aggregate-details-enhancement.md) for comprehensive documentation of each aggregate including:
> - Detailed domain role & usage explanations
> - Complete attribute descriptions
> - Relationship diagrams and dependencies  
> - Concrete workflow examples
> - Methods/operations with business logic
> - Invariants and business rules
> - Source URL references

### Aggregates / Entities (Revised)

* **ScholarshipAccount / ESAAccount**  
     - Attributes: `studentId, awardLevel (base / higher), initialAwardAmount, balance, rolloverAllowed, rolloverCap, cumulativeBalanceCap`  
     - Relationships: has many `PurchaseRequests` / `Transactions`  
     - Invariants:  
      1. If awardLevel == base, unused funds must be returned (no rollover)  
      2. If awardLevel == higher, rollover ≤ $4,500 and resulting balance ≤ $30,000  
      3. Annual spending floor ≥ $1,000 else termination / nonrenewal

* **PurchaseRequest / Order / Invoice**  
     - Attributes: `requestId, parentId, studentId, vendorId (or marketplace vendor), category, amount, status (submitted / underReview / approved / rejected), rejectionCode, timestamp, accessoryFlag, relatedMainDeviceOrderId`  
     - Methods / operations: `submit()`, `approve()`, `reject(code)`, `pay()`, `rollback()`  
     - Invariants:  
      1. If accessoryFlag = true, must validate timing and “once-per-three-year” rule  
      2. The amount must be ≤ remaining eligible balance  
      3. The vendor must be enrolled (for services) or product must be in marketplace / vendor route  
      4. On first transport invoice, a valid signed contract must accompany

* **Provider / ServiceProvider**  
     - Attributes: `providerId, types (tutoring, therapy, transport), credentials, enrollmentStatus, contractTerms`  
     - Methods: `register()`, `validateCredentials()`, `acceptInvoice()`  
     - Invariants: Only enrolled providers can be paid from ESA+ (for service categories)

* **Vendor (Product Vendor)**  
     - Attributes: `vendorId, name, isMarketplaceVendor (bool), contract / vendor agreement`  
     - If not marketplace vendor, must support invoice upload + matching workflow

* **ParentAgreement / Affidavit**  
     - Attributes: `agreementId, parentId, studentId, signedDate, understandsRules (yes/no), LEAReleaseSigned (yes/no)`  
     - Methods: `sign()`, `validateSignatures()`  
     - Invariants: For full-time nonpublic or home school ESA+, LEARelease must be signed

* **SchoolChoice / EnrollmentOption**  
     - Attributes: `studentId, schoolType (DirectPayment / Reimbursement / HomeSchool / CoEnrollment), chosenSchoolId, enrollmentDate, coEnrollmentRules`  
     - Invariants: Depending on schoolType, different rules for payment or reimbursement

* **Renewal / ContinuingEligibility**  
     - Attributes: `renewalYear, submittedDate, status (pending / approved / rejected), reevalDocumentation (if needed)`, `lastDisabilityDocDate`  
     - Methods: `submitRenewal()`, `evaluateContinuingEligibility()`  
     - Invariants: Every 3 yrs must provide new eligibility determination; renewal must happen to continue funding

* **Audit / ComplianceRecord**  
     - Attributes: `complianceId, studentId, date, finding, action (warning / refund / termination)`, `misuseFlag`  
     - Methods: `triggerComplianceCheck()`, `applyPenalty()`

* **TaxReportEntry**  
     - Attributes: `studentId, parentId, calendarYear, nonTuitionSpendingAmount`  
     - Methods: `generateReport()`

### Boundaries / Contexts & Relationships

* **Application & Awarding Context** (shared between ESA+ & OS)  
     - Handles application submission, eligibility verification, award offer, accept/decline, waitlist, etc.

* **Fund / Wallet / Transaction Context**  
     - Contains ScholarshipAccount, PurchaseRequests, Vendor, Transaction lifecycles.  
     - Cross-checks allowable rules, accessory constraints, rollover logic, payment, refunds.

* **Provider Enrollment / Service Context**  
     - Manages provider registration, credential validation, service definitions (tutoring, therapy, transport).

* **School / Enrollment Context**  
     - Manages school types, choosing school, co-enrollment rules, reimbursement vs direct pay logic.

* **Compliance / Audit Context**  
     - Monitors misuse, enforces rules, produces compliance records, triggers termination or refund actions.

* **Tax / Reporting Context**  
     - Handles 1099 reporting, state deductions logic.

### Key Interactions & Workflows (Revised)

1. **Parent signs ParentAgreement / LEARelease → upon award activation**

    * The system must check whether LEARelease is required given chosen school type.

    * Cannot disburse funds until agreement is signed.

2. **Parent submits PurchaseRequest**

    * Vendor must be in marketplace or vendor path.

    * If accessory, check timing rule.

    * If transport, require contract document.

    * Category must map to allowable categories.

    * Ensure balance sufficient.

3. **System / Staff reviews request**

    * Validate against allowable rules, accessory rules, core subject rule.

    * Accept or reject with code.

    * If approved, amount held or reserved.

4. **Payment Execution**

    * Funds move (ClassWallet or external) to vendor or provider.

    * Update ScholarshipAccount balance and Transaction record.

5. **Rollover / Year-End Processing**

    * At fiscal year close, for each scholarship:  
          • Compute unused portion  
          • If base award, set to be returned  
          • If higher award, compute rollover ≤ allowed and limit final balance ≤ cap  
          • Refund excess to SEAA  
          • Lock account (no purchases during closed period)  
          • Reopen next year with new award and rollover.

6. **Annual Renewal / Continuing Eligibility**

    * Parent submits renewal; if past 3 years since last disability verification, require new documentation.

    * Verify compliance (met spending rule, no misuse).

    * Approve / reject renewal.

    * If renewal approved, open new year’s account with rollover + new award.

7. **Compliance / Audit Checks**

    * Periodically (or triggered by suspicious transactions), generate compliance audit.

    * If misuse found, issue compliance record, possibly terminate or demand refunds.

8. **Summer / Pre-shutdown Planning**

    * System enforces purchase cutoff (mid-June) for summer.

    * Notify parents to make final purchases.

    * During shutdown, no purchase operations allowed.

* * *

## Suggestions & Next Steps for Domain Modeling

* I recommend you treat **PurchaseRequest** / **Transaction** as a rich domain object (aggregate) with rules around timing, accessory constraints, and vendor path.

* The **ScholarshipAccount** is a central aggregate with invariants (minimum spend, rollover, cap).

* Consider modeling **VendorPaths** (MarketplaceVendor vs NonMarketplaceVendor) as a strategy or subtype pattern.

* The **ParentAgreement** / **LEARelease** pair is a critical validation gate.

* Compliance and audit may be asynchronous, so design events / domain events (e.g. `PurchaseRejected`, `MisuseDetected`) to trigger side effects.

* You’ll need a time domain (calendar, shutdown periods) to enforce cutoff rules (e.g. accessory 30-day, June shutdown).

* Model “category rules” (curriculum vs therapy vs transport) as business rules / validator modules.

If you want, I can produce a full unified domain model (ESA+ + OS) incorporating these refinements and export as PlantUML or interactive diagram. Do you want me to do that now?

* * *

**You:**

ddd-1.md
File
Yes, continue with the models. However, include a detailed text description (target audience: non-subject matter experts) of the "model".

Also, compare an earlier DDD research (attached) by you and see if we are missing any gaps (context: opportunity scholarships and ESA+ related items only).

* * *

**ChatGPT:**

I dove into the “ESA+ Resources” page and related linked documents further, and also revisited public information about the Opportunity Scholarship (OS). Below is a refined, more complete domain model (in text + conceptual form) plus a “plain-English” explanation, and a gap analysis (what we previously missed or under-modeled). Yes, the world is messy; your domain model must capture that mess.

* * *

## Plain-English Description of the Combined ESA+ / Opportunity Scholarship Domain Model

Here’s how I’d explain, to someone who doesn’t already know the programs, what the domain is and how its pieces fit together. (Yes, I have to pretend you’re not me for a moment.)

* * *

### What this model is about (the domain)

North Carolina runs two K–12 scholarship / education funding programs:

1. **ESA+ (“Education Student Accounts”)** — for students with disabilities, giving them flexible funding to use toward private school, homeschooling, or various educational services and materials.

2. **Opportunity Scholarship (OS)** — for families wanting to attend private schools, based primarily on income/household criteria, limited to paying tuition & required fees at direct payment (registered) private schools.

These programs share some processes (application, awarding, school choice) but have different rules, constraints, and workflows (especially ESA+ has a more complex “allowable expenses / purchase / compliance” side).

This model captures the “things” (nouns) and “actions/workflows” (verbs) relevant to _only those two programs_, and how they relate.

* * *

### Key “things” (entities, aggregates, value objects) in the model and their roles

I’ll list the main domain pieces and what they represent in business terms.

| Domain Item | Role / What It Represents | Key Attributes or Constraints |
| --- | --- | --- |
| **Program** (abstract) | A generic concept of a scholarship/education funding program (ESA+ or OS) | program type (ESA+, OS), ruleset, funding limits, eligibility logic |
| **Application** | The process a family/student enters to request a scholarship | student, parent, submitted date, status (submitted, under review, awarded, waitlisted, declined), program reference |
| **AwardOffer** | A formal offer to provide scholarship funds | offered amount, acceptance deadline, status (accepted/declined) |
| **ScholarshipAccount** (for ESA+) | The “wallet” or fund account for a student in ESA+ | award amount, remaining balance, rollover allowance, minimum spending requirement, cumulative balance cap |
| **PurchaseRequest / Transaction** | A request or actual use of funds — e.g. buying a curriculum item, paying for tutoring | vendor, category, amount, status (submitted / review / approved / rejected / paid), accessory flag, timestamps |
| **Provider** | A service provider (therapist, tutor, transport) that can be paid via ESA+ | provider type, credentialing/enrollment status, contract, service offerings |
| **Vendor** | A vendor or merchant of goods (e.g. educational materials) | whether in marketplace, agreement to accept ESA+, vendor path (marketplace vs external) |
| **ParentAgreement / Affidavit** | The legal agreement by the parent about program terms, compliance, release of public services (if needed) | signed date, LEARelease (if needed), compliance obligations |
| **SchoolChoice / EnrollmentOption** | The school or modality (private school, reimbursement school, home school, co-enrollment) chosen by the student | schoolType, chosenSchool, enrollment date, eligibility constraints |
| **Renewal / ContinuingEligibility** | The yearly or periodic revalidation of eligibility and renewal of the program | year, reeval docs (especially for disabilities in ESA+), status |
| **ComplianceRecord / Audit** | A record of review, misuse, sanctions, or findings | student, date, finding, action (warning, refund, termination) |
| **TaxReportEntry** | Information needed to report non-tuition spending for tax / IRS / state reporting | year, non-tuition spent amount, flags |
| **RejectionCode / RejectionReason** | Structured reasons why a transaction request was rejected | code, human message, mapping to domain rule violation |

Additionally, there are supporting “value objects” or small types, such as **AllowableExpenseCategory**, **AccessoryRule**, **TimingRule**, **RolloverRule**.

* * *

### How the “things” interact: Major workflows / processes

Here’s a simplified flow of how users and system actors move through the domain:

1. **Application Flow (for both ESA+ and OS)**

    * Parent creates a **MyPortal account**

    * Parent submits an **Application** (for each student)

    * Uploads required documentation (for ESA+, the _Eligibility Determination_; for OS, income/household documents)

    * System / staff validates eligibility

    * If accepted, an **AwardOffer** is generated

    * Parent accepts or declines the offer in the portal

    * Once accepted, the program (ESA+ or OS) moves into active funding / utilization stage

2. **School Choice / Enrollment**

    * Parent must choose a school or schooling modality (private school, reimbursement school, home school in ESA+, co-enrollment, etc.)

    * There are deadlines (e.g. by August 1) to choose or update the school or risk cancellation. [NCSEAA+1](https://www.ncseaa.edu/8331-2/?utm_source=chatgpt.com)

    * Different rules depending on type (e.g. OS only works with _direct payment_ schools) [NCSEAA+1](https://www.ncseaa.edu/8331-2/?utm_source=chatgpt.com)

    * Enrollment or school transfer processes allow for changing school under some conditions (with constraints) [NCSEAA+1](https://www.ncseaa.edu/opportunity-current-scholarship-families/?utm_source=chatgpt.com)

3. **Fund / Purchase / Payment (ESA+ side)**

    * For ESA+, once funding is active, a parent or designated user submits **PurchaseRequest(s)** or invoices (for items, services)

    * System or staff reviews them vs business rules (allowability, accessory timing, category, sufficient balance, vendor eligibility)

    * Approved requests are paid (funds transferred to vendor / provider / school)

    * Rejected requests are returned with a **RejectionCode**

    * The **ScholarshipAccount** tracks balance, rollover, spending floor, etc.

    * At the fiscal year end, **rollover / return** logic applies based on program rules (base vs higher award, caps, etc.)

    * The system disables purchases during a mid-June shutdown period, so purchases must occur before that. (Families are advised to “plan for summer expenses” or risk losing purchase window) [k12.ncseaa.edu+1](https://k12.ncseaa.edu/families-of-awarded-students/esaplus-program/resources/?utm_source=chatgpt.com)

4. **Renewal / Continuing Eligibility**

    * Each year, or at certain intervals (e.g. every 3 years for ESA+), the parent must submit renewal forms or updated documentation (e.g. disability re-evaluation)

    * The system verifies compliance (met spending floor, no misuse, contract signatures, etc.)

    * If renewal fails, scholarship is terminated or not continued

    * If passes, new year’s award is granted, rollover funds (if allowed) are added, account reopened for purchases

5. **Compliance / Audit**

    * The system or staff may trigger **ComplianceRecord/Audit** reviews

    * If misuse is found (purchases outside rules, exceeding caps, etc.), sanctions may apply (refund demands, termination, probation)

    * These may cascade, e.g. disallow future renewals

6. **Tax / Reporting**

    * For ESA+, non-tuition funds spent are subject to tax reporting (Form 1099-G) and state / IRS rules

    * Recording **TaxReportEntry** ensures traceability and compliance

* * *

### Key constraints, invariants, and business rules embedded in the model

Some of these are “rules that must never be violated” and define the domain’s integrity boundaries:

* For ESA+ **spending floor**: families must spend at least **$1,000** in allowable expenses in a year to maintain eligibility.

* **Rollover logic**: only students with the “higher award” can carry forward unused funds, up to a limit (e.g. $4,500), and overall balance cannot exceed $30,000.

* **Accessory rules**: for educational technology, accessory purchases must be within 30 days of main device (if not bundled), and only allowed once every three years.

* **Vendor / Provider eligibility**: only enrolled and credentialed providers or vendors (or marketplace vendors) can be paid via the program.

* **Contract requirement for transportation**: first invoice for transport must include a signed contract between parent & provider.

* **School choice deadlines**: failure to choose a school by August 1 can lead to cancellation.

* **Program modality restrictions**: OS cannot support reimbursement schools or home school — must use direct payment private schools.

* **Shutdown window**: the system is disabled for purchases mid-June (at fiscal year end), so no purchases allowed during that period.

* **Renewal and re-evaluation intervals**: especially for ESA+, re-evaluation of disability every 3 years is required.

* **Rejecting/returning misused funds** and **compliance sanctions** must be possible.

* **Award exhaustion / lottery**: both programs may use lotteries or income tier priority when funding is limited.

* **Limits on number of school transfers / fund routing**: e.g. OS allows funds to go to no more than two direct payment schools per semester. [NCSEAA](https://www.ncseaa.edu/opportunity-current-scholarship-families/?utm_source=chatgpt.com)

* * *

## Formalized / Refined Domain Model (textual / UML style) & Comparisons with Previous Version (gaps filled)

Below is a more formal model (in text / pseudo‐UML style). Then I’ll compare vs our earlier version and highlight gaps we now cover.

* * *

### Refined Model Components & Relationships

```
Program (abstract)
 ├── ESAPlusProgram
 └── OpportunityScholarshipProgram

Application
 ── belongs to Program
 ── has status, documents, parent, student
 ── leads to AwardOffer

AwardOffer
 ── accepted / declined

ScholarshipAccount  (only for ESA+)
 ── one per student / award cycle
 ── attributes: initialAward, balance, rolloverAllowed, rolloverCap, spendingFloor, cumulativeCap

PurchaseRequest / Transaction
 ── belongs to ScholarshipAccount (for ESA+)
 ── vendor or provider
 ── status: submitted | review | approved | rejected | paid
 ── flags: accessory, transport, etc.
 ── rejectionCode

Provider (for ESA+)
 ── service domain: therapy, tutoring, transport
 ── enrollment status, credentials, contract

Vendor
 ── marketplace vendor (in ClassWallet) or external vendor
 ── agreement to accept ESA+ payment

ParentAgreement
 ── associated with student & parent
 ── signed date, LEARelease (if needed), compliance terms

SchoolChoice / EnrollmentOption
 ── student → schoolType: DirectPayment | Reimbursement | HomeSchool | CoEnrollment
 ── chosenSchoolId, enrollmentDate, transferHistory

Renewal / ContinuingEligibility
 ── associated with student & program year
 ── reeval documents, prior years’ performance / compliance, renewal status

ComplianceRecord / Audit
 ── student, date, findings, sanction / actions (refund, termination)

TaxReportEntry
 ── student, year, nonTuitionSpent

RejectionCode
 ── code, description, mapping to rule

Relationships & Constraints:
 - ESAPlusProgram defines its own business rules (spending floor, rollover, allowable categories)  
 - Application → AwardOffer → ScholarshipAccount  
 - PurchaseRequest → ScholarshipAccount  
 - Vendor / Provider must be enrolled / valid for PurchaseRequest to be accepted  
 - ParentAgreement must be signed before disbursements  
 - SchoolChoice must conform to program rules (e.g. OS only direct payment)  
 - Renewal triggers revalidation of Application or continuing eligibility  
 - ComplianceRecord may block Renewal or terminate ScholarshipAccount  
 - TaxReportEntry is derived from approved PurchaseRequests  

Domain Events worth modeling:
 - ApplicationSubmitted  
 - AwardOffered  
 - AwardAccepted  
 - PurchaseRequested  
 - PurchaseApproved / PurchaseRejected  
 - FundsDisbursed  
 - YearEndRollover / Refund  
 - MisuseDetected / ComplianceAction  
 - RenewalSubmitted  
 - RenewalApproved / RenewalRejected  
 - SchoolTransferRequested / SchoolChange  

Time-based / Calendar domain required:
 - Purchase windows (shutdown, year start, mid-June cutoff)  
 - Accessory timing windows (30 days, 3 years)  
 - Renewal windows and deadlines  
 - School choice deadlines (by August 1)  

```

* * *

### Comparison & Gap Analysis: What We Previously Missed, Now Added

Going back to our earlier version, here are the major gaps we had (and now filled):

| Gap / Missing Piece | Why It Matters | How We Now Capture It |
| --- | --- | --- |
| **Rejection codes / structured reasons** | Without them, the system can only say “rejected” — lacks clarity, auditing, error paths | We added **RejectionCode** entity, tied to PurchaseRequest |
| **Shutdown / purchase blackout window** | Users need to plan; system must enforce, else funds misused / lost | We now include a time dimension and the mid-June shutdown period constraint |
| **Accessory purchase timing rules** | You can’t just buy accessories any time — must be within 30 days, once per 3 years | We explicitly flag accessory purchases and enforce rules |
| **Contract requirement for transportation** | That’s a special rule: first transport invoice must carry a signed contract | We model that as a validation on PurchaseRequest for transport |
| **OS school / modality restrictions** | OS cannot be used in home school or reimbursement path — only direct payment private schools | We now explicitly capture that in **SchoolChoice / EnrollmentOption** constraints |
| **School transfer and routing constraints** | OS: funds can only be sent to at most two direct payment schools per semester | We added this rule (from NCSEAA “Current Scholarship Families”) into model. [NCSEAA](https://www.ncseaa.edu/opportunity-current-scholarship-families/?utm_source=chatgpt.com) |
| **Dual program interactions / conflicts** | Some families might be eligible for both ESA+ and OS; how the interactions behave (e.g. co-enrollment) | We noted dual program overlaps in program abstraction and in resources. [k12.ncseaa.edu](https://k12.ncseaa.edu/opportunity-scholarship/how-to-apply/?utm_source=chatgpt.com) |
| **Income / award tier logic (for OS)** | OS has tiers based on household income, no income cap (recent change) | We now include “Program → Tier logic / income verification path” in Program abstraction |
| **Lottery / funding exhaustion logic** | When more applicants than funds, they use lottery or priority ordering by income tier | That belongs in Application → AwardOffer logic in Program module |
| **Renewal deadlines / renewal flows** | Previously we had renewal but not detailed constraints and windows | Now Renewal / ContinuingEligibility is a full process with rules and consequences |
| **Tax / IRS reporting** | ESA+ non-tuition spending is subject to 1099-G and must be tracked | We now include **TaxReportEntry** and link to PurchaseRequests |
| **ParentAgreement / W-9 requirement** | Before disbursement, parents must sign the agreement & provide W-9 (tax form) | We added that into ParentAgreement and requirement before funding |
| **Explicit modeling of program type differentiation** | We need separate logic for ESA+ vs OS — the old version risked conflating them | We now use Program abstraction and per-program rules modules / policies |

So the refined model is richer, better aligned to the complexities in the actual program documents.

* * *

If you like, I can generate a **visual diagram** (PlantUML, or graphical) of this model (ESA+ + OS) and send you a file (SVG / PNG). That will help you map into your design tool. Do you want me to produce that next?

* * *

**You:**

png file

* * *

**ChatGPT:**

Hmm...something seems to have gone wrong.

Retry
