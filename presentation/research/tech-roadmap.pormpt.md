# Technology Roadmap Prompt

## Inputs

**TARGET**: "Provider Management (12+ features)"

## Examples

Based on the "Examples":
"1. household-and-student-management.md"
"2. verification-and-compliance.md"
"3. admin-portal-operations.md"

## Context

The following doc contains a list of (6) critical functional domains (**TARGET** items) of the K12/SEAA system.

"overview.md"

## Instructions

I need you to create a markdown document for the **TARGET**; that will create the same output in the reports/sources docs for each of the (6) critical functional domains listed in the overview.md document. The prompt should ask for the target topic to perform the following analysis on:

- an overview of the target
- an categorized breakdown of the workflows (use the "Examples" documents as reference and inspriation.
  - create markdown sections for each of the workflow items.
- a Thorough Description that includes the workflows and business importance.
  - create markdown sections for each of the workflow items.
- a Dependencies section that identifies domain, cross-cutting concern, and external integration dependencies.
  - create markdown sections for each of the depdency items.
- a section for Critical Success and Risk Factors (see "Examples")
  - create markdown sections for each of the factor items.

## Notes

We are allowing the team to continue with the current Enrollment Builder and Data Mapper project (because it was promised to the client, and the team believes they can complete within a few Sprints). Other non-enrollment features should use Angular Reactive Forms and conventional Angular practices.
