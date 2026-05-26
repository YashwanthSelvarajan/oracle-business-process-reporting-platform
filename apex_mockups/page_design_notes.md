# Oracle APEX Page Design Notes

## Page 1: Request Dashboard
- Interactive report based on `vw_request_status_summary`
- Filters: Status, Priority, Request Type
- Chart: Request count by status

## Page 2: Approval Review
- Form page for approvers
- Source table: `approval_history`
- Dynamic action: Update request status after approval

## Page 3: KPI Reporting
- Interactive report based on `vw_kpi_reporting`
- Highlight SLA breaches
- Show cycle time trends

## Page 4: Admin Console
- Manage users
- Review workflow history
- Export reports
