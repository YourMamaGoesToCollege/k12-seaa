# Query Builder Research Prompt

You are an expert product + engineering analyst with deep experience designing and documenting dynamic query builders (visual query builders, query-by-example UIs, and programmatic query DSLs). I will provide you with the contents of a specification document (RM12.18 Query Builder-en-US.docx). Your job is to extract a complete, precise, machine-usable specification for the dynamic query builder described in that document.

Produce the following sections exactly and clearly:

Brief summary (3–6 sentences)
One-paragraph high-level description of the builder: purpose, core capabilities, and primary users.
Data model & metadata
List the entity/entities involved and each field/attribute with: name, type (string, number, boolean, date, enum, array, object), allowed values (if enum), display label, whether nullable, whether searchable, and suggested UI widget (textbox, select, date picker, number input, multi-select, toggle).
For fields that are derived or computed, describe derivation logic.
Supported operators
For each field type, list supported operators (equals, not equals, contains, startsWith, endsWith, regex, greater than, less than, between, in, not in, is null, is not null, exists, not exists, any, all, etc.) and the operator semantics in plain language.
For text fields include match-sensitivity (case-insensitive by default?) and locale/collation notes.
For date/time include timezone handling (assume UTC unless specified) and precision (date vs datetime).
Canonical query model (JSON schema)
Provide a canonical JSON structure for queries, including types, required/optional properties, and a small json-schema-like description. Example keys: filter (tree), sort (list), pagination {limit, offset}, projection (fields), metadata (user, timestamp).
Define how logical operators (AND/OR/NOT) and nesting are represented.
Specify how values & operators are encoded (operator tokens, typed values).
SQL translation rules
For each operator and field type, give the SQL translation pattern (parameterized), noting edge cases like NULL, empty strings, arrays, and SQL injection safety guidance.
Show how nested logical groups map to SQL parentheses.
If there are field-to-column mappings or joins needed, describe the mapping rules and example JOIN templates.
UI behaviors & interactions
Describe row-level UI components (how to add/remove groups and rules), how operator/value pickers change dynamically by field type, validation rules (client & server), and helpful UX features (autocomplete, typeahead, fuzzy match toggle, token chips for multi-value, drag-to-reorder).
Accessibility considerations and keyboard interactions (tab order, ARIA roles).
Examples & translations (at least 6)
Provide 6 example scenarios covering simple to complex: single condition, multi-condition with AND/OR, nested groups, range queries, in-list with many values, date-range with timezone.
For each example include: human-readable description, canonical JSON, and the equivalent parameterized SQL with parameters listed separately.
Edge cases, error handling & constraints
List likely edge cases (empty values, conflicting operators, null handling, oversized IN lists, date boundaries, locale differences, invalid enum values) and suggested behavior.
Specify validation error messages and codes.
Performance notes (e.g., avoid leading wildcard LIKE where possible, prefer indexable predicates).
Testing & verification checklist
Give a concise checklist of tests to verify correctness (unit tests for JSON->SQL translation, UI tests for operator/value combos, accessibility tests, performance/load tests).
Give at least 8 concrete test cases with expected JSON and SQL (including boundary cases).
Implementation notes & recommendations
Suggest a minimal API contract (endpoints, request/response shapes) for executing queries server-side and validating query JSON.
Recommend secure parameterization best practices and caching tips.
Suggest libraries or approaches for frontend (React + controlled components, Formik/React Hook Form, controlled tree model) and backend (SQL builder libs, prepared statements, query planner hints).
Constrain your output to these sections in the same order and label each section with its heading number and title. Keep examples compact but precise. When providing SQL use parameter placeholders (e.g., $1, ? or :param) and list parameters separately.

If any assumptions are needed about missing details, explicitly state each assumption in a short bullet list at the end. Keep the whole response in plain text (no markdown code blocks required).

