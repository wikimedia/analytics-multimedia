SET group_concat_max_len = 10485760;
SELECT * FROM (SELECT DISTINCT(SUBSTR(selected_date, 1, 7)) AS datestring FROM
(SELECT ADDDATE('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) selected_date from
 (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,
 (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,
 (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,
 (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,
 (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t4) v
WHERE selected_date BETWEEN TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 730 DAY)) AND TIMESTAMP(CURDATE())) dates

LEFT OUTER JOIN

( SELECT concat(substring(event_uploadTimestamp, 1, 4), '-', substring(event_uploadTimestamp, 5, 2)) AS datestring,
EXP(AVG(LOG(event_total))) AS image_time_mean,
EXP(STD(LOG(event_total))) AS image_time_std,
COUNT(*) AS image_sample_size,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 1/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS image_time_1st_percentile,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 50/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS image_time_50th_percentile,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 90/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS image_time_90th_percentile,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 95/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS image_time_95th_percentile,
CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(
  GROUP_CONCAT(event_total ORDER BY event_total SEPARATOR ','),
   ',', 99/100 * COUNT(*) + 1), ',', -1) AS DECIMAL) AS image_time_99th_percentile FROM (
SELECT event_type, event_total, event_uploadTimestamp, wiki FROM MultimediaViewerNetworkPerformance_11030254
WHERE event_uploadTimestamp < TIMESTAMP(CURDATE()) AND event_uploadTimestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 730 DAY)) AND event_total > 20 AND event_type = 'image' AND event_varnish1hits = 0 AND event_varnish2hits = 0 AND event_varnish3hits = 0
) AS MultimediaViewerNetworkPerformanceUnioned GROUP BY datestring ORDER BY datestring ASC ) stats USING (datestring) WHERE image_time_mean IS NOT NULL