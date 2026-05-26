-- ==========================================================
-- File: 03_reporting_views.sql
-- Purpose: Creates reporting views for KPI dashboards and operational visibility.
-- ==========================================================

CREATE OR REPLACE VIEW vw_request_status_summary AS
SELECT
    status,
    priority,
    COUNT(*) AS total_requests
FROM business_process_requests
GROUP BY status, priority;

CREATE OR REPLACE VIEW vw_approval_dashboard AS
SELECT
    r.request_id,
    r.request_title,
    r.request_type,
    r.priority,
    r.status,
    u.full_name AS requestor_name,
    a.approval_status,
    approver.full_name AS approver_name,
    a.action_date,
    a.comments
FROM business_process_requests r
JOIN app_users u
    ON r.requestor_id = u.user_id
LEFT JOIN approval_history a
    ON r.request_id = a.request_id
LEFT JOIN app_users approver
    ON a.approver_id = approver.user_id;

CREATE OR REPLACE VIEW vw_kpi_reporting AS
SELECT
    r.request_id,
    r.request_title,
    r.request_type,
    r.priority,
    r.status,
    k.cycle_time_days,
    k.sla_status,
    k.report_period,
    CASE
        WHEN k.sla_status = 'BREACHED' THEN 'Needs Attention'
        WHEN k.sla_status = 'WITHIN_SLA' THEN 'Healthy'
        ELSE 'Pending Review'
    END AS executive_summary
FROM business_process_requests r
LEFT JOIN process_kpi_metrics k
    ON r.request_id = k.request_id;
