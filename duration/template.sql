SET @@group_concat_max_len := @@max_allowed_packet;

SELECT * FROM (
    SELECT
        DATE_FORMAT(timestamp, '%Y-%m-%d') AS datestring,
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(event_mediaWikiLoadComplete
            ORDER BY event_mediaWikiLoadComplete SEPARATOR ','), ',', 50/100*COUNT(*)+1), ',', -1) AS filepage_loggedin_50,
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(event_mediaWikiLoadComplete
            ORDER BY event_mediaWikiLoadComplete SEPARATOR ','), ',', 90/100*COUNT(*)+1), ',', -1) AS filepage_loggedin_90,
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(event_mediaWikiLoadComplete
            ORDER BY event_mediaWikiLoadComplete SEPARATOR ','), ',', 95/100*COUNT(*)+1), ',', -1) AS filepage_loggedin_95,
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(event_mediaWikiLoadComplete
            ORDER BY event_mediaWikiLoadComplete SEPARATOR ','), ',', 99/100*COUNT(*)+1), ',', -1) AS filepage_loggedin_99,
        COUNT(*) * 100 AS filepage_loggedin_population_size -- NavigationTiming data is sampled 1:1000
    FROM
        NavigationTiming_8365252
    WHERE
        %wiki%
        event_action = 'view'
        AND event_namespaceId = 6
        AND event_mediaWikiLoadComplete IS NOT NULL
        AND NOT event_isAnon
        AND timestamp < TIMESTAMP(CURDATE()) -- do not show partial data for the current day
        AND timestamp > TIMESTAMP(CURDATE() - INTERVAL 90 DAY)
    GROUP BY
        datestring
) navtiming_loggedin LEFT JOIN (
    SELECT
        DATE_FORMAT(timestamp, '%Y-%m-%d') AS datestring,
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(event_mediaWikiLoadComplete
            ORDER BY event_mediaWikiLoadComplete SEPARATOR ','), ',', 50/100*COUNT(*)+1), ',', -1) AS filepage_anon_50,
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(event_mediaWikiLoadComplete
            ORDER BY event_mediaWikiLoadComplete SEPARATOR ','), ',', 90/100*COUNT(*)+1), ',', -1) AS filepage_anon_90,
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(event_mediaWikiLoadComplete
            ORDER BY event_mediaWikiLoadComplete SEPARATOR ','), ',', 95/100*COUNT(*)+1), ',', -1) AS filepage_anon_95,
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(event_mediaWikiLoadComplete
            ORDER BY event_mediaWikiLoadComplete SEPARATOR ','), ',', 99/100*COUNT(*)+1), ',', -1) AS filepage_anon_99,
        COUNT(*) * 1000 AS filepage_anon_population_size
    FROM
        NavigationTiming_8365252
    WHERE
        %wiki%
        event_action = 'view'
        AND event_namespaceId = 6
        AND event_mediaWikiLoadComplete IS NOT NULL
        AND event_isAnon
        AND timestamp < TIMESTAMP(CURDATE())
        AND timestamp > TIMESTAMP(CURDATE() - INTERVAL 90 DAY)
    GROUP BY
        datestring
) navtiming_anon USING (datestring) LEFT JOIN (
    SELECT
        DATE_FORMAT(timestamp, '%Y-%m-%d') AS datestring,
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(event_duration ORDER BY event_duration SEPARATOR ','), ',', 50/100*COUNT(*)+1), ',', -1) AS mediaviewer_50,
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(event_duration ORDER BY event_duration SEPARATOR ','), ',', 90/100*COUNT(*)+1), ',', -1) AS mediaviewer_90,
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(event_duration ORDER BY event_duration SEPARATOR ','), ',', 95/100*COUNT(*)+1), ',', -1) AS mediaviewer_95,
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(event_duration ORDER BY event_duration SEPARATOR ','), ',', 99/100*COUNT(*)+1), ',', -1) AS mediaviewer_99,
        COUNT(*) * event_samplingFactor AS mediaviewer_population_size
    FROM
        MultimediaViewerDuration_8572641
    WHERE
        %wiki%
        event_duration IS NOT NULL
        AND event_type = 'click-to-first-image'
        AND timestamp < TIMESTAMP(CURDATE())
        AND timestamp > TIMESTAMP(CURDATE() - INTERVAL 90 DAY)
    GROUP BY
        datestring
) mmv_duration USING (datestring)
    ORDER BY
        datestring ASC
;
