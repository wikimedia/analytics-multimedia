SELECT
    datestring,
    SUM(miss) / COUNT(*) miss_ratio,
    COUNT(*) *1000 total
FROM (
    SELECT
        (event_varnish1hits = 0 AND event_varnish2hits = 0 AND event_varnish3hits = 0) miss,
        concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) datestring
    FROM
        MultimediaViewerNetworkPerformance_7917896
    WHERE
        -- %wiki%
        event_type = 'image'
        AND LENGTH(event_XCache) > 0
        AND timestamp BETWEEN TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 90 DAY)) AND TIMESTAMP(CURDATE())
UNION ALL
    SELECT
        (event_varnish1hits = 0 AND event_varnish2hits = 0 AND event_varnish3hits = 0) miss,
        concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) datestring
    FROM
        MultimediaViewerNetworkPerformance_10596581
    WHERE
        -- %wiki%
        event_type = 'image'
        AND LENGTH(event_XCache) > 0
        AND timestamp BETWEEN TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 90 DAY)) AND TIMESTAMP(CURDATE())
UNION ALL
    SELECT
        (event_varnish1hits = 0 AND event_varnish2hits = 0 AND event_varnish3hits = 0) miss,
        concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) datestring
    FROM
        MultimediaViewerNetworkPerformance_10774577
    WHERE
        -- %wiki%
        event_type = 'image'
        AND LENGTH(event_XCache) > 0
        AND timestamp BETWEEN TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 90 DAY)) AND TIMESTAMP(CURDATE())

) MultimediaViewerNetworkPerformanceUnioned
GROUP BY datestring
ORDER BY datestring ASC;
