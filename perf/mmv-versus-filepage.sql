SELECT * FROM ( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring
	FROM MultimediaViewerVersusPageFilePerformance_7907636 WHERE timestamp IS NOT NULL AND userAgent LIKE '%Linux i686%' GROUP BY datestring ORDER BY datestring ASC) dates

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
	AVG(event_duration) AS file_page_mean,
	STD(event_duration) AS file_page_std
	FROM MultimediaViewerVersusPageFilePerformance_7907636 WHERE event_type = 'file-page' AND userAgent LIKE '%Linux i686%' GROUP BY datestring ) file_page_stats USING (datestring)

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
	AVG(event_duration) AS mmv_cold_mean,
	STD(event_duration) AS mmv_cold_std
	FROM MultimediaViewerVersusPageFilePerformance_7907636 WHERE event_type = 'mmv' AND userAgent LIKE '%Linux i686%' AND event_cache = 'cold' AND event_windowSize = 'average' GROUP BY datestring ) mmv_cold_stats USING (datestring)

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
	AVG(event_duration) AS mmv_warm_mean,
	STD(event_duration) AS mmv_warm_std
	FROM MultimediaViewerVersusPageFilePerformance_7907636 WHERE event_type = 'mmv' AND userAgent LIKE '%Linux i686%' AND event_cache = 'warm' AND event_windowSize = 'average' GROUP BY datestring ) mmv_warm_stats USING (datestring)

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
	AVG(event_duration) AS mmv_cold_large_mean,
	STD(event_duration) AS mmv_cold_large_std
	FROM MultimediaViewerVersusPageFilePerformance_7907636 WHERE event_type = 'mmv' AND userAgent LIKE '%Linux i686%' AND event_cache = 'cold' AND event_windowSize = 'large' GROUP BY datestring ) mmv_cold_large_stats USING (datestring)

LEFT OUTER JOIN

( SELECT concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) AS datestring,
	AVG(event_duration) AS mmv_warm_large_mean,
	STD(event_duration) AS mmv_warm_large_std
	FROM MultimediaViewerVersusPageFilePerformance_7907636 WHERE event_type = 'mmv' AND userAgent LIKE '%Linux i686%' AND event_cache = 'warm' AND event_windowSize = 'large' GROUP BY datestring ) mmv_warm_large_stats USING (datestring)