-- ==========================================================
-- File: 04_workflow_package.sql
-- Purpose: PL/SQL package for workflow status updates and validation logic.
-- ==========================================================

CREATE OR REPLACE PACKAGE pkg_workflow_automation AS
    PROCEDURE update_request_status (
        p_request_id IN NUMBER,
        p_new_status IN VARCHAR2
    );

    PROCEDURE approve_request (
        p_request_id  IN NUMBER,
        p_approver_id IN NUMBER,
        p_comments    IN VARCHAR2
    );

    FUNCTION get_request_cycle_time (
        p_request_id IN NUMBER
    ) RETURN NUMBER;
END pkg_workflow_automation;
/

CREATE OR REPLACE PACKAGE BODY pkg_workflow_automation AS

    PROCEDURE update_request_status (
        p_request_id IN NUMBER,
        p_new_status IN VARCHAR2
    ) AS
    BEGIN
        IF p_new_status NOT IN ('SUBMITTED', 'IN_REVIEW', 'APPROVED', 'REJECTED', 'COMPLETED') THEN
            RAISE_APPLICATION_ERROR(-20001, 'Invalid request status.');
        END IF;

        UPDATE business_process_requests
        SET status = p_new_status,
            completed_date = CASE
                WHEN p_new_status = 'COMPLETED' THEN SYSDATE
                ELSE completed_date
            END
        WHERE request_id = p_request_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Request ID not found.');
        END IF;

        COMMIT;
    END update_request_status;

    PROCEDURE approve_request (
        p_request_id  IN NUMBER,
        p_approver_id IN NUMBER,
        p_comments    IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO approval_history (
            request_id,
            approver_id,
            approval_status,
            comments,
            action_date
        )
        VALUES (
            p_request_id,
            p_approver_id,
            'APPROVED',
            p_comments,
            SYSDATE
        );

        update_request_status(p_request_id, 'APPROVED');

        COMMIT;
    END approve_request;

    FUNCTION get_request_cycle_time (
        p_request_id IN NUMBER
    ) RETURN NUMBER AS
        v_cycle_time NUMBER;
    BEGIN
        SELECT NVL(completed_date, SYSDATE) - submitted_date
        INTO v_cycle_time
        FROM business_process_requests
        WHERE request_id = p_request_id;

        RETURN ROUND(v_cycle_time, 2);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END get_request_cycle_time;

END pkg_workflow_automation;
/

-- Sample test calls:
-- EXEC pkg_workflow_automation.update_request_status(1, 'IN_REVIEW');
-- EXEC pkg_workflow_automation.approve_request(1, 3, 'Approved after business validation.');
-- SELECT pkg_workflow_automation.get_request_cycle_time(1) FROM dual;
