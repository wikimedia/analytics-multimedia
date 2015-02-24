SET group_concat_max_len = 18446744073709551615;
SELECT * FROM (SELECT selected_date AS datestring FROM
(SELECT ADDDATE('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) selected_date from
 (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,
 (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
 (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
 (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,
 (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t4) v
WHERE selected_date BETWEEN TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 90 DAY)) AND TIMESTAMP(CURDATE())) dates

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
EXP(AVG(LOG(event_total))) AS %metricname%_time_mean,
EXP(STD(LOG(event_total))) AS %metricname%_time_std,
COUNT(*) AS %metricname%_sample_size,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 1/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS %metricname%_time_1st_percentile,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 50/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS %metricname%_time_50th_percentile,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 90/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS %metricname%_time_90th_percentile,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 95/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS %metricname%_time_95th_percentile,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 99/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS %metricname%_time_99th_percentile FROM (
SELECT %metricfields% FROM MultimediaViewerNetworkPerformance_7917896
WHERE %wiki% timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 90 DAY)) AND event_total > 20 AND %metricwhere%
UNION ALL
SELECT %metricfields% FROM MultimediaViewerNetworkPerformance_10596581
WHERE %wiki% timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 90 DAY)) AND event_total > 20 AND %metricwhere%
UNION ALL
SELECT %metricfields% FROM MultimediaViewerNetworkPerformance_10774577
WHERE %wiki% timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 90 DAY)) AND event_total > 20 AND %metricwhere%
NION ALL
SELECT %metricfields% FROM MultimediaViewerNetworkPerformance_11030254
WHERE %wiki% timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 90 DAY)) AND event_total > 20 AND %metricwhere%
) AS MultimediaViewerNetworkPerformanceUnioned GROUP BY datestring ORDER BY datestring ASC ) stats USING (datestring) HAVING %metricname%_sample_size IS NOT NULL