select log(event_fileSize) as fileSizeLogScale,
		count(*) as number_requested
	from MediaViewerPerf_6636500
	group by fileSizeLogScale;
