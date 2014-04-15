<?php

$wikis = array( 'global', 'huwiki', 'frwiki', 'enwiki', 'mediawikiwiki', 'commonswiki' );

function generate( $folder, $wiki ) {
	$replacement = '';

	if ( $wiki != 'global' ) {
		$replacement = 'wiki = \'' . $wiki . '\' AND';
	}

	$sql = file_get_contents( $folder . '/template.sql' );
	$sql = str_replace( '%wiki%', $replacement, $sql );
	file_put_contents( $folder . '/' . $wiki . '.sql', $sql );
}

foreach ( $wikis as $wiki ) {
	generate( 'perf', $wiki );
	generate( 'actions', $wiki );
}

?>