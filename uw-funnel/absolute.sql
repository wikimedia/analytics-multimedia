SELECT
    CONCAT(SUBSTRING(timestamp, 1, 4), '-', SUBSTRING(timestamp, 5, 2), '-', SUBSTRING(timestamp, 7, 2)) AS datestring,
    event_step AS step,
    COUNT(*) AS survivors
FROM
    UploadWizardStep_8851805
WHERE timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 30 DAY))
AND timestamp < TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 1 DAY))
GROUP BY
    datestring, event_step
ORDER BY datestring ASC