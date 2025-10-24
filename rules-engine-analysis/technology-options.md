# Technology Options: Rules Engine Selection

**Purpose:** Evaluation of rules engine technology options for K-12 SEAA platform

**Date:** October 23, 2025

---

## Executive Summary

### Recommended Option

**Custom .NET Rules Engine integrated with Azure Durable Functions**

**Rationale:**
- ✅ Seamless integration with existing Azure/.NET architecture
- ✅ Full control over rule syntax and evaluation logic
- ✅ No external vendor dependency or licensing costs
- ✅ Serverless model (cost-effective, auto-scaling)
- ✅ Fastest time-to-market (12-15 weeks)
- ✅ Best alignment with team skills and infrastructure

---

## Option 1: Custom .NET Rules Engine

### Overview

Build a custom rules engine using C# and .NET 8, integrated with Azure Durable Functions.

### Architecture

```
┌─────────────────────────────────────┐
│      .NET Services (APIs)           │
│  ┌────────┐  ┌────────┐            │
│  │  App   │  │ Award  │            │
│  │Service │  │Service │            │
│  └────┬───┘  └───┬────┘            │
│       │          │                  │
│       └─────┬────┘                  │
│             ▼                       │
│    ┌──────────────────┐            │
│    │  Rules Engine    │            │
│    │   Service        │            │
│    │  (Azure Function)│            │
│    └─────────┬────────┘            │
│              │                      │
│    ┌─────────▼────────┐            │
│    │ Rule Evaluator   │            │
│    │   (C# Engine)    │            │
│    └─────────┬────────┘            │
│              │                      │
│         ┌────▼─────┐               │
│         │  Rules   │               │
│         │  (YAML)  │               │
│         └──────────┘               │
└─────────────────────────────────────┘
         │
         ▼
  ┌──────────────┐
  │  Azure SQL   │
  │  (Storage)   │
  └──────────────┘
```

### Technical Details

**Rule Definition Format:**
```yaml
rule:
  id: "ESA-ELIG-001"
  name: "ESA+ Age Eligibility"
  description: "Student must be between 5 and 20 years old"
  priority: 100
  conditions:
    - field: "student.age"
      operator: "between"
      value: [5, 20]
  actions:
    - when: "conditions_met"
      then:
        - set_result: "PASS"
        - set_message: "Age requirement met"
    - when: "conditions_not_met"
      then:
        - set_result: "FAIL"
        - set_message: "Student must be 5-20 years old"
```

**C# Implementation:**
```csharp
public class RuleEngine
{
    public RuleEvaluationResult Evaluate(Rule rule, Dictionary<string, object> context)
    {
        // Parse rule conditions
        bool conditionsMet = EvaluateConditions(rule.Conditions, context);
        
        // Execute actions based on result
        var actions = conditionsMet ? rule.Actions.When : rule.Actions.Otherwise;
        return ExecuteActions(actions, context);
    }
    
    private bool EvaluateConditions(List<Condition> conditions, Dictionary<string, object> context)
    {
        foreach (var condition in conditions)
        {
            var value = GetValueFromContext(condition.Field, context);
            if (!EvaluateOperator(condition.Operator, value, condition.Value))
                return false;
        }
        return true;
    }
}
```

### Pros

✅ **Full Control:**
- Custom rule syntax tailored to business needs
- Can implement complex logic specific to K-12 domain
- Easy to extend with new operators or features

✅ **Seamless Integration:**
- Uses existing Azure Functions infrastructure
- Same language as rest of platform (C#)
- No new runtime dependencies

✅ **Cost-Effective:**
- No licensing fees
- Serverless pricing (pay per execution)
- Estimated cost: $100-200/month in production

✅ **Performance:**
- Native C# performance (fast)
- Can optimize specifically for K-12 use cases
- In-memory caching for frequently-used rules

✅ **Team Skills:**
- Development team already proficient in C#
- No learning curve for new technology
- Easy to maintain and extend

✅ **Time-to-Market:**
- Can start immediately (no procurement)
- Simpler than learning external framework
- Estimated timeline: 12-15 weeks

### Cons

❌ **Build vs Buy:**
- Requires development effort (3 weeks for engine core)
- No out-of-box features (must build everything)
- Initial engineering investment required

❌ **Maturity:**
- Not a proven, battle-tested product
- Will encounter edge cases during development
- No community support

❌ **Maintenance:**
- Team responsible for all bug fixes
- Must handle future enhancements internally

### Cost Analysis

| Category | Cost |
|----------|------|
| **Initial Development** | $45K (3 weeks, 2 developers) |
| **Infrastructure (Dev/Test/Prod)** | $3K/year (Azure Functions + SQL) |
| **Maintenance** | $20K/year (occasional enhancements) |
| **Total Year 1** | $68K |
| **Total Year 2-3** | $23K/year |

### Recommendation Score: 9/10

**Best fit** for K-12 SEAA platform given existing architecture and team skills.

---

## Option 2: Drools (Open Source Rules Engine)

### Overview

Drools is a mature, open-source business rules management system (BRMS) written in Java.

### Architecture

```
┌─────────────────────────────────────┐
│      .NET Services (APIs)           │
│  ┌────────┐  ┌────────┐            │
│  │  App   │  │ Award  │            │
│  │Service │  │Service │            │
│  └────┬───┘  └───┬────┘            │
│       │          │                  │
│       └─────┬────┘                  │
│             ▼ (REST API)            │
│    ┌──────────────────┐            │
│    │  Drools Service  │            │
│    │ (Java Container) │            │
│    └─────────┬────────┘            │
│              │                      │
│    ┌─────────▼────────┐            │
│    │  Drools Engine   │            │
│    │   (Rete algo)    │            │
│    └─────────┬────────┘            │
│              │                      │
│         ┌────▼─────┐               │
│         │  Rules   │               │
│         │  (DRL)   │               │
│         └──────────┘               │
└─────────────────────────────────────┘
         │
         ▼
  ┌──────────────┐
  │Azure Container│
  │     Apps     │
  └──────────────┘
```

### Technical Details

**Rule Definition Format (DRL):**
```drl
rule "ESA+ Age Eligibility"
  when
    $application : Application(
      student.age >= 5,
      student.age <= 20
    )
  then
    $application.setEligibilityStatus("PASS");
    $application.setMessage("Age requirement met");
end

rule "ESA+ Age Ineligibility"
  when
    $application : Application(
      student.age < 5 || student.age > 20
    )
  then
    $application.setEligibilityStatus("FAIL");
    $application.setMessage("Student must be 5-20 years old");
end
```

### Pros

✅ **Mature Technology:**
- 20+ years of development
- Battle-tested in enterprise environments
- Large community and resources

✅ **Advanced Features:**
- Complex event processing (CEP)
- Rule chaining and inference
- Forward/backward chaining
- Agenda groups for rule organization

✅ **Performance:**
- Rete algorithm (optimized pattern matching)
- Handles complex rule sets efficiently
- Well-optimized for high throughput

✅ **Tooling:**
- Drools Workbench (web-based rule authoring)
- Decision tables (Excel-based rule definition)
- Visual rule designer

✅ **Standards:**
- Implements DMN (Decision Model and Notation)
- Industry-standard approach

### Cons

❌ **Technology Mismatch:**
- Java-based (platform is .NET)
- Requires separate Java runtime/container
- Additional infrastructure complexity

❌ **Integration Overhead:**
- Must expose Drools via REST API
- Adds network hop (latency)
- Separate deployment pipeline

❌ **Learning Curve:**
- Team must learn DRL syntax
- Different paradigm from C# development
- Rete algorithm concepts unfamiliar

❌ **Hosting Costs:**
- Requires Azure Container Apps (higher cost than Functions)
- Java runtime overhead
- More expensive than serverless

❌ **Overkill:**
- Advanced features not needed for K-12 use case
- Complexity exceeds requirements

### Cost Analysis

| Category | Cost |
|----------|------|
| **Initial Development** | $75K (5 weeks: 3 for learning + 2 for integration) |
| **Infrastructure (Container Apps)** | $15K/year |
| **Maintenance** | $25K/year (team less familiar) |
| **Total Year 1** | $115K |
| **Total Year 2-3** | $40K/year |

### Recommendation Score: 6/10

**Viable option** but technology mismatch and added complexity reduce appeal.

---

## Option 3: NRules (Open Source .NET Rules Engine)

### Overview

NRules is an open-source rules engine for .NET, inspired by Drools but native to .NET ecosystem.

### Architecture

Similar to Option 1 (Custom .NET), but using NRules library instead of custom engine.

### Technical Details

**Rule Definition (C# DSL):**
```csharp
public class ESAPlusAgeEligibilityRule : Rule
{
    public override void Define()
    {
        Student student = null;
        Application application = null;

        When()
            .Match<Application>(() => application)
            .Match<Student>(() => student, 
                s => s.Age >= 5 && s.Age <= 20);

        Then()
            .Do(ctx => application.SetEligibilityStatus("PASS"))
            .Do(ctx => application.SetMessage("Age requirement met"));
    }
}
```

### Pros

✅ **Native .NET:**
- C# rules (no new language)
- Runs in same runtime as application
- Easy integration

✅ **Open Source:**
- Free (no licensing)
- Active development
- Community support

✅ **Rete Algorithm:**
- Efficient pattern matching
- Good performance

### Cons

❌ **Less Mature:**
- Smaller community than Drools
- Fewer resources and examples
- Less battle-tested

❌ **Limited Tooling:**
- No visual designer
- No web-based rule authoring
- Rules defined in code (not ideal for business analysts)

❌ **Flexibility:**
- Less flexible than custom solution
- Must work within NRules paradigm
- Cannot easily customize for specific needs

### Cost Analysis

| Category | Cost |
|----------|------|
| **Initial Development** | $60K (4 weeks: learning + integration) |
| **Infrastructure** | $3K/year |
| **Maintenance** | $25K/year |
| **Total Year 1** | $88K |
| **Total Year 2-3** | $28K/year |

### Recommendation Score: 7/10

**Good middle ground**, but limited tooling for business analysts is a concern.

---

## Option 4: Microsoft Business Rules Engine (BRE)

### Overview

Microsoft BRE is a legacy rules engine that was part of BizTalk Server, now available standalone.

### Pros

✅ **Microsoft Technology:**
- Official Microsoft product
- Integrates with Azure

✅ **Mature:**
- Been around since 2000s
- Proven in enterprise

### Cons

❌ **Legacy Technology:**
- No longer actively developed
- BizTalk is being sunset
- Unclear future support

❌ **Heavyweight:**
- Designed for complex EAI scenarios
- Overkill for K-12 use case

❌ **Licensing:**
- May require BizTalk licensing (expensive)
- Complex licensing model

❌ **Modern Alternatives:**
- Microsoft recommends Logic Apps or Power Automate instead
- BRE not recommended for new projects

### Cost Analysis

Not recommended - licensing costs unclear, technology outdated.

### Recommendation Score: 3/10

**Not recommended** due to legacy status and uncertain future.

---

## Option 5: Azure Logic Apps (Low-Code Rules)

### Overview

Azure Logic Apps provides visual workflow designer that could be used for simple rules.

### Architecture

```
┌─────────────────────────────────────┐
│      .NET Services (APIs)           │
│  ┌────────┐  ┌────────┐            │
│  │  App   │  │ Award  │            │
│  │Service │  │Service │            │
│  └────┬───┘  └───┬────┘            │
│       │          │                  │
│       └─────┬────┘                  │
│             ▼ (Trigger)             │
│    ┌──────────────────┐            │
│    │  Logic Apps      │            │
│    │  (Visual Rules)  │            │
│    └──────────────────┘            │
└─────────────────────────────────────┘
```

### Pros

✅ **Low-Code:**
- Visual designer (business users can create)
- No coding required for simple rules

✅ **Azure Native:**
- Fully managed service
- Auto-scaling
- Built-in monitoring

✅ **Integration:**
- Many connectors (email, database, APIs)
- Easy to integrate with other services

### Cons

❌ **Not a True Rules Engine:**
- Designed for workflows, not business rules
- No rule chaining or inference
- Limited conditional logic

❌ **Complexity Limitations:**
- Cannot handle complex rule sets (350+ rules)
- No versioning for rules
- Difficult to test systematically

❌ **Cost:**
- Expensive at scale (per-action pricing)
- 350+ rules evaluated frequently = high cost

❌ **Maintenance:**
- Visual rules difficult to version control
- No code review process
- Hard to maintain at scale

### Cost Analysis

| Category | Cost |
|----------|------|
| **Initial Development** | $30K (simple setup) |
| **Infrastructure** | $30K-50K/year (high action volume) |
| **Maintenance** | $40K/year (visual maintenance difficult) |
| **Total Year 1** | $80K |
| **Total Year 2-3** | $70K/year |

### Recommendation Score: 4/10

**Not suitable** for complex rule management at K-12 SEAA scale.

---

## Comparison Matrix

| Criteria | Custom .NET | Drools | NRules | MS BRE | Logic Apps |
|----------|-------------|--------|--------|--------|------------|
| **Technology Fit** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐ |
| **Integration Ease** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Complexity Support** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐ |
| **Business User Access** | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Cost (Year 1)** | ⭐⭐⭐⭐⭐ ($68K) | ⭐⭐⭐ ($115K) | ⭐⭐⭐⭐ ($88K) | ⭐⭐ (unknown) | ⭐⭐⭐ ($80K) |
| **Time-to-Market** | ⭐⭐⭐⭐⭐ (12-15w) | ⭐⭐⭐ (18-20w) | ⭐⭐⭐⭐ (15-16w) | ⭐⭐ | ⭐⭐⭐⭐⭐ (8-10w) |
| **Maintenance** | ⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐ | ⭐⭐ |
| **Maturity** | ⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| **Performance** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| **Tooling** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **TOTAL SCORE** | **41/50** | **38/50** | **34/50** | **27/50** | **32/50** |

---

## Recommendation

### Primary Recommendation: Custom .NET Rules Engine (Option 1)

**Score:** 41/50

**Rationale:**

1. **Best Technology Fit (5/5)**
   - Seamless integration with existing Azure/.NET stack
   - No runtime mismatch or extra infrastructure
   - Team already proficient in C# and Azure Functions

2. **Lowest Cost (5/5)**
   - $68K Year 1, $23K/year ongoing
   - No licensing fees
   - Serverless pricing model

3. **Fastest Time-to-Market (5/5)**
   - 12-15 weeks total timeline
   - Can start immediately
   - No procurement or learning curve

4. **Full Control (5/5)**
   - Customize rule syntax for business needs
   - Optimize for K-12 specific use cases
   - Easy to extend and evolve

5. **Acceptable Trade-offs**
   - Less mature than Drools (but sufficient for needs)
   - Requires initial development effort (one-time cost)
   - Limited out-of-box tooling (but can build what's needed)

### Secondary Recommendation: NRules (Option 3)

**Score:** 34/50

**If custom development is not desired**, NRules provides a good middle ground:
- Native .NET integration
- Open source (no licensing)
- Rete algorithm for performance
- **Trade-off:** Less flexible, limited tooling for business users

---

## Implementation Plan for Custom .NET Rules Engine

### Phase 1: Core Engine (Week 1-2)

**Deliverables:**
- Rule parser (YAML → Rule objects)
- Condition evaluator (operators: equals, between, in, contains, regex)
- Action executor (set result, set message, trigger event)
- Rule chaining (dependencies)

**Example Code:**
```csharp
// Rule definition
var rule = new Rule
{
    Id = "ESA-ELIG-001",
    Name = "ESA+ Age Eligibility",
    Conditions = new[]
    {
        new Condition
        {
            Field = "student.age",
            Operator = Operator.Between,
            Value = new[] { 5, 20 }
        }
    },
    Actions = new RuleActions
    {
        When = new[]
        {
            new SetResultAction { Result = "PASS" },
            new SetMessageAction { Message = "Age requirement met" }
        },
        Otherwise = new[]
        {
            new SetResultAction { Result = "FAIL" },
            new SetMessageAction { Message = "Student must be 5-20 years old" }
        }
    }
};

// Evaluate rule
var context = new Dictionary<string, object>
{
    ["student"] = new { age = 12, name = "John Doe" }
};

var result = ruleEngine.Evaluate(rule, context);
// result.Status = "PASS"
// result.Message = "Age requirement met"
```

### Phase 2: Storage & API (Week 2-3)

**Deliverables:**
- Azure SQL schema for rule storage
- Rule repository (CRUD operations)
- REST API (Azure Function)
- Rule versioning
- Rule caching (Redis)

**API Endpoints:**
```
POST /api/rules/evaluate
GET /api/rules
GET /api/rules/{id}
GET /api/rules/{id}/versions
POST /api/rules (admin only)
PUT /api/rules/{id} (admin only)
DELETE /api/rules/{id} (admin only)
```

### Phase 3: Authoring Tools (Week 3)

**Deliverables:**
- Admin UI for rule management
- YAML editor with syntax highlighting
- Rule preview/test functionality
- Rule approval workflow

---

## Conclusion

**Recommendation:** **Custom .NET Rules Engine** (Option 1)

The custom .NET rules engine provides the best balance of:
- ✅ Technology fit with existing architecture
- ✅ Cost-effectiveness ($68K Year 1)
- ✅ Time-to-market (12-15 weeks)
- ✅ Team capabilities and skills
- ✅ Flexibility for K-12-specific needs

While Drools and NRules are viable alternatives, the additional complexity, cost, or limitations make them less optimal for the K-12 SEAA platform.

**Next Step:** Proceed with implementation planning for Custom .NET Rules Engine as outlined in Implementation Roadmap document.

---

**Document Version:** 1.0  
**Last Updated:** October 23, 2025  
**Status:** Ready for Decision
