<?php

$wikis = array( 'global', 'huwiki', 'frwiki', 'enwiki', 'mediawikiwiki', 'commonswiki' );

function generate( $wiki ) {
	$replacement = '';

	if ( $wiki != 'global' ) {
		$replacement = 'wiki = \'' . $wiki . '\' AND';
	}

	$sql = file_get_contents( 'template.sql' );
	$sql = str_replace( '%replaceme%', $replacement, $sql );
	file_put_contents( $wiki . '.sql', $sql );
}

foreach ( $wikis as $wiki ) {
	generate( $wiki );
}

?>