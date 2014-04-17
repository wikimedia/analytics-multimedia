SELECT event_country as country, EXP(AVG(LOG(event_total))) as mean, EXP(STD(LOG(event_total))) as std, COUNT(event_total) as sample_size FROM (
SELECT timestamp, event_total, event_country, event_type FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT timestamp, event_total, event_country, event_type FROM MultimediaViewerNetworkPerformance_7488625
UNION ALL
SELECT timestamp, event_total, event_country, event_type FROM MultimediaViewerNetworkPerformance_7917896
) MultimediaViewerNetworkPerformanceUnioned WHERE event_type != 'image' AND timestamp >= TIMESTAMP(DATE_SUB(NOW(), INTERVAL 10 DAY)) AND event_country != '' GROUP BY country HAVING sample_size > 10 ORDER BY mean ASC