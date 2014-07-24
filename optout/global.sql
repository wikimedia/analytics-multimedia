-- return the numbers for the recent days
SELECT
    DATE_FORMAT(day, '%Y-%m-%d') as datestring,
    SUM(all_touched) AS all_touched,
    SUM(all_active) AS all_active,
    SUM(optout_touched) AS optout_touched,
    SUM(optout_active) AS optout_active,
    ( optout_touched / all_touched )  * 100 AS optout_touched_percent,
    ( optout_active / all_active ) * 100 AS optout_active_percent,
    SUM(all_very_active) AS all_very_active,
    SUM(optout_very_active) AS optout_very_active,
    ( optout_very_active / all_very_active) * 100 AS optout_very_active_percent
FROM
    staging.mediaviewer_optout
GROUP BY datestring;
