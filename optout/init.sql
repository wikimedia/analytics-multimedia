-- schema for the table holding intermediate optout results
-- the table is stored on analytics-store, in the staging DB
CREATE TABLE mediaviewer_optout (
    day DATE,
    wikidb VARCHAR(16) COMMENT 'wiki dbname (e.g. "commonswiki")',
    all_touched INT COMMENT 'number of active users per user_touched (user_touched > now() - 30 days)',
    all_active INT COMMENT 'number of active users per standard definition (at least 5 edits in last 30 days)',
    optout_total INT COMMENT 'total number of opted-out users',
    optout_touched INT COMMENT 'opted-out users who are active per user_touched',
    optout_active INT COMMENT 'opted-out users who are active per standard definition'
);
CREATE UNIQUE INDEX mediaviewer_optout_day_wikidb ON mediaviewer_optout (day, wikidb);
CREATE INDEX mediaviewer_optout_wikidb ON mediaviewer_optout (wikidb);
