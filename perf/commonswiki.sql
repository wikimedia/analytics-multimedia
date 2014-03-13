select concat(substring(timestamp, 1, 4), '-', substring(timestamp, 5, 2), '-', substring(timestamp, 7, 2)) as datestring,
		sum(case when event_type = 'filerepoinfo' then event_total else 0 end) as 'filerepoinfo-totaltime',
		avg(case when event_type = 'filerepoinfo' then event_total else 0 end) as 'filerepoinfo-meantime',
		std(case when event_type = 'filerepoinfo' then event_total else 0 end) as 'filerepoinfo-time-std',

		sum(case when event_type = 'globalusage' then event_total else 0 end) as 'globalusage-totaltime',
		avg(case when event_type = 'globalusage' then event_total else 0 end) as 'globalusage-meantime',
		std(case when event_type = 'globalusage' then event_total else 0 end) as 'globalusage-time-std',

		sum(case when event_type = 'image' then event_total else 0 end) as 'image-totaltime',
		avg(case when event_type = 'image' then event_total else 0 end) as 'image-meantime',
		std(case when event_type = 'image' then event_total else 0 end) as 'image-time-std',

		sum(case when event_type = 'imageinfo' then event_total else 0 end) as 'imageinfo-totaltime',
		avg(case when event_type = 'imageinfo' then event_total else 0 end) as 'imageinfo-meantime',
		std(case when event_type = 'imageinfo' then event_total else 0 end) as 'imageinfo-time-std',

		sum(case when event_type = 'imageusage' then event_total else 0 end) as 'imageusage-totaltime',
		avg(case when event_type = 'imageusage' then event_total else 0 end) as 'imageusage-meantime',
		std(case when event_type = 'imageusage' then event_total else 0 end) as 'imageusage-time-std',

		sum(case when event_type = 'thumbnailinfo' then event_total else 0 end) as 'thumbnailinfo-totaltime',
		avg(case when event_type = 'thumbnailinfo' then event_total else 0 end) as 'thumbnailinfo-meantime',
		std(case when event_type = 'thumbnailinfo' then event_total else 0 end) as 'thumbnailinfo-time-std',

		sum(case when event_type = 'userinfo' then event_total else 0 end) as 'userinfo-totaltime',
		avg(case when event_type = 'userinfo' then event_total else 0 end) as 'userinfo-meantime',
		std(case when event_type = 'userinfo' then event_total else 0 end) as 'userinfo-time-std'

	from (
		select event_type, event_total, timestamp, wiki from MultimediaViewerNetworkPerformance_7393226
			union all
		select event_type, event_total, timestamp, wiki from MultimediaViewerNetworkPerformance_7488625
	) as MultimediaViewerNetworkPerformanceUnioned

	where wiki = 'commonswiki'

	group by datestring
	order by datestring asc;
