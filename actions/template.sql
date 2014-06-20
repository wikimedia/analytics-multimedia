-- Get statistics, per day, for various actions in Media Viewer.

SELECT CONCAT(SUBSTRING(timestamp, 1, 4), '-', SUBSTRING(timestamp, 5, 2), '-', SUBSTRING(timestamp, 7, 2)) AS datestring,
	SUM(CASE WHEN event_action IN ('thumbnail-link-click', 'thumbnail') THEN event_samplingFactor ELSE 0 END) AS 'thumbnail',
	SUM(CASE WHEN event_action IN ('enlarge-link-click', 'enlarge') THEN event_samplingFactor ELSE 0 END) AS 'enlarge',
	SUM(CASE WHEN event_action IN ('fullscreen-link-click', 'fullscreen') THEN event_samplingFactor ELSE 0 END) AS 'fullscreen',
	SUM(CASE WHEN event_action IN ('defullscreen-link-click', 'defullscreen') THEN event_samplingFactor ELSE 0 END) AS 'defullscreen',
	SUM(CASE WHEN event_action IN ('close-link-click', 'close') THEN event_samplingFactor ELSE 0 END) AS 'close',
	SUM(CASE WHEN event_action = 'view-original-file' THEN event_samplingFactor ELSE 0 END) AS 'view-original-file',
	SUM(CASE WHEN event_action IN ('site-link-click', 'file-description-page') THEN event_samplingFactor ELSE 0 END) AS 'file-description-page',
	SUM(CASE WHEN event_action = 'file-description-page-abovefold' THEN event_samplingFactor ELSE 0 END) AS 'file-description-page-abovefold',
	SUM(CASE WHEN event_action IN ('use-this-file-link-click', 'use-this-file-open') THEN event_samplingFactor ELSE 0 END) AS 'use-this-file-open',
	SUM(CASE WHEN event_action = 'image-view' THEN event_samplingFactor ELSE 0 END) AS 'image-view',
	SUM(CASE WHEN event_action = 'metadata-open' THEN event_samplingFactor ELSE 0 END) AS 'metadata-open',
	SUM(CASE WHEN event_action = 'metadata-close' THEN event_samplingFactor ELSE 0 END) AS 'metadata-close',
	SUM(CASE WHEN event_action = 'next-image' THEN event_samplingFactor ELSE 0 END) AS 'next-image',
	SUM(CASE WHEN event_action = 'prev-image' THEN event_samplingFactor ELSE 0 END) AS 'prev-image',
	SUM(CASE WHEN event_action = 'terms-open' THEN event_samplingFactor ELSE 0 END) AS 'terms-open',
	SUM(CASE WHEN event_action = 'license-page' THEN event_samplingFactor ELSE 0 END) AS 'license-page',
	SUM(CASE WHEN event_action = 'author-page' THEN event_samplingFactor ELSE 0 END) AS 'author-page',
	SUM(CASE WHEN event_action = 'source-page' THEN event_samplingFactor ELSE 0 END) AS 'source-page',
	SUM(CASE WHEN event_action = 'hash-load' THEN event_samplingFactor ELSE 0 END) AS 'hash-load',
	SUM(CASE WHEN event_action = 'history-navigation' THEN event_samplingFactor ELSE 0 END) AS 'history-navigation',
	SUM(CASE WHEN event_action = 'optout-loggedin' THEN event_samplingFactor ELSE 0 END) AS 'optout-loggedin',
	SUM(CASE WHEN event_action = 'optout-anon' THEN event_samplingFactor ELSE 0 END) AS 'optout-anon',
	SUM(CASE WHEN event_action = 'optin-loggedin' THEN event_samplingFactor ELSE 0 END) AS 'optin-loggedin',
	SUM(CASE WHEN event_action = 'optin-anon' THEN event_samplingFactor ELSE 0 END) AS 'optin-anon',
	SUM(CASE WHEN event_action IN ('optout-loggedin', 'optout-anon') THEN event_samplingFactor ELSE 0 END) AS 'optout-total',
	SUM(CASE WHEN event_action IN ('optin-loggedin', 'optin-anon') THEN event_samplingFactor ELSE 0 END) AS 'optin-total'

	FROM (
		SELECT timestamp, event_action, 1 AS event_samplingFactor FROM MediaViewer_7670440
			WHERE %wiki% timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 30 DAY))
		UNION ALL
		SELECT timestamp, event_action, 1 AS event_samplingFactor FROM MediaViewer_8245578
			WHERE %wiki% timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 30 DAY))
		UNION ALL
		SELECT timestamp, event_action, event_samplingFactor FROM MediaViewer_8572637
			WHERE %wiki% timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 30 DAY))
		UNION ALL
		SELECT timestamp, event_action, event_samplingFactor FROM MediaViewer_8935662
			WHERE %wiki% timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 30 DAY))
	) AS MediaViewerUnioned

	GROUP BY datestring
	ORDER BY datestring ASC;
