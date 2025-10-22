# Research Documents - Domain-Driven Design for K-12 Scholarship Programs

This folder contains comprehensive research and documentation on Domain-Driven Design (DDD) for the North Carolina K-12 Scholarship Administration system.

## Documents Overview

### 📘 For IT Stakeholders NEW TO Domain-Driven Design
**Start here:** [`ddd-primer-for-stakeholders.md`](./ddd-primer-for-stakeholders.md)

This primer is designed for IT stakeholders, managers, and team members who are not familiar with Domain-Driven Design. It provides:
- Plain-English explanations of DDD concepts (Entity, Aggregate, Value Object, Domain Events, etc.)
- Real examples from ESA+ and Opportunity Scholarship programs
- Five detailed workflows showing how domain objects work together
- Visual diagrams and concrete scenarios
- Clear explanations of relationships between domain objects
- FAQ section addressing common questions
- Glossary of DDD terms

**Best for:** Non-technical stakeholders, new team members, anyone wanting a comprehensive introduction to how DDD applies to our system.

---

### 🔬 For Deep Technical Research
**Comprehensive domain analysis:** [`ddd-1.md`](./ddd-1.md)

In-depth domain analysis across all NCSEAA programs including:
- Domain inventory (nouns) by area
- Behavior inventory (verbs) with anchors
- Canonical workflows (happy paths)
- Bounded contexts and core aggregates
- Inter-context relationships and dependencies
- Domain events
- C4 diagrams (context, container, component)
- Policy anchors encoded as invariants

**Best for:** Architects, senior developers, anyone doing comprehensive system design.

---

### 🎯 For Focused ESA+ and Opportunity Scholarship Work
**Focused K-12 analysis:** [`ddd-2.md`](./ddd-2.md)

Targeted domain research on ESA+ and Opportunity Scholarship programs:
- ESA+ domain nouns (entities, value objects, concepts) with descriptions
- Aggregate suggestions and bounded contexts
- Verbs/Actions/Workflows specific to K-12 programs
- Opportunity Scholarship key differences and overlaps
- Preliminary domain model sketch

**Best for:** Developers working specifically on K-12 scholarship features.

---

### 📋 For Detailed Aggregate Specifications
**Enhanced aggregate details:** [`aggregate-details-enhancement.md`](./aggregate-details-enhancement.md)

Comprehensive documentation of domain aggregates and entities including:
- Domain role & usage for each aggregate
- Complete attribute descriptions
- Relationships & dependencies
- Concrete workflow examples
- Methods/operations with business logic
- Invariants and business rules
- Implementation recommendations

**Best for:** Developers implementing specific aggregates, reviewing detailed specifications.

---

### 📊 Full Domain Documentation
**Complete domain model:** [`full-domain.md`](./full-domain.md) and [`full-domain.pdf`](./full-domain.pdf)

Complete domain model documentation covering the entire NCSEAA ecosystem.

**Best for:** Reference material, comprehensive system overview.

---

### ⚙️ Workflow Architecture Research **NEW**
**Comprehensive workflow orchestration:** [`workflow-architecture/`](./workflow-architecture/README.md)

Complete research and architecture for implementing workflow orchestration in the K-12 SEAA system:
- **Technology Overview:** Azure Durable Functions, Logic Apps, Event Grid, Elsa Workflows, MassTransit
- **K-12 Workflow Analysis:** 100+ workflows across 4 applications with complexity assessment
- **Architecture Recommendations:** Hybrid orchestration approach with detailed diagrams
- **Implementation Patterns:** Production-ready code examples for common workflow scenarios
- **Integration Architecture:** Third-party integration patterns (ClassWallet, RDS, Email)
- **Migration Strategy:** Phased 9-month plan from current task engine to workflow orchestration

**Best for:** Architects designing workflow solutions, developers implementing workflows, stakeholders evaluating technology decisions.

**Key Topics:**
- Long-running workflow management
- Event-driven architecture patterns
- State persistence and recovery
- Distributed transaction coordination
- Error handling and compensation
- Third-party integration resilience

**Start here:** [`workflow-architecture/README.md`](./workflow-architecture/README.md)

---

## Recommended Reading Path

### If you're new to DDD:
1. Start with [`ddd-primer-for-stakeholders.md`](./ddd-primer-for-stakeholders.md)
2. Then read [`ddd-2.md`](./ddd-2.md) for ESA+ specifics
3. Refer to [`aggregate-details-enhancement.md`](./aggregate-details-enhancement.md) when implementing

### If you're familiar with DDD:
1. Review [`ddd-2.md`](./ddd-2.md) for K-12 program specifics
2. Reference [`aggregate-details-enhancement.md`](./aggregate-details-enhancement.md) for implementation details
3. Check [`ddd-1.md`](./ddd-1.md) for cross-program context

### If you're an architect:
1. Start with [`ddd-1.md`](./ddd-1.md) for system-wide view
2. Review [`ddd-2.md`](./ddd-2.md) for K-12 bounded contexts
3. Read [`workflow-architecture/`](./workflow-architecture/README.md) for workflow orchestration architecture
4. Use [`ddd-primer-for-stakeholders.md`](./ddd-primer-for-stakeholders.md) to communicate with non-technical stakeholders

### If you're implementing workflows:
1. Start with [`workflow-architecture/README.md`](./workflow-architecture/README.md) for overview
2. Review [`workflow-architecture/01-technology-overview.md`](./workflow-architecture/01-technology-overview.md) to understand technology options
3. Study [`workflow-architecture/03-architecture-recommendations.md`](./workflow-architecture/03-architecture-recommendations.md) for architectural patterns
4. Reference [`workflow-architecture/04-implementation-patterns.md`](./workflow-architecture/04-implementation-patterns.md) for code examples
5. Check [`workflow-architecture/05-integration-architecture.md`](./workflow-architecture/05-integration-architecture.md) for third-party integrations

---

## Key Concepts Covered

All documents address these critical DDD concepts as they apply to our K-12 scholarship system:

- **Entities:** Student, ScholarshipAccount, Provider, Application, Award
- **Aggregates:** ScholarshipAccount, PurchaseRequest, Provider, Application, ComplianceRecord
- **Value Objects:** Money/Amount, Address, ExpenseCategory, DateRange
- **Domain Events:** AwardActivated, PurchaseApproved, FundsRolledOver, ComplianceViolationDetected
- **Bounded Contexts:** K-12 Scholarship Administration, ESA+ Services, Compliance & Audit, Identity & Residency
- **Workflows:** Application → Award → Purchase → Payment, Provider Enrollment, Year-End Rollover, Compliance Monitoring

---

## Questions or Feedback?

If you have questions about these documents or need clarification on any DDD concepts as they apply to our system:
- Review the FAQ section in [`ddd-primer-for-stakeholders.md`](./ddd-primer-for-stakeholders.md)
- Consult the glossary in the primer document
- Discuss with your team lead or domain experts
- Collaborate with SEAA staff for business rule clarification

---

## Document History

- **2025-10-22:** Added `workflow-architecture/` - Comprehensive workflow orchestration research including technology overview, architecture recommendations, implementation patterns, integration architecture, and migration strategy
- **2024-10-14:** Added `ddd-primer-for-stakeholders.md` - Comprehensive primer for IT stakeholders new to DDD
- **Earlier:** Initial domain research and analysis documents created
