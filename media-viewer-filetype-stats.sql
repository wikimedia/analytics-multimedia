select event_fileType as fileType,
		count(*) as number_requested
	from MediaViewerPerf_6636500
	group by event_fileType;
