-- Get statistics, per day, for various actions in Media Viewer.

SELECT CONCAT(SUBSTRING(timestamp, 1, 4), '-', SUBSTRING(timestamp, 5, 2), '-', SUBSTRING(timestamp, 7, 2)) AS datestring,
	SUM(CASE WHEN event_action = 'thumbnail-link-click' THEN 1 ELSE 0 END) AS 'thumbnail-link-click',
	SUM(CASE WHEN event_action = 'enlarge-link-click' THEN 1 ELSE 0 END) AS 'enlarge-link-click',
	SUM(CASE WHEN event_action = 'fullscreen-link-click' THEN 1 ELSE 0 END) AS 'fullscreen-link-click',
	SUM(CASE WHEN event_action = 'defullscreen-link-click' THEN 1 ELSE 0 END) AS 'defullscreen-link-click',
	SUM(CASE WHEN event_action = 'site-link-click' THEN 1 ELSE 0 END) AS 'site-link-click',
	SUM(CASE WHEN event_action = 'close-link-click' THEN 1 ELSE 0 END) AS 'close-link-click',
	SUM(CASE WHEN event_action = 'use-this-file-link-click' THEN 1 ELSE 0 END) AS 'use-this-file-link-click',
	SUM(CASE WHEN event_action = 'image-view' THEN 1 ELSE 0 END) AS 'image-view'

	FROM (
		SELECT timestamp, wiki, event_action FROM MediaViewer_7670440
			UNION ALL
		SELECT timestamp, wiki, event_action FROM MediaViewer_6636420
			UNION ALL
		SELECT timestamp, wiki, event_action FROM MediaViewer_6066908
			UNION ALL
		SELECT timestamp, wiki, event_action FROM MediaViewer_6055641
			UNION ALL
		SELECT timestamp, wiki, event_action FROM MediaViewer_6054199) AS MediaViewerUnioned

	WHERE wiki = 'frwiki' AND timestamp >= TIMESTAMP(DATE_SUB(NOW(), INTERVAL 30 DAY))

	GROUP BY datestring
	ORDER BY  datestring ASC;
