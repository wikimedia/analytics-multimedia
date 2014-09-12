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
	SUM(CASE WHEN event_action = 'pref-optout-loggedin' THEN event_samplingFactor ELSE 0 END) AS 'optout-loggedin',
	SUM(CASE WHEN event_action = 'optout-anon' THEN event_samplingFactor ELSE 0 END) AS 'optout-anon',
	SUM(CASE WHEN event_action = 'pref-optin-loggedin' THEN event_samplingFactor ELSE 0 END) AS 'optin-loggedin',
	SUM(CASE WHEN event_action = 'optin-anon' THEN event_samplingFactor ELSE 0 END) AS 'optin-anon',
	SUM(CASE WHEN event_action IN ('pref-optout-loggedin', 'optout-anon') THEN event_samplingFactor ELSE 0 END) AS 'optout-total',
	SUM(CASE WHEN event_action IN ('pref-optin-loggedin', 'optin-anon') THEN event_samplingFactor ELSE 0 END) AS 'optin-total',
	SUM(CASE WHEN event_action = 'about-page' THEN event_samplingFactor ELSE 0 END) AS 'about-page',
	SUM(CASE WHEN event_action = 'discuss-page' THEN event_samplingFactor ELSE 0 END) AS 'discuss-page',
	SUM(CASE WHEN event_action = 'help-page' THEN event_samplingFactor ELSE 0 END) AS 'help-page',
	SUM(CASE WHEN event_action = 'location-page' THEN event_samplingFactor ELSE 0 END) AS 'location-page',
	SUM(CASE WHEN event_action = 'uploader-page' THEN event_samplingFactor ELSE 0 END) AS 'uploader-page',
	SUM(CASE WHEN event_action = 'download-select-menu-original' THEN event_samplingFactor ELSE 0 END) AS 'download-select-menu-original',
	SUM(CASE WHEN event_action = 'download-select-menu-small' THEN event_samplingFactor ELSE 0 END) AS 'download-select-menu-small',
	SUM(CASE WHEN event_action = 'download-select-menu-medium' THEN event_samplingFactor ELSE 0 END) AS 'download-select-menu-medium',
	SUM(CASE WHEN event_action = 'download-select-menu-large' THEN event_samplingFactor ELSE 0 END) AS 'download-select-menu-large',
	SUM(CASE WHEN event_action = 'download' THEN event_samplingFactor ELSE 0 END) AS 'download',
	SUM(CASE WHEN event_action = 'download-view-in-browser' THEN event_samplingFactor ELSE 0 END) AS 'download-view-in-browser',
	SUM(CASE WHEN event_action = 'share-page' THEN event_samplingFactor ELSE 0 END) AS 'share-page',
	SUM(CASE WHEN event_action = 'share-link-copied' THEN event_samplingFactor ELSE 0 END) AS 'share-link-copied',
	SUM(CASE WHEN event_action = 'embed-html-copied' THEN event_samplingFactor ELSE 0 END) AS 'embed-html-copied',
	SUM(CASE WHEN event_action = 'embed-wikitext-copied' THEN event_samplingFactor ELSE 0 END) AS 'embed-wikitext-copied',
	SUM(CASE WHEN event_action = 'embed-switched-to-html' THEN event_samplingFactor ELSE 0 END) AS 'embed-switched-to-html',
	SUM(CASE WHEN event_action = 'embed-switched-to-wikitext' THEN event_samplingFactor ELSE 0 END) AS 'embed-switched-to-wikitext',
	SUM(CASE WHEN event_action = 'embed-select-menu-wikitext-default' THEN event_samplingFactor ELSE 0 END) AS 'embed-select-menu-wikitext-default',
	SUM(CASE WHEN event_action = 'embed-select-menu-wikitext-small' THEN event_samplingFactor ELSE 0 END) AS 'embed-select-menu-wikitext-small',
	SUM(CASE WHEN event_action = 'embed-select-menu-wikitext-medium' THEN event_samplingFactor ELSE 0 END) AS 'embed-select-menu-wikitext-medium',
	SUM(CASE WHEN event_action = 'embed-select-menu-wikitext-large' THEN event_samplingFactor ELSE 0 END) AS 'embed-select-menu-wikitext-large',
	SUM(CASE WHEN event_action = 'embed-select-menu-html-original' THEN event_samplingFactor ELSE 0 END) AS 'embed-select-menu-html-original',
	SUM(CASE WHEN event_action = 'embed-select-menu-html-small' THEN event_samplingFactor ELSE 0 END) AS 'embed-select-menu-html-small',
	SUM(CASE WHEN event_action = 'embed-select-menu-html-medium' THEN event_samplingFactor ELSE 0 END) AS 'embed-select-menu-html-medium',
	SUM(CASE WHEN event_action = 'embed-select-menu-html-large' THEN event_samplingFactor ELSE 0 END) AS 'embed-select-menu-html-large',
	SUM(CASE WHEN event_action = 'use-this-file-close' THEN event_samplingFactor ELSE 0 END) AS 'use-this-file-close'

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
			UNION ALL
		SELECT timestamp, event_action, event_samplingFactor FROM MediaViewer_9792855
			WHERE %wiki% timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 30 DAY))
		UNION ALL
		SELECT timestamp, (CASE WHEN event_value = 0 THEN 'pref-optout-loggedin' ELSE 'pref-optin-loggedin' END) AS event_action, 1 AS event_samplingFactor FROM PrefUpdate_5563398
			WHERE event_property = 'multimediaviewer-enable' AND timestamp < TIMESTAMP(CURDATE()) AND timestamp >= TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 30 DAY))
	) AS MediaViewerUnioned

	GROUP BY datestring
	ORDER BY datestring ASC;
