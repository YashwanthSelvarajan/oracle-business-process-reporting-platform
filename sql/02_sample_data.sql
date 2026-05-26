-- ==========================================================
-- File: 02_sample_data.sql
-- Purpose: Inserts sample users, requests, approvals, and KPI metrics.
-- ==========================================================

INSERT INTO app_users (full_name, email, user_role, department)
VALUES ('Yashwanth Selvarajan', 'yashwanth.selvarajan@example.com', 'ANALYST', 'Business Technology');

INSERT INTO app_users (full_name, email, user_role, department)
VALUES ('Priya Raman', 'priya.raman@example.com', 'REQUESTOR', 'Operations');

INSERT INTO app_users (full_name, email, user_role, department)
VALUES ('Michael Carter', 'michael.carter@example.com', 'APPROVER', 'Finance');

INSERT INTO business_process_requests
(request_title, request_type, requestor_id, priority, status, business_impact)
VALUES
('Automate Monthly KPI Report', 'Reporting Automation', 2, 'HIGH', 'SUBMITTED',
 'Reduces manual reporting effort and improves monthly executive reporting visibility.');

INSERT INTO business_process_requests
(request_title, request_type, requestor_id, priority, status, business_impact)
VALUES
('Create Approval Dashboard', 'Workflow Tracking', 2, 'MEDIUM', 'IN_REVIEW',
 'Provides business users with centralized request and approval status tracking.');

INSERT INTO approval_history
(request_id, approver_id, approval_status, comments)
VALUES
(1, 3, 'PENDING', 'Initial review pending from finance approver.');

INSERT INTO approval_history
(request_id, approver_id, approval_status, comments)
VALUES
(2, 3, 'APPROVED', 'Approved after confirming workflow requirements.');

INSERT INTO process_kpi_metrics
(request_id, cycle_time_days, sla_status, report_period)
VALUES
(1, 3, 'WITHIN_SLA', '2026-Q1');

INSERT INTO process_kpi_metrics
(request_id, cycle_time_days, sla_status, report_period)
VALUES
(2, 7, 'BREACHED', '2026-Q1');

COMMIT;
