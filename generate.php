<?php

$wikis = array( 'global', 'huwiki', 'frwiki', 'enwiki', 'mediawikiwiki', 'commonswiki' );

$default_fields = 'event_type, event_total, timestamp, wiki';

$perf_metrics = array(
	array( 'name' => 'userinfo', 'where' => 'event_type = \'userinfo\'', 'fields' => $default_fields ),
	array( 'name' => 'imageinfo', 'where' => 'event_type = \'imageinfo\'', 'fields' => $default_fields ),
	array( 'name' => 'thumbnailinfo', 'where' => 'event_type = \'thumbnailinfo\'', 'fields' => $default_fields ),
	array( 'name' => 'filerepoinfo', 'where' => 'event_type = \'filerepoinfo\'', 'fields' => $default_fields ),
	array( 'name' => 'imageusage', 'where' => 'event_type = \'imageusage\'', 'fields' => $default_fields ),
	array( 'name' => 'globalusage', 'where' => 'event_type = \'globalusage\'', 'fields' => $default_fields ),
	array( 'name' => 'image', 'where' => 'event_type = \'image\'', 'fields' => $default_fields ),
	array( 'name' => 'imagemiss', 'where' => 'event_type = \'image\' AND LENGTH(event_XCache) > 0 AND event_varnish1hits = 0 AND event_varnish2hits = 0 AND event_varnish2hits = 0', 'fields' => 'event_type, event_total, timestamp, wiki, event_XCache, event_varnish1hits, event_varnish2hits, event_varnish3hits' ),
	array( 'name' => 'imagehit', 'where' => 'event_type = \'image\' AND LENGTH(event_XCache) > 0 AND (event_varnish1hits > 0 OR event_varnish2hits > 0 OR event_varnish2hits > 0)', 'fields' => 'event_type, event_total, timestamp, wiki, event_XCache, event_varnish1hits, event_varnish2hits, event_varnish3hits' ),
	);

function generate( $folder, $wiki, $metric = null ) {
	$replacement = '';

	if ( $wiki != 'global' ) {
		$replacement = 'wiki = \'' . $wiki . '\' AND';
	}

	$sql = file_get_contents( $folder . '/template.sql' );
	$sql = str_replace( '%wiki%', $replacement, $sql );

	if ( !is_null( $metric ) ) {
		$sql = str_replace( '%metricname%', $metric['name'], $sql );
		$sql = str_replace( '%metricfields%', $metric['fields'], $sql );
		$sql = str_replace( '%metricwhere%', $metric['where'], $sql );
	}

	file_put_contents( $folder . '/' . $wiki . ( is_null( $metric ) ? '' : '-'  . $metric['name'] ) . '.sql', $sql );
}

foreach ( $wikis as $wiki ) {
	foreach ( $perf_metrics as $perf_metric) {
		generate( 'perf', $wiki, $perf_metric );
	}

	generate( 'actions', $wiki );
}

?>