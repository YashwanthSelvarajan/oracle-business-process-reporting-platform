# Test Scenarios

| Test Case | Scenario | Expected Result |
|---|---|---|
| TC001 | Insert valid request | Request is created successfully |
| TC002 | Update request to IN_REVIEW | Status changes successfully |
| TC003 | Approve valid request | Approval history is created and request status becomes APPROVED |
| TC004 | Use invalid status | PL/SQL package raises validation error |
| TC005 | Query KPI view | Dashboard-ready KPI output is returned |
