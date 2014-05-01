SET group_concat_max_len = 10485760;
SELECT * FROM (SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring FROM (
SELECT timestamp FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT timestamp FROM MultimediaViewerNetworkPerformance_7488625
UNION ALL
SELECT timestamp FROM MultimediaViewerNetworkPerformance_7917896
) AS MultimediaViewerNetworkPerformanceUnioned WHERE timestamp >= TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY)) GROUP BY datestring ORDER BY datestring ASC) dates

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
SELECT %metricfields% FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT %metricfields% FROM MultimediaViewerNetworkPerformance_7488625
UNION ALL
SELECT %metricfields% FROM MultimediaViewerNetworkPerformance_7917896
) AS MultimediaViewerNetworkPerformanceUnioned WHERE %wiki% timestamp >= TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY)) AND %metricwhere% GROUP BY datestring ORDER BY datestring ASC ) stats USING (datestring)