-- Get statistics, per day, for various actions in Media Viewer.

select concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) as datestring,
	sum(case when event_action = 'thumbnail-link-click' then 1 else 0 end) as 'thumbnail-link-click',
	sum(case when event_action = 'enlarge-link-click' then 1 else 0 end) as 'enlarge-link-click',
	sum(case when event_action = 'fullscreen-link-click' then 1 else 0 end) as 'fullscreen-link-click',
	sum(case when event_action = 'defullscreen-link-click' then 1 else 0 end) as 'defullscreen-link-click',
	sum(case when event_action = 'site-link-click' then 1 else 0 end) as 'site-link-click',
	sum(case when event_action = 'close-link-click' then 1 else 0 end) as 'close-link-click',
	sum(case when event_action = 'use-this-file-link-click' then 1 else 0 end) as 'use-this-file-link-click',
	sum(case when event_action = 'image-view' then 1 else 0 end) as 'image-view'

	from (
-- Not working yet
--		select timestamp, event_action from MediaViewer_7670440
--			union all
		select timestamp, event_action from MediaViewer_6636420
			union all
		select timestamp, event_action from MediaViewer_6066908
			union all
		select timestamp, event_action from MediaViewer_6055641
			union all
		select timestamp, event_action from MediaViewer_6054199) as MediaViewerUnioned

	where wiki = 'frwiki'

	group by datestring
	order by datestring asc;
