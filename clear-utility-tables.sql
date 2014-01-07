drop table if exists MediaViewerStatsUtility;

create table MediaViewerStatsUtility (
	id int(11) not null unique primary key auto_increment,
	datatype varchar(100) not null,
	date_found varchar(14) not null
);

-- Use the lowest value. Of course.
insert into MediaViewerStatsUtility (datatype, date_found) values
	('mv', '00000000000000'),
	('mvp', '00000000000000');
