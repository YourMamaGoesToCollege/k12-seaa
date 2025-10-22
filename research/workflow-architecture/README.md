# K-12 SEAA Workflow Architecture Research

**Document Purpose:** Comprehensive research and analysis of workflow orchestration technologies and architectures for the North Carolina K-12 Scholarship Administration system

**Last Updated:** October 22, 2025  
**Technology Focus:** Azure-native, .NET-based, Event-driven, Microservices

---

## Executive Summary

This research package addresses the critical need for a systematic workflow orchestration approach in the K-12 SEAA system. The current "task engine" implementation is a naive approach that lacks workflow state management, sequencing, and orchestration capabilities. This research evaluates Azure-native and .NET-based workflow solutions to provide a comprehensive path forward.

### Key Findings

1. **Workflow Engine is Essential**: With 100+ identified workflows across 4 applications (Admin, Providers, Schools, Households), a proper workflow engine is critical for managing complex, long-running processes.

2. **Azure Provides Multiple Solutions**: Azure offers complementary technologies (Durable Functions, Logic Apps, Event Grid) that can work together to address different workflow needs.

3. **.NET Ecosystem is Rich**: Multiple mature .NET workflow engines (Elsa, MassTransit, Workflow Core) provide flexibility for backend implementation.

4. **Hybrid Approach Recommended**: Combination of Azure-native services for orchestration and .NET libraries for business logic provides optimal balance.

---

## Document Structure

### 1. [Workflow Technology Overview](./01-technology-overview.md)
Comprehensive analysis of workflow orchestration technologies:
- Azure Durable Functions
- Azure Logic Apps  
- Azure Event Grid
- .NET Workflow Engines (Elsa, MassTransit, Workflow Core)
- Comparison matrix and decision criteria

### 2. [K-12 Workflow Analysis](./02-k12-workflow-analysis.md)
Deep dive into K-12 SEAA workflows:
- Workflow inventory across 4 applications
- Current task engine limitations
- Workflow categorization and patterns
- State requirements and long-running processes
- Integration touchpoints (ClassWallet, RDS, email, etc.)

### 3. [Architecture Recommendations](./03-architecture-recommendations.md)
Proposed architecture for K-12 workflow orchestration:
- Architecture diagrams (C4, sequence, state machines)
- Technology selection rationale
- Microservices integration patterns
- Event-driven architecture design
- State persistence strategies

### 4. [Implementation Patterns](./04-implementation-patterns.md)
Concrete implementation patterns and examples:
- Application workflow patterns
- Registration/enrollment workflows
- Certification and verification workflows
- Payment and disbursement workflows
- Communication workflows (email, notifications)
- Error handling and compensation

### 5. [Integration Architecture](./05-integration-architecture.md)
Third-party integration patterns:
- ClassWallet integration workflows
- RDS (Residency Determination) integration
- Email service integration
- Document storage and retrieval
- External API patterns

### 6. [Migration Strategy](./06-migration-strategy.md)
Path from current task engine to workflow orchestration:
- Incremental migration approach
- Priority workflow candidates
- Coexistence patterns
- Risk mitigation
- Timeline and effort estimates

---

## Quick Reference

### When to Use Each Technology

| Technology | Best For | K-12 Use Cases |
|-----------|----------|----------------|
| **Azure Durable Functions** | Long-running, stateful workflows in code | Application processing, award disbursement, multi-step verifications |
| **Azure Logic Apps** | Visual workflows, integrations, no-code | Document routing, email campaigns, simple approval flows |
| **Azure Event Grid** | Event routing, pub/sub, decoupling | Domain events, system integration, real-time notifications |
| **Elsa Workflows** | Complex business workflows, versioning | Enrollment processes, certification workflows, compliance tracking |
| **MassTransit Saga** | Distributed transactions, compensation | Payment processing, multi-service coordination, financial workflows |

### Key Metrics

- **100+** identified workflows across system
- **4** applications (Admin, Providers, Schools, Households)
- **10+** third-party integrations requiring orchestration
- **Multi-month** long-running processes (application lifecycle)
- **Event-driven** architecture for scalability and resilience

---

## Audience

This research is intended for:

- **Architects**: Making technology selection and design decisions
- **Development Teams**: Understanding implementation patterns and best practices
- **Product Owners**: Understanding workflow capabilities and constraints
- **DevOps Engineers**: Planning infrastructure and deployment strategies
- **Stakeholders**: Understanding technical approach and rationale

---

## Methodology

This research was conducted through:

1. **Deep analysis** of existing K-12 SEAA domain documentation
2. **Web research** on Azure and .NET workflow technologies
3. **Review** of Microsoft official documentation
4. **Analysis** of current task engine implementation
5. **Evaluation** of industry best practices and patterns
6. **Synthesis** with existing Azure architecture plans

All claims are backed by inline citations to authoritative sources.

---

## Getting Started

1. **Start with [Technology Overview](./01-technology-overview.md)** to understand available options
2. **Review [K-12 Workflow Analysis](./02-k12-workflow-analysis.md)** to understand system requirements
3. **Study [Architecture Recommendations](./03-architecture-recommendations.md)** for proposed solution
4. **Reference [Implementation Patterns](./04-implementation-patterns.md)** during development

---

## Key Questions Answered

✅ **Do we need a workflow engine?** Yes, absolutely. The complexity and scale of K-12 workflows demand proper orchestration.

✅ **What technologies should we use?** Hybrid approach: Azure Durable Functions + Elsa Workflows + Azure Event Grid

✅ **How do we handle long-running workflows?** Durable Functions and Elsa both support persistent state for long-running processes

✅ **How do we integrate third-party services?** Event Grid + Service Bus for reliable async integration patterns

✅ **How do we track workflow state?** Database-backed state persistence with Azure SQL + Redis caching

✅ **How do we send emails and notifications?** Event-driven triggers with Azure Functions + SendGrid/Azure Communication Services

✅ **How do we handle existing tasks?** Incremental migration with coexistence patterns during transition

---

## References and Resources

### Microsoft Documentation
- [Azure Durable Functions Documentation](https://learn.microsoft.com/en-us/azure/azure-functions/durable/)
- [Azure Logic Apps Documentation](https://learn.microsoft.com/en-us/azure/logic-apps/)
- [Azure Event Grid Documentation](https://learn.microsoft.com/en-us/azure/event-grid/)
- [Event-Driven Architecture on Azure](https://learn.microsoft.com/en-us/azure/architecture/guide/architecture-styles/event-driven)

### .NET Workflow Engines
- [Elsa Workflows Documentation](https://docs.elsaworkflows.io/)
- [MassTransit Documentation](https://masstransit.io/documentation)
- [Workflow Core GitHub](https://github.com/danielgerlag/workflow-core)

### Related K-12 SEAA Documentation
- [Full Domain Analysis](../full-domain.md)
- [DDD Primer for Stakeholders](../ddd-primer-for-stakeholders.md)
- [Azure Architecture](../../rds-integration-research/azure-architecture.md)
- [Execution Roadmap](../../EXECUTION-ROADMAP.md)

---

## Feedback and Questions

This research is living documentation. As implementation progresses and new requirements emerge, these documents should be updated to reflect:

- Lessons learned from implementation
- Performance characteristics observed
- New patterns discovered
- Technology updates and improvements

For questions or clarifications, consult with the architecture team and reference the inline citations to source materials.
