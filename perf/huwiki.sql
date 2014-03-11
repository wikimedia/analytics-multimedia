select concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) as datestring,
		sum(case when event_action = 'image-load' then event_milliseconds else 0 end) as 'image-load-totaltime',
		avg(case when event_action = 'image-load' then event_milliseconds else 0 end) as 'image-load-meantime',
		std(case when event_action = 'image-load' then event_milliseconds else 0 end) as 'image-load-time-std',

		sum(case when event_action = 'image-resize' then event_milliseconds else 0 end) as 'image-resize-totaltime',
		avg(case when event_action = 'image-resize' then event_milliseconds else 0 end) as 'image-resize-meantime',
		std(case when event_action = 'image-resize' then event_milliseconds else 0 end) as 'image-resize-time-std',

		sum(case when event_action = 'metadata-fetch' then event_milliseconds else 0 end) as 'metadata-fetch-totaltime',
		avg(case when event_action = 'metadata-fetch' then event_milliseconds else 0 end) as 'metadata-fetch-meantime',
		std(case when event_action = 'metadata-fetch' then event_milliseconds else 0 end) as 'metadata-fetch-time-std',

		sum(case when event_action = 'gender-fetch' then event_milliseconds else 0 end) as 'gender-fetch-totaltime',
		avg(case when event_action = 'gender-fetch' then event_milliseconds else 0 end) as 'gender-fetch-meantime',
		std(case when event_action = 'gender-fetch' then event_milliseconds else 0 end) as 'gender-fetch-time-std'

	from MediaViewerPerf_6636500
	where event_version = '1.1'
		and wiki = 'huwiki'

	group by datestring
	order by datestring asc;
