SELECT
    *
FROM (
    SELECT
        day,
        SUM(file_views) file_views,
        SUM(nonfile_views) nonfile_views
    FROM (
        SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_namespaceId = 6) file_views, SUM(event_namespaceId != 6) nonfile_views
            FROM NavigationTiming_10076863 WHERE %wiki% SUBSTR(timestamp, 1, 4) >= '2014' AND event_action = 'view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_namespaceId = 6) file_views, SUM(event_namespaceId != 6) nonfile_views
            FROM NavigationTiming_8365252 WHERE %wiki% SUBSTR(timestamp, 1, 4) >= '2014' AND event_action = 'view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_namespaceId = 6) file_views, SUM(event_namespaceId != 6) nonfile_views
            FROM NavigationTiming_8477778 WHERE %wiki% SUBSTR(timestamp, 1, 4) >= '2014' AND event_action = 'view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_namespaceId = 6) file_views, SUM(event_namespaceId != 6) nonfile_views
            FROM NavigationTiming_10374055 WHERE %wiki% SUBSTR(timestamp, 1, 4) >= '2014' AND event_action = 'view' GROUP BY day
    ) NavigationTiming
    GROUP BY day
) NavigatonTimingDaily JOIN (
    SELECT
        day,
        SUM(samplingFactor) mmv_views
    FROM (
        SELECT SUBSTR(timestamp, 1, 8) day, COUNT(*) samplingFactor FROM MediaViewer_6054199 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, COUNT(*) samplingFactor FROM MediaViewer_6055641 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, COUNT(*) samplingFactor FROM MediaViewer_6066908 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, COUNT(*) samplingFactor FROM MediaViewer_6636420 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, COUNT(*) samplingFactor FROM MediaViewer_7670440 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, COUNT(*) samplingFactor FROM MediaViewer_8245578 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_samplingFactor) samplingFactor FROM MediaViewer_8572637 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_samplingFactor) samplingFactor FROM MediaViewer_8935662 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_samplingFactor) samplingFactor FROM MediaViewer_9792855 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_samplingFactor) samplingFactor FROM MediaViewer_9989959 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_samplingFactor) samplingFactor FROM MediaViewer_10277480 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_samplingFactor) samplingFactor FROM MediaViewer_10308479 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_samplingFactor) samplingFactor FROM MediaViewer_10536413 WHERE %wiki% event_action = 'image-view' GROUP BY day
        UNION ALL SELECT SUBSTR(timestamp, 1, 8) day, SUM(event_samplingFactor) samplingFactor FROM MediaViewer_10606177 WHERE %wiki% event_action = 'image-view' GROUP BY day
    ) MediaViewer
    GROUP BY day
) MediaViewerDaily USING (day)
ORDER BY day ASC;
