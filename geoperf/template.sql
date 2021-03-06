SET group_concat_max_len = 10485760;
SELECT event_country as country,
EXP(AVG(LOG(event_total))) as mean,
EXP(STD(LOG(event_total))) as std,
COUNT(event_total) as sample_size,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 1/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS 1st_percentile,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 50/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS 50th_percentile,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 90/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS 90th_percentile,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 95/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS 95th_percentile,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 99/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS 99th_percentile
FROM (
SELECT timestamp, event_total, event_country, event_type, wiki FROM MultimediaViewerNetworkPerformance_10774577
WHERE %wiki% %metricwhere% AND timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 10 DAY)) AND event_total > 20 AND event_country != ''
UNION ALL
SELECT timestamp, event_total, event_country, event_type, wiki FROM MultimediaViewerNetworkPerformance_11030254
WHERE %wiki% %metricwhere% AND timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 10 DAY)) AND event_total > 20 AND event_country != ''
UNION ALL
SELECT timestamp, event_total, event_country, event_type, wiki FROM MultimediaViewerNetworkPerformance_12458951
WHERE %wiki% %metricwhere% AND timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 10 DAY)) AND event_total > 20 AND event_country != ''
UNION ALL
SELECT timestamp, event_total, event_country, event_type, wiki FROM MultimediaViewerNetworkPerformance_15573630
WHERE %wiki% %metricwhere% AND timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 10 DAY)) AND event_total > 20 AND event_country != ''
) MultimediaViewerNetworkPerformanceUnioned GROUP BY country HAVING sample_size > 10 ORDER BY mean ASC
