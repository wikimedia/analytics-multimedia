drop table if exists MediaViewer_6636420;
drop table if exists MediaViewerPerf_6636500;

create table if not exists MediaViewer_6066908 (
	id int(11) not null unique primary key auto_increment,
	uuid varchar(191),
	clientIp varchar(191),
	clientValidated tinyint(1),
	isTruncated tinyint(1),
	timestamp varchar(14),
	webHost varchar(191),
	wiki varchar(191),
	event_action varchar(191),
	event_version varchar(191)
);

create table if not exists MediaViewer_6055641 (
	id int(11) not null unique primary key auto_increment,
	uuid varchar(191),
	clientIp varchar(191),
	clientValidated tinyint(1),
	isTruncated tinyint(1),
	timestamp varchar(14),
	webHost varchar(191),
	wiki varchar(191),
	event_action varchar(191),
	event_version varchar(191)
);

create table if not exists MediaViewer_6054199 (
	id int(11) not null unique primary key auto_increment,
	uuid varchar(191),
	clientIp varchar(191),
	clientValidated tinyint(1),
	isTruncated tinyint(1),
	timestamp varchar(14),
	webHost varchar(191),
	wiki varchar(191),
	event_action varchar(191),
	event_version varchar(191)
);

create table MediaViewer_6636420 (
	id int(11) not null unique primary key auto_increment,
	uuid varchar(191),
	clientIp varchar(191),
	clientValidated tinyint(1),
	isTruncated tinyint(1),
	timestamp varchar(14),
	webHost varchar(191),
	wiki varchar(191),
	event_action varchar(191),
	event_version varchar(191)
);

insert into MediaViewer_6636420 (timestamp, wiki, event_action, event_version) values
	('20131225175619', 'en', 'thumbnail-click', '1.1'),
	('20131225175659', 'en', 'close-link-click', '1.1');

create table MediaViewerPerf_6636500 (
	id int(11) not null unique primary key auto_increment,
	uuid varchar(191),
	clientIp varchar(191),
	clientValidated tinyint(1),
	isTruncated tinyint(1),
	timestamp varchar(14),
	webHost varchar(191),
	wiki varchar(191),
	event_action varchar(191),
	event_fileSize varchar(191),
	event_fileType varchar(191),
	event_imageHeight varchar(191),
	event_imageWidth varchar(191),
	event_milliseconds varchar(191),
	event_userAgent varchar(191),
	event_version varchar(191)
);

insert into MediaViewerPerf_6636500 (timestamp, wiki, event_action, event_milliseconds, event_userAgent, event_version) values
	('20131225163201', 'en', 'metadata-fetch', '768', 'Firefox', '1.1'),
	('20131225163240', 'en', 'gender-fetch', '564', 'Firefox', '1.1'),
	('20131225181917', 'en', 'metadata-fetch', '465', 'Safari', '1.1'),
	('20131225181917', 'en', 'gender-fetch', '305', 'Safari', '1.1');

insert into MediaViewerPerf_6636500 (timestamp, wiki, event_action, event_fileSize, event_fileType, event_imageHeight, event_imageWidth, event_milliseconds, event_userAgent, event_version) values
	('20131225163243', 'en', 'image-load', '12092', 'jpg', '123', '456', '4126', 'Firefox', '1.1'),
	('20131225163245', 'en', 'image-resize', '12092', 'jpg', '123', '456', '26', 'Firefox', '1.1'),
	('20131225164428', 'en', 'image-resize', '12092', 'jpg', '123', '456', '12', 'Firefox', '1.1'),
	('20131225164737', 'en', 'image-resize', '12092', 'jpg', '123', '456', '16', 'Firefox', '1.1'),
	('20131225164812', 'en', 'image-resize', '12092', 'jpg', '123', '456', '6', 'Firefox', '1.1'),
	('20131225164928', 'en', 'image-resize', '12092', 'jpg', '123', '456', '17', 'Firefox', '1.1'),
	('20131225181917', 'en', 'image-load', '29031', 'jpg', '321', '564', '1239', 'Safari', '1.1');
