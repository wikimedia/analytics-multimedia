-- Get statistics, per day, for various actions in Media Viewer.

select substring(timestamp, 1, 8) as datestring,
	sum(case when event_action = 'thumbnail-link-click' then 1 else 0 end) as 'thumbnail-link-click',
	sum(case when event_action = 'enlarge-link-click' then 1 else 0 end) as 'enlarge-link-click',
	sum(case when event_action = 'fullscreen-link-click' then 1 else 0 end) as 'fullscreen-link-click',
	sum(case when event_action = 'defullscreen-link-click' then 1 else 0 end) as 'defullscreen-link-click',
	sum(case when event_action = 'site-link-click' then 1 else 0 end) as 'site-link-click',
	sum(case when event_action = 'close-link-click' then 1 else 0 end) as 'close-link-click'

	from (select * from MediaViewer_6636420
			union all
		select * from MediaViewer_6066908
			union all
		select * from MediaViewer_6055641
			union all
		select * from MediaViewer_6054199) as MediaViewerUnioned

	where substring(timestamp, 1, 8) > (select date_found from MediaViewerStatsUtility where datatype = 'mv' order by date_found desc limit 1)
		and timestamp < concat(date_format(curdate(), '%Y%m%d'), '000000')
	group by datestring
	order by datestring asc;

insert into MediaViewerStatsUtility (datatype, date_found) values
	('mv', (select substring(timestamp, 1, 8) as datestring from MediaViewer_6636420 order by datestring desc limit 1));
