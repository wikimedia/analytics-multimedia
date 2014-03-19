SELECT * FROM ( SELECT * FROM ( SELECT * FROM ( SELECT * FROM ( SELECT * FROM ( SELECT * FROM ( SELECT * FROM ( SELECT * FROM (SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring FROM (
SELECT * FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT * FROM MultimediaViewerNetworkPerformance_7488625
) AS MultimediaViewerNetworkPerformanceUnioned WHERE timestamp IS NOT NULL GROUP BY datestring ORDER BY datestring ASC) dates

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
AVG(event_total) AS userinfo_time_mean,
STD(event_total) AS userinfo_time_std,
COUNT(*) AS userinfo_sample_size FROM (
SELECT event_type, event_total, timestamp FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp FROM MultimediaViewerNetworkPerformance_7488625
) AS MultimediaViewerNetworkPerformanceUnioned WHERE timestamp IS NOT NULL AND event_type = 'userinfo' GROUP BY datestring ORDER BY datestring ASC ) userinfo_stats USING (datestring) ) date_userinfo

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
AVG(event_total) AS imageinfo_time_mean,
STD(event_total) AS imageinfo_time_std,
COUNT(*) AS imageinfo_sample_size FROM (
SELECT event_type, event_total, timestamp FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp FROM MultimediaViewerNetworkPerformance_7488625
) AS MultimediaViewerNetworkPerformanceUnioned WHERE timestamp IS NOT NULL AND event_type = 'imageinfo' GROUP BY datestring ORDER BY datestring ASC ) imageinfo_stats USING (datestring) ) date_userinfo_imageinfo

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
AVG(event_total) AS thumbnailinfo_time_mean,
STD(event_total) AS thumbnailinfo_time_std,
COUNT(*) AS thumbnailinfo_sample_size FROM (
SELECT event_type, event_total, timestamp FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp FROM MultimediaViewerNetworkPerformance_7488625
) AS MultimediaViewerNetworkPerformanceUnioned WHERE timestamp IS NOT NULL AND event_type = 'thumbnailinfo' GROUP BY datestring ORDER BY datestring ASC ) imageinfo_stats USING (datestring) ) date_userinfo_imageinfo_thumbnailinfo

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
AVG(event_total) AS filerepoinfo_time_mean,
STD(event_total) AS filerepoinfo_time_std,
COUNT(*) AS filerepoinfo_sample_size FROM (
SELECT event_type, event_total, timestamp FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp FROM MultimediaViewerNetworkPerformance_7488625
) AS MultimediaViewerNetworkPerformanceUnioned WHERE timestamp IS NOT NULL AND event_type = 'filerepoinfo' GROUP BY datestring ORDER BY datestring ASC ) imageinfo_stats USING (datestring) ) date_userinfo_imageinfo_thumbnailinfo_filerepoinfo

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
AVG(event_total) AS imageusage_time_mean,
STD(event_total) AS imageusage_time_std,
COUNT(*) AS imageusage_sample_size FROM (
SELECT event_type, event_total, timestamp FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp FROM MultimediaViewerNetworkPerformance_7488625
) AS MultimediaViewerNetworkPerformanceUnioned WHERE timestamp IS NOT NULL AND event_type = 'imageusage' GROUP BY datestring ORDER BY datestring ASC ) imageinfo_stats USING (datestring) ) date_userinfo_imageinfo_thumbnailinfo_filerepoinfo_imageusage

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
AVG(event_total) AS globalusage_time_mean,
STD(event_total) AS globalusage_time_std,
COUNT(*) AS globalusage_sample_size FROM (
SELECT event_type, event_total, timestamp FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp FROM MultimediaViewerNetworkPerformance_7488625
) AS MultimediaViewerNetworkPerformanceUnioned WHERE timestamp IS NOT NULL AND event_type = 'globalusage' GROUP BY datestring ORDER BY datestring ASC ) imageinfo_stats USING (datestring) ) date_userinfo_imageinfo_thumbnailinfo_filerepoinfo_imageusage_globalusage

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
AVG(event_total) AS image_time_mean,
STD(event_total) AS image_time_std,
COUNT(*) AS image_sample_size FROM (
SELECT event_type, event_total, timestamp FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp FROM MultimediaViewerNetworkPerformance_7488625
) AS MultimediaViewerNetworkPerformanceUnioned WHERE timestamp IS NOT NULL AND event_type = 'image' GROUP BY datestring ORDER BY datestring ASC ) imageinfo_stats USING (datestring) ) date_userinfo_imageinfo_thumbnailinfo_filerepoinfo_imageusage_globalusage_image