SELECT * FROM ( SELECT * FROM ( SELECT * FROM ( SELECT * FROM ( SELECT * FROM ( SELECT * FROM ( SELECT * FROM ( SELECT * FROM ( SELECT * FROM ( SELECT * FROM (SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring FROM (
SELECT timestamp FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT timestamp FROM MultimediaViewerNetworkPerformance_7488625
UNION ALL
SELECT timestamp FROM MultimediaViewerNetworkPerformance_7917896
) AS MultimediaViewerNetworkPerformanceUnioned WHERE timestamp >= TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY)) GROUP BY datestring ORDER BY datestring ASC) dates

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
EXP(AVG(LOG(event_total))) AS userinfo_time_mean,
EXP(STD(LOG(event_total))) AS userinfo_time_std,
COUNT(*) AS userinfo_sample_size FROM (
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7488625
UNION ALL
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7917896
) AS MultimediaViewerNetworkPerformanceUnioned WHERE wiki = 'huwiki' AND timestamp >= TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY)) AND event_type = 'userinfo' GROUP BY datestring ORDER BY datestring ASC ) userinfo_stats USING (datestring) ) date_userinfo

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
EXP(AVG(LOG(event_total))) AS imageinfo_time_mean,
EXP(STD(LOG(event_total))) AS imageinfo_time_std,
COUNT(*) AS imageinfo_sample_size FROM (
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7488625
UNION ALL
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7917896
) AS MultimediaViewerNetworkPerformanceUnioned WHERE wiki = 'huwiki' AND timestamp >= TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY)) AND event_type = 'imageinfo' GROUP BY datestring ORDER BY datestring ASC ) imageinfo_stats USING (datestring) ) date_userinfo_imageinfo

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
EXP(AVG(LOG(event_total))) AS thumbnailinfo_time_mean,
EXP(STD(LOG(event_total))) AS thumbnailinfo_time_std,
COUNT(*) AS thumbnailinfo_sample_size FROM (
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7488625
UNION ALL
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7917896
) AS MultimediaViewerNetworkPerformanceUnioned WHERE wiki = 'huwiki' AND timestamp >= TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY)) AND event_type = 'thumbnailinfo' GROUP BY datestring ORDER BY datestring ASC ) thumbnailinfo_stats USING (datestring) ) date_userinfo_imageinfo_thumbnailinfo

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
EXP(AVG(LOG(event_total))) AS filerepoinfo_time_mean,
EXP(STD(LOG(event_total))) AS filerepoinfo_time_std,
COUNT(*) AS filerepoinfo_sample_size FROM (
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7488625
UNION ALL
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7917896
) AS MultimediaViewerNetworkPerformanceUnioned WHERE wiki = 'huwiki' AND timestamp >= TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY)) AND event_type = 'filerepoinfo' GROUP BY datestring ORDER BY datestring ASC ) filerepoinfo_stats USING (datestring) ) date_userinfo_imageinfo_thumbnailinfo_filerepoinfo

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
EXP(AVG(LOG(event_total))) AS imageusage_time_mean,
EXP(STD(LOG(event_total))) AS imageusage_time_std,
COUNT(*) AS imageusage_sample_size FROM (
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7488625
UNION ALL
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7917896
) AS MultimediaViewerNetworkPerformanceUnioned WHERE wiki = 'huwiki' AND timestamp >= TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY)) AND event_type = 'imageusage' GROUP BY datestring ORDER BY datestring ASC ) imageusage_stats USING (datestring) ) date_userinfo_imageinfo_thumbnailinfo_filerepoinfo_imageusage

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
EXP(AVG(LOG(event_total))) AS globalusage_time_mean,
EXP(STD(LOG(event_total))) AS globalusage_time_std,
COUNT(*) AS globalusage_sample_size FROM (
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7488625
UNION ALL
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7917896
) AS MultimediaViewerNetworkPerformanceUnioned WHERE wiki = 'huwiki' AND timestamp >= TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY)) AND event_type = 'globalusage' GROUP BY datestring ORDER BY datestring ASC ) globalusage_stats USING (datestring) ) date_userinfo_imageinfo_thumbnailinfo_filerepoinfo_imageusage_globalusage

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
EXP(AVG(LOG(event_total))) AS image_time_mean,
EXP(STD(LOG(event_total))) AS image_time_std,
COUNT(*) AS image_sample_size FROM (
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7488625
UNION ALL
SELECT event_type, event_total, timestamp, wiki FROM MultimediaViewerNetworkPerformance_7917896
) AS MultimediaViewerNetworkPerformanceUnioned WHERE wiki = 'huwiki' AND timestamp >= TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY)) AND event_type = 'image' GROUP BY datestring ORDER BY datestring ASC ) image_stats USING (datestring) ) date_userinfo_imageinfo_thumbnailinfo_filerepoinfo_imageusage_globalusage_image

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
EXP(AVG(LOG(event_total))) AS imagemiss_time_mean,
EXP(STD(LOG(event_total))) AS imagemiss_time_std,
COUNT(*) AS imagemiss_sample_size FROM (
SELECT event_type, event_total, timestamp, wiki, event_XCache, event_varnish1hits, event_varnish2hits, event_varnish3hits FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp, wiki, event_XCache, event_varnish1hits, event_varnish2hits, event_varnish3hits FROM MultimediaViewerNetworkPerformance_7488625
UNION ALL
SELECT event_type, event_total, timestamp, wiki, event_XCache, event_varnish1hits, event_varnish2hits, event_varnish3hits FROM MultimediaViewerNetworkPerformance_7917896
) AS MultimediaViewerNetworkPerformanceUnioned WHERE wiki = 'huwiki' AND timestamp >= TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY)) AND LENGTH(event_XCache) > 0 AND event_varnish1hits = 0 AND event_varnish2hits = 0 AND event_varnish2hits = 0 AND event_type = 'image' GROUP BY datestring ORDER BY datestring ASC ) imagemiss_stats USING (datestring) ) date_userinfo_imageinfo_thumbnailinfo_filerepoinfo_imageusage_globalusage_image_imagemiss

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
EXP(AVG(LOG(event_total))) AS imagehit_time_mean,
EXP(STD(LOG(event_total))) AS imagehit_time_std,
COUNT(*) AS imagehit_sample_size FROM (
SELECT event_type, event_total, timestamp, wiki, event_XCache, event_varnish1hits, event_varnish2hits, event_varnish3hits FROM MultimediaViewerNetworkPerformance_7393226
UNION ALL
SELECT event_type, event_total, timestamp, wiki, event_XCache, event_varnish1hits, event_varnish2hits, event_varnish3hits FROM MultimediaViewerNetworkPerformance_7488625
UNION ALL
SELECT event_type, event_total, timestamp, wiki, event_XCache, event_varnish1hits, event_varnish2hits, event_varnish3hits FROM MultimediaViewerNetworkPerformance_7917896
) AS MultimediaViewerNetworkPerformanceUnioned WHERE wiki = 'huwiki' AND timestamp >= TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY)) AND LENGTH(event_XCache) > 0 AND (event_varnish1hits > 0 OR event_varnish2hits > 0 OR event_varnish2hits > 0) AND event_type = 'image' GROUP BY datestring ORDER BY datestring ASC ) imagehit_stats USING (datestring) ) date_userinfo_imageinfo_thumbnailinfo_filerepoinfo_imageusage_globalusage_image_imagehit