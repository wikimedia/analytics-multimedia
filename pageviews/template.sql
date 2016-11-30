SELECT
    *
FROM (
    SELECT
        CONCAT(SUBSTR(day, 1, 4), '-', SUBSTR(day, 5, 2), '-', SUBSTR(day, 7, 2)) datestring,
        SUM(file_views) * 1000 file_views, -- NavigationTiming is sampled 1:1000
        SUM(nonfile_views) * 1000 nonfile_views
    FROM (
        SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_namespaceId = 6) file_views, SUM(event_namespaceId != 6) nonfile_views
            FROM NavigationTiming_14899847 WHERE %wiki% SUBSTR(timestamp, 1, 4) >= '2014' AND event_action = 'view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_namespaceId = 6) file_views, SUM(event_namespaceId != 6) nonfile_views
            FROM NavigationTiming_15033442 WHERE %wiki% SUBSTR(timestamp, 1, 4) >= '2014' AND event_action = 'view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_namespaceId = 6) file_views, SUM(event_namespaceId != 6) nonfile_views
            FROM NavigationTiming_15396488 WHERE %wiki% SUBSTR(timestamp, 1, 4) >= '2014' AND event_action = 'view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_namespaceId = 6) file_views, SUM(event_namespaceId != 6) nonfile_views
            FROM NavigationTiming_15485142 WHERE %wiki% SUBSTR(timestamp, 1, 4) >= '2014' AND event_action = 'view' GROUP BY day
    ) NavigationTiming
    GROUP BY day
) NavigatonTimingDaily JOIN (
    SELECT
        CONCAT(SUBSTR(day, 1, 4), '-', SUBSTR(day, 5, 2), '-', SUBSTR(day, 7, 2)) datestring,
        SUM(samplingFactor) mmv_views
    FROM (
        SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_samplingFactor) samplingFactor FROM MediaViewer_10277480 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_samplingFactor) samplingFactor FROM MediaViewer_10308479 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_samplingFactor) samplingFactor FROM MediaViewer_10536413 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_samplingFactor) samplingFactor FROM MediaViewer_10606177 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_samplingFactor) samplingFactor FROM MediaViewer_10867062 WHERE %wiki% event_action = 'image-view' GROUP BY day
    ) MediaViewer
    GROUP BY day
) MediaViewerDaily USING (datestring)
ORDER BY day ASC;
