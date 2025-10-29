# RDS Meeting Notes

## Wednesday, October 15, 2025

- Jira Refernces
  - Parent: [Automations and External Integrations](https://cfi-nc.atlassian.net/browse/K12-507)
  - [Enabler and RDS Integration](https://cfi-nc.atlassian.net/browse/K12-2964)
  - [RDS Integration](https://cfi-nc.atlassian.net/browse/K12-3844)

> Attendees: Jill Song, Sumith Mathur, Luke Samuels, Marty Flournary, Phillip Cartwright

- RDS has a turn-around for responses to verify residency of 24 to 48 hours.
  - A RDS response uses a defined schema response that includes error codes for any errors.

### Process Flow

The RDS system will require access to a K12 Azure resource to retrieve `messages` (i.e., requests) for residency evaluation for a target `household`.

RDS uses (2) agencies to provide residency evaluations:

1. DOR: runs on a schedule daily at 7:30 PM EST.
   1. Tax filings
2. DMV: runs on a schedule daily at 7:00 AM EST.
   1. Driver's Licence evaluation
   2. Vehicle Registration by year.

The response from each agency will be processed by RDS to provide a single response from each agency when the agency completes its evaluation. Each request will produce (3) response for the specified `household` residency evaluation.

1. initial response indicating receipt of request for residency evaluation
2. response from DOR
3. response from DMV

> Note: need samples of request and/or response API schema(s) for each item above.

RDS will process or rollup the data from the agencies. RDS will send the `raw data` from each agency evalutions as part of the response. The payload schema from each agency is unique and will require special processing and data storage. This information should be part of the audit log.

### Architecture/Network

RDS requests secure access to an Azure resource (e.g., queue) to retrieve and process residency requests from K12. K12 will be resonsible for adding residency requests to the `queue`. RDS will provide response(s) to a K12 Azure resource (see list of options from RDS team). K12 will process responses for residency. If there is an error an issue, RDS will return a response with specific error code(s).

RDS indicates that we have the opportunity to provide `expand` fields to any request - this information will return as part of the response payload for K12 correlation.

RDS indicates that they do not have any API endpoints for residency evaluation. They are willing to create API endpoints.

### K12 Residency Determination

The K12 system will use the `raw data` from RDS to implement K12 specific business logic and rules to determine residency. Therefore, K12 will be the source of truth for residency for programs managed by the K12 system (i.e., Opportunity Scholarship). K12 will interpret the information from RDS to make its own **residency determination** for the `household`.

> Question: is there residency requirements for ESA+?

- The K12 residency validation needs to include an *appeal process* to allow a household to question the determination.
- All RDS and K12 residency operations should be included in the application audit log system for traceability and external auditing.
- TODO: we should define and document the typical use cases and variants to determine K12 workflows/requirements.

### Residency Process Recommendations

- Use Personator from **Melissa** to *cleanse*, *verify*, or *update* a household's address (physical address). Post Boxes are **NOT** allowed to for use for residency determination. The `address` value should be evaluated using the **Melissa** tools to **correct** and/or **update** the address value.
- A user entering address information should be able to choose/select a `better` address recommended by Melissa.
  - If the user selects the `orignal` address, do not use this address with the advanced Melissa tools to reterive details such as: length of residence.
  - Store any Melissa data during the registration or application process.
  - Store record(s) of decision.

> Note: there may be an edge-case for military housing/address values.

### Data Retention

> See: Lauren

Need more information, requirements, and rules about data retention for residency inforamtion.

### Next Steps

- The K12 Platform and Architecture will review the updated documentation and prosposed architecture.
- RDS is open to more discussions and answering any questions. They are available for quick technical questions as well.
