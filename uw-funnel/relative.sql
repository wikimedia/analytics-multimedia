SELECT
    datestring,
    file_abs / tutorial_abs AS tutorial,
    deeds_abs / file_abs AS file,
    details_abs / deeds_abs AS deeds,
    thanks_abs / details_abs AS details
FROM (
    SELECT
        CONCAT(SUBSTRING(timestamp, 1, 4), '-', SUBSTRING(timestamp, 5, 2), '-', SUBSTRING(timestamp, 7, 2)) AS datestring,
        SUM(CASE WHEN event_step = 'tutorial' THEN 1 ELSE 0 END) AS tutorial_abs,
        SUM(CASE WHEN event_step = 'file' THEN 1 ELSE 0 END) AS file_abs,
        SUM(CASE WHEN event_step = 'deeds' THEN 1 ELSE 0 END) AS deeds_abs,
        SUM(CASE WHEN event_step = 'details' THEN 1 ELSE 0 END) AS details_abs,
        SUM(CASE WHEN event_step = 'thanks' THEN 1 ELSE 0 END) AS thanks_abs
    FROM
        UploadWizardStep_11772724
    WHERE
        timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 30 DAY))
        AND timestamp < TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 1 DAY))
    GROUP BY
        datestring
) uw_funnel_absolute
ORDER BY
    datestring ASC
;
