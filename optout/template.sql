USE %wikidb%;

-- put today's numbers into a temporary table
REPLACE INTO
    staging.mediaviewer_optout (day, wikidb, all_touched, all_edited, all_active, all_very_active, 
        optout_total, optout_touched, optout_edited, optout_active, optout_very_active)
SELECT
    CURDATE() day,
    '%wikidb%' wikidb,
    SUM(1) all_touched,
    SUM(edits_in_last_30_days > 0) all_edited,
    SUM(edits_in_last_30_days >= 5) all_active,
    SUM(edits_in_last_30_days >= 100) all_very_active,
    (SELECT COUNT(*) FROM user_properties WHERE up_property = 'multimediaviewer-enable') optout_total,
    SUM(up_value IS NOT NULL) optout_touched,
    SUM(edits_in_last_30_days > 0 AND up_value IS NOT NULL) optout_edited,
    SUM(edits_in_last_30_days >= 5 AND up_value IS NOT NULL) optout_active,
    SUM(edits_in_last_30_days >= 100 AND up_value IS NOT NULL) optout_very_active
FROM
    user
    LEFT JOIN user_properties ON user_id = up_user AND up_property = 'multimediaviewer-enable'
    LEFT JOIN user_groups ON ug_user = user_id AND ug_group = 'bot'
    LEFT JOIN (
        SELECT
            user_id,
            SUM(contribs) edits_in_last_30_days
        FROM
            user_daily_contribs
        WHERE
            day >= NOW() - INTERVAL 30 DAY
        GROUP BY
            user_id
    ) edits_in_30 ON edits_in_30.user_id = user.user_id
WHERE
    ug_user IS NULL  -- not a bot
    AND user_touched > NOW() - INTERVAL 30 DAY
;

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
WHERE
    wikidb = '%wikidb%'
;
