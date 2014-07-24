-- return the numbers for the recent days
SELECT
    DATE_FORMAT(day, '%Y-%m-%d') as datestring,
    all_touched,
    all_active,
    optout_touched,
    optout_active,
    optout_touched / (all_touched + optout_touched) * 100 optout_touched_percent,
    optout_active / (all_active + optout_active) * 100 optout_active_percent
FROM
    staging.mediaviewer_optout
;
