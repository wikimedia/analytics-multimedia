SELECT event_country as country, AVG(event_total) as mean, STD(event_total) as std, COUNT(event_total) as sample_size FROM (
SELECT event_total, event_country, event_type FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_total, event_country, event_type FROM MultimediaViewerNetworkPerformance_7488625
UNION ALL
SELECT event_total, event_country, event_type FROM MultimediaViewerNetworkPerformance_7917896
) MultimediaViewerNetworkPerformanceUnioned WHERE event_type = 'image' AND event_country != '' GROUP BY country HAVING sample_size > 10 ORDER BY mean ASC