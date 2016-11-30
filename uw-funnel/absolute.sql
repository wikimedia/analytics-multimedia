SELECT
    CONCAT(SUBSTRING(timestamp, 1, 4), '-', SUBSTRING(timestamp, 5, 2), '-', SUBSTRING(timestamp, 7, 2)) AS datestring,
    SUM(CASE WHEN event_step = 'tutorial' THEN 1 ELSE 0 END) AS 'tutorial',
    SUM(CASE WHEN event_step = 'file' THEN 1 ELSE 0 END) AS 'file',
    SUM(CASE WHEN event_step = 'deeds' THEN 1 ELSE 0 END) AS 'deeds',
    SUM(CASE WHEN event_step = 'details' THEN 1 ELSE 0 END) AS 'details',
    SUM(CASE WHEN event_step = 'thanks' THEN 1 ELSE 0 END) AS 'thanks'
FROM
    UploadWizardStep_11772724
WHERE
    timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 30 DAY))
    AND timestamp < TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 1 DAY))
GROUP BY
    datestring
ORDER BY
    datestring ASC
;
