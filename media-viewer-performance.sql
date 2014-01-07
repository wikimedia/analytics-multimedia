select substring(timestamp, 1, 8) as datestring,
		sum(case when event_action = 'image-load' then event_milliseconds else 0 end) as 'image-load-totaltime',
		avg(case when event_action = 'image-load' then event_milliseconds else 0 end) as 'image-load-meantime',
		std(case when event_action = 'image-load' then event_milliseconds else 0 end) as 'image-load-meantime',

		sum(case when event_action = 'image-resize' then event_milliseconds else 0 end) as 'image-resize-totaltime',
		avg(case when event_action = 'image-resize' then event_milliseconds else 0 end) as 'image-resize-meantime',
		std(case when event_action = 'image-resize' then event_milliseconds else 0 end) as 'image-resize-meantime',

		sum(case when event_action = 'metadata-fetch' then event_milliseconds else 0 end) as 'metadata-fetch-totaltime',
		avg(case when event_action = 'metadata-fetch' then event_milliseconds else 0 end) as 'metadata-fetch-meantime',
		std(case when event_action = 'metadata-fetch' then event_milliseconds else 0 end) as 'metadata-fetch-meantime',

		sum(case when event_action = 'gender-fetch' then event_milliseconds else 0 end) as 'gender-fetch-totaltime',
		avg(case when event_action = 'gender-fetch' then event_milliseconds else 0 end) as 'gender-fetch-meantime',
		std(case when event_action = 'gender-fetch' then event_milliseconds else 0 end) as 'gender-fetch-meantime'
	from MediaViewerPerf_6636500
	where substring(timestamp, 1, 8) > (select date_found from MediaViewerStatsUtility where datatype = 'mvp' order by date_found desc limit 1)
		and timestamp < concat(date_format(curdate(), '%Y%m%d'), '000000')
	group by datestring
	order by datestring asc;
