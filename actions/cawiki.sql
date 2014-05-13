-- Get statistics, per day, for various actions in Media Viewer.

SELECT CONCAT(SUBSTRING(timestamp, 1, 4), '-', SUBSTRING(timestamp, 5, 2), '-', SUBSTRING(timestamp, 7, 2)) AS datestring,
	SUM(CASE WHEN event_action IN ('thumbnail-link-click', 'thumbnail') THEN 1 ELSE 0 END) AS 'thumbnail',
	SUM(CASE WHEN event_action IN ('enlarge-link-click', 'enlarge') THEN 1 ELSE 0 END) AS 'enlarge',
	SUM(CASE WHEN event_action IN ('fullscreen-link-click', 'fullscreen') THEN 1 ELSE 0 END) AS 'fullscreen',
	SUM(CASE WHEN event_action IN ('defullscreen-link-click', 'defullscreen') THEN 1 ELSE 0 END) AS 'defullscreen',
	SUM(CASE WHEN event_action IN ('close-link-click', 'close') THEN 1 ELSE 0 END) AS 'close',
	SUM(CASE WHEN event_action IN ('site-link-click', 'file-description-page') THEN 1 ELSE 0 END) AS 'file-description-page',
	SUM(CASE WHEN event_action IN ('use-this-file-link-click', 'use-this-file-open') THEN 1 ELSE 0 END) AS 'use-this-file-open',
	SUM(CASE WHEN event_action = 'image-view' THEN 1 ELSE 0 END) AS 'image-view',
	SUM(CASE WHEN event_action = 'metadata-open' THEN 1 ELSE 0 END) AS 'metadata-open',
	SUM(CASE WHEN event_action = 'metadata-close' THEN 1 ELSE 0 END) AS 'metadata-close',
	SUM(CASE WHEN event_action = 'next-image' THEN 1 ELSE 0 END) AS 'next-image',
	SUM(CASE WHEN event_action = 'prev-image' THEN 1 ELSE 0 END) AS 'prev-image',
	SUM(CASE WHEN event_action = 'terms-open' THEN 1 ELSE 0 END) AS 'terms-open',
	SUM(CASE WHEN event_action = 'license-page' THEN 1 ELSE 0 END) AS 'license-page',
	SUM(CASE WHEN event_action = 'author-page' THEN 1 ELSE 0 END) AS 'author-page',
	SUM(CASE WHEN event_action = 'source-page' THEN 1 ELSE 0 END) AS 'source-page',
	SUM(CASE WHEN event_action = 'hash-load' THEN 1 ELSE 0 END) AS 'hash-load',
	SUM(CASE WHEN event_action = 'history-navigation' THEN 1 ELSE 0 END) AS 'history-navigation'

	FROM (
		SELECT timestamp, event_action FROM MediaViewer_7670440
			WHERE wiki = 'cawiki' AND timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 30 DAY))
		UNION ALL
		SELECT timestamp, event_action FROM MediaViewer_8245578
			WHERE wiki = 'cawiki' AND timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 30 DAY))
	) AS MediaViewerUnioned

	GROUP BY datestring
	ORDER BY datestring ASC;
