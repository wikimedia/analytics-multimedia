/*
 * This file is part of the multimedia-stats-scripts project.
 *
 * multimedia-stats-scripts is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * multimedia-stats-scripts is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with multimedia-stats-scripts.  If not, see <http://www.gnu.org/licenses/>.
 */


var
	/* config to be populated later */
	config,

	/* requires */
	util = require( 'util' ),
	fs = require( 'fs' ),
	defaultConfig = require( './config.default.json' ),

	/* global objects storing stats */
	perWikiStats = {},
	uniqueUsers = {},

	/* global whitelist for event types */
	eventSchemata = {
		MediaViewer: true,
		MediaViewerPerf: true
	},

	mvActions = [
		'thumbnail-link-click',
		'enlarge-link-click',
		'fullscreen-link-click',
		'defullscreen-link-click',
		'site-link-click',
		'close-link-click'
	],

	mvpActions = [
		'image-load',
		'image-resize',
		'metadata-fetch',
		'gender-fetch'
	],

	mvpTypes = [
		'median',
		'mean',
		'total'
	];

// I'm angry that I have to implement this so you don't GET any documentation
function sum( arr ) {
	var i,
		total = 0,
		len = arr.length;

	for ( i = 0; i < len; i++ ) {
		total += arr[i];
	}

	return total;
}

function mean( arr ) {
	return sum( arr ) / arr.length;
}

function median( arr ) {
	var newArr = Array.prototype.slice.call( arr );
	newArr.sort();
	if ( newArr.length % 2 ) {
		return newArr[( newArr.length - 1 ) / 2];
	} else {
		return ( (
			newArr[newArr.length / 2] +
			newArr[( newArr.length / 2 ) - 1]
		) / 2 );
	}
}

/**
 * Takes a CSV and generates an object out of it.
 * @param {string} data
 * @returns {Object}
 */
function csvToObject( data ) {
	var i, line,
		newObj = {},
		lines = data.split( '\n' );

	for ( i = 0; i < lines.length; i++ ) {
		line = lines[i].split( ',' );
		if ( line.length === 2 ) {
			newObj[line[0]] = parseInt( line[1], 10 );
		}
	}

	return newObj;
}

/**
 * Takes a filename and imports it as a CSV with two columns, key -> value.
 * @param {string} filename
 * @param {Function} cb
 * @param {Error/null} cb.err
 * @param {Object} cb.data
 */
function importOrdinalCsvFile( filename, cb ) {
	fs.readFile( filename, 'utf8', function ( err, data ) {
		if ( err !== null ) {
			cb( err, {} );
		}

		if ( data ) {
			cb( null, csvToObject( data ) );
		} else {
			cb( null, {} );
		}
	} );
}

/**
 * Takes a string with EventLogging data, calls back with an array
 * of events.
 * @param {string|Buffer} data
 * @param {Function} cb
 * @param {Error/null} cb.err
 * @param {Object[]} cb.events
 */
function loadStr( data, cb ) {
	var events = [],
		lines = data.split( '\n' );

	for ( i = 0; i < lines.length; i++ ) {
		try {
			event = JSON.parse( lines[i] );
		} catch ( err ) {}

		events.push( event );
	}

	cb( null, events );
}

/**
 * Loads a file with EventLogging data, calls back with an array of
 * events.
 * @param {string} fname Path to the file
 * @param {Function} cb
 * @param {Error/null} cb.err
 * @param {Object[]} cb.events
 */
function loadFile( fname, cb ) {
	fs.readFile( fname, 'utf8', function ( err, data ) {
		if ( err !== null ) {
			cb( err, [] );
		}

		loadStr( data, cb );
	} );
}

/**
 * Loads data from stdin and calls back with an array of events.
 * @param {Function} cb
 * @param {Error/null} cb.err
 * @param {Object[]} cb.events
 */
function loadStdin( cb ) {
	var data = '';

	process.stdin.on( 'data', function ( buf ) {
		data += buf.toString();
	} );

	process.stdin.on( 'error', function ( err ) {
		cb( err, [] );
		process.stdin.pause();
	} );

	process.stdin.on( 'end', function () {
		loadStr( data, cb );
	} );

	process.stdin.resume();
}

/**
 * Splits an array of event objects into different arrays based on a
 * whitelist of schemata.
 * @param {Object[]} events See loadFile#cb.events
 * @param {Object} [whitelist] Of form { SchemaName: true, OtherSchemaName: true }
 * @returns {Object} Of form { SchemaName: [ event1, event2 ], OtherSchemaName: [ event3, event4 ] }
 */
function splitSchemata( events, whitelist ) {
	var i, event,
		schemata = {};

	for ( i = 0; i < events.length; i++ ) {
		event = events[i];

		if ( !whitelist || whitelist[event.schema] ) {
			if ( schemata[event.schema] === undefined ) {
				schemata[event.schema] = [];
			}

			schemata[event.schema].push( event );
		}
	}

	return schemata;
}

/**
 * @class
 * @abstract
 * @constructor
 * @param {Object[]} events See splitSchemata
 */
function EventTraverser( events ) {
	/** @property {Object[]} events */
	this.events = events;
	/** @property {Object} data */
	this.data = {
		totalEvents: events.length
	};
}

/**
 * @method
 * Traverses the events list and calls a handler for each one.
 */
EventTraverser.prototype.traverse = function () {
	var i, event;

	for ( i = 0; i < this.events.length; i++ ) {
		event = this.events[i];

		this.handleEvent( i, event );
	}

	this.handleFinish();
};

/**
 * @method
 * Handles one event
 * @param {number} i
 * @param {Object} event
 */
EventTraverser.prototype.handleEvent = function () {};

/**
 * @method
 * Handles the very end of the traversal
 */
EventTraverser.prototype.handleFinish = function () {};

/**
 * @class
 * @extends EventTraverser
 * Subclass to handle MediaViewer schema.
 * @constructor
 * @param {Object[]} events
 */
function MediaViewerEventTraverser( events ) {
	EventTraverser.call( this, events );
	this.data.actionCounts = {};
}

util.inherits( MediaViewerEventTraverser, EventTraverser );

/**
 * @method
 * Handles MediaViewer events.
 * @param {number} i
 * @param {Object} event
 */
MediaViewerEventTraverser.prototype.handleEvent = function ( i, event ) {
	// Add to the count of this action
	if ( this.data.actionCounts[event.event.action] === undefined ) {
		this.data.actionCounts[event.event.action] = 0;
	}

	this.data.actionCounts[event.event.action]++;
};

/**
 * @class
 * @extends EventTraverser
 * Subclass to handle MediaViewerPerf schema.

/**
 * Traverses the array of MediaViewerPerf events.
 */
function MediaViewerPerfEventTraverser( events ) {
	EventTraverser.call( this, events );
	this.data.loadTimes = {};
	this.data.loadTimesByFileType = {};
	this.data.loadTimesNormalized = {};
	this.data.loadTimesNormalizedByFileType = {};
	this.data.imageSizes = {};
	this.data.imageTypes = {};
}

util.inherits( MediaViewerPerfEventTraverser, EventTraverser );

/**
 * @method
 * Handles MediaViewerPerf events
 * @param {number} i
 * @param {Object} event
 */
MediaViewerPerfEventTraverser.prototype.handleEvent = function ( i, event ) {
	if ( this.data.loadTimes[event.event.action] === undefined ) {
		this.data.loadTimes[event.event.action] = [];
	}

	this.data.loadTimes[event.event.action].push( event.event.milliseconds );

	if ( event.event.fileType && event.event.fileSize ) {
		if ( this.data.loadTimesByFileType[event.event.action] === undefined ) {
			this.data.loadTimesByFileType[event.event.action] = {};
		}

		if ( this.data.loadTimesByFileType[event.event.action][event.event.fileType] === undefined ) {
			this.data.loadTimesByFileType[event.event.action][event.event.fileType] = [];
		}

		this.data.loadTimesByFileType[event.event.action][event.event.fileType].push( event.event.milliseconds );

		if ( this.data.loadTimesNormalized[event.event.action] === undefined ) {
			this.data.loadTimesNormalized[event.event.action] = [];
		}

		this.data.loadTimesNormalized[event.event.action].push( event.event.milliseconds / event.event.fileSize );

		if ( this.data.loadTimesNormalizedByFileType[event.event.action] === undefined ) {
			this.data.loadTimesNormalizedByFileType[event.event.action] = {};
		}

		if ( this.data.loadTimesNormalizedByFileType[event.event.action][event.event.fileType] === undefined ) {
			this.data.loadTimesNormalizedByFileType[event.event.action][event.event.fileType] = [];
		}

		this.data.loadTimesNormalizedByFileType[event.event.action][event.event.fileType].push( event.event.milliseconds / event.event.fileSize );

		if ( this.data.imageSizes[event.event.fileSize] === undefined ) {
			this.data.imageSizes[event.event.fileSize] = 0;
		}

		this.data.imageSizes[event.event.fileSize]++;

		if ( this.data.imageTypes[event.event.fileType] === undefined ) {
			this.data.imageTypes[event.event.fileType] = 0;
		}

		this.data.imageTypes[event.event.fileType]++;
	}
};

/**
 * @method
 * Crunches some data at the end of the traversal
 * @TODO This could probably be written way better, but for now, it will just be crap.
 */
MediaViewerPerfEventTraverser.prototype.handleFinish = function () {
	var i, j, actions, filetypes, action, filetype, times;

	actions = Object.keys( this.data.loadTimes );
	this.data.medianLoadTimesByAction = {};
	this.data.meanLoadTimesByAction = {};
	this.data.totalLoadTimesByAction = {};
	for ( i = 0; i < actions.length; i++ ) {
		action = actions[i];
		times = this.data.loadTimes[action];
		this.data.medianLoadTimesByAction[action] = median( times );
		this.data.meanLoadTimesByAction[action] = mean( times );
		this.data.totalLoadTimesByAction[action] = sum( times );
	}

	actions = Object.keys( this.data.loadTimesNormalized );
	this.data.medianLoadTimesNormalizedByAction = {};
	this.data.meanLoadTimesNormalizedByAction = {};
	this.data.totalLoadTimesNormalizedByAction = {};
	for ( i = 0; i < actions.length; i++ ) {
		action = actions[i];
		times = this.data.loadTimesNormalized[action];
		this.data.medianLoadTimesNormalizedByAction[action] = median( times );
		this.data.meanLoadTimesNormalizedByAction[action] = mean( times );
		this.data.totalLoadTimesNormalizedByAction[action] = sum( times );
	}

	actions = Object.keys( this.data.loadTimesByFileType );
	this.data.medianLoadTimesByFileType = {};
	this.data.meanLoadTimesByFileType = {};
	this.data.totalLoadTimesByFileType = {};
	for ( i = 0; i < actions.length; i++ ) {
		action = actions[i];
		times = this.data.loadTimesByFileType[action];
		filetypes = Object.keys( times );

		for ( j = 0; j < filetypes.length; j++ ) {
			filetype = filetypes[i];
			times = this.data.loadTimesByFileType[action][filetype];

			if ( this.data.medianLoadTimesByFileType[action] === undefined ) {
				this.data.medianLoadTimesByFileType[action] = {};
			}

			if ( this.data.meanLoadTimesByFileType[action] === undefined ) {
				this.data.meanLoadTimesByFileType[action] = {};
			}

			if ( this.data.totalLoadTimesByFileType[action] === undefined ) {
				this.data.totalLoadTimesByFileType[action] = {};
			}

			this.data.medianLoadTimesByFileType[action][filetype] = median( times );
			this.data.meanLoadTimesByFileType[action][filetype] = mean( times );
			this.data.totalLoadTimesByFileType[action][filetype] = sum( times );
		}
	}

	actions = Object.keys( this.data.loadTimesNormalizedByFileType );
	this.data.medianLoadTimesNormalizedByFileType = {};
	this.data.meanLoadTimesNormalizedByFileType = {};
	this.data.totalLoadTimesNormalizedByFileType = {};
	for ( i = 0; i < actions.length; i++ ) {
		action = actions[i];
		times = this.data.loadTimesNormalizedByFileType[action];
		filetypes = Object.keys( times );

		for ( j = 0; j < filetypes.length; j++ ) {
			filetype = filetypes[i];
			times = this.data.loadTimesNormalizedByFileType[action][filetype];

			if ( this.data.medianLoadTimesNormalizedByFileType[action] === undefined ) {
				this.data.medianLoadTimesNormalizedByFileType[action] = {};
			}

			if ( this.data.meanLoadTimesNormalizedByFileType[action] === undefined ) {
				this.data.meanLoadTimesNormalizedByFileType[action] = {};
			}

			if ( this.data.totalLoadTimesNormalizedByFileType[action] === undefined ) {
				this.data.totalLoadTimesNormalizedByFileType[action] = {};
			}

			this.data.medianLoadTimesNormalizedByFileType[action][filetype] = median( times );
			this.data.meanLoadTimesNormalizedByFileType[action][filetype] = mean( times );
			this.data.totalLoadTimesNormalizedByFileType[action][filetype] = sum( times );
		}
	}
};

try {
	config = require( './config.json' );
} catch ( e ) {
	console.log( 'No config found, using defaults...ignore this in testing, fix by creating config.json otherwise.' );
	config = require( './config.default.json' );
}

// Actually do stuff with the data
// Right now it's just a stupid-simple test case.
loadStdin( function ( err, events ) {
	var mvEvtTrav, mvpEvtTrav, mvdata, mvpdata,
		mvfile, mvpfile, mvcsv, mvpcsv,
		imgtypefile, imgsizefile,
		i, j, action, type, targetdata,
		date = process.argv[2];

	if ( err !== null ) {
		console.log( err );
		return;
	}

	events = splitSchemata( events );

	mvEvtTrav = new MediaViewerEventTraverser( events.MediaViewer || [] );
	mvpEvtTrav = new MediaViewerPerfEventTraverser( events.MediaViewerPerf || [] );

	mvEvtTrav.traverse();
	mvpEvtTrav.traverse();

	mvdata = mvEvtTrav.data;
	mvpdata = mvpEvtTrav.data;

	imgtypefile = config.files.imgtypes;
	imgsizefile = config.files.imgsizes;

	if ( imgsizefile ) {
		importOrdinalCsvFile( imgsizefile, function ( err, data ) {
			var i, datakeys,
				imageSizes = Object.keys( mvpdata.imageSizes ),
				imgsizecsv = '';

			for ( i = 0; i < imageSizes.length; i++ ) {
				if ( data[imageSizes[i]] !== undefined ) {
					data[imageSizes[i]] += mvpdata.imageSizes[imageSizes[i]];
				} else {
					data[imageSizes[i]] = mvpdata.imageSizes[imageSizes[i]];
				}
			}

			datakeys = Object.keys( data );

			for ( i = 0; i < datakeys.length; i++ ) {
				imgsizecsv += datakeys[i] + ',' + data[datakeys[i]] + '\n';
			}

			fs.writeFile( imgsizefile, imgsizecsv );
		} );
	}

	if ( imgtypefile ) {
		importOrdinalCsvFile( imgtypefile, function ( err, data ) {
			var i,
				existingImageTypes = Object.keys( data ),
				imageTypes = Object.keys( mvpdata.imageTypes ),
				imgtypecsv = '';

			for ( i = 0; i < imageTypes.length; i++ ) {
				if ( data[imageTypes[i]] !== undefined ) {
					data[imageTypes[i]] += mvpdata.imageTypes[imageTypes[i]];
				} else {
					data[imageTypes[i]] = mvpdata.imageTypes[imageTypes[i]];
				}
			}

			datakeys = Object.keys( data );

			for ( i = 0; i < datakeys.length; i++ ) {
				imgtypecsv += datakeys[i] + ',' + data[datakeys[i]] + '\n';
			}

			fs.writeFile( imgtypefile, imgtypecsv );
		} );
	}

	mvfile = config.files.mvdata;
	mvpfile = config.files.mvpdata;

	if ( mvfile ) {
		mvcsv = date;

		for ( i = 0; i < mvActions.length; i++ ) {
			action = mvActions[i];

			if ( !mvdata.actionCounts[action] ) {
				mvdata.actionCounts[action] = 0;
			}

			mvcsv += ',' + mvdata.actionCounts[action];
		}

		fs.appendFile( mvfile, mvcsv + '\n' );
	}

	if ( mvpfile ) {
		mvpcsv = date;

		for ( i = 0; i < mvpActions.length; i++ ) {
			action = mvpActions[i];

			for ( j = 0; j < mvpTypes.length; j++ ) {
				type = mvpTypes[j];
				targetdata = mvpdata[type + 'LoadTimesByAction'];

				if ( !targetdata[action] ) {
					targetdata[action] = 0;
				}

				mvpcsv += ',' + targetdata[action];
			}
		}

		fs.appendFile( mvpfile, mvpcsv + '\n' );
	}
} );
