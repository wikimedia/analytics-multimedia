#!/usr/bin/env python

import os
import sys

wikis = [
    'global',
    'cawiki',
    'commonswiki',
    'czwiki',
    'dewiki',
    'enwiki',
    'enwikivoyage',
    'eswiki',
    'etwiki',
    'fiwiki',
    'frwiki',
    'hewiki',
    'huwiki',
    'itwiki',
    'jawiki',
    'kowiki',
    'mediawikiwiki',
    'nlwiki',
    'plwiki',
    'ptwiki',
    'rowiki',
    'ruwiki',
    'skwiki',
    'svwiki',
    'tewiki',
    'thwiki',
    'viwiki',
]

default_fields = 'event_type, event_total, timestamp, wiki'

perf_metrics = [
    {'name': 'userinfo', 'where': 'event_type = \'userinfo\'', 'fields': default_fields},
    {'name': 'imageinfo', 'where': 'event_type = \'imageinfo\'', 'fields': default_fields},
    {'name': 'thumbnailinfo', 'where': 'event_type = \'thumbnailinfo\'', 'fields': default_fields},
    {'name': 'filerepoinfo', 'where': 'event_type = \'filerepoinfo\'', 'fields': default_fields},
    {'name': 'imageusage', 'where': 'event_type = \'imageusage\'', 'fields': default_fields},
    {'name': 'globalusage', 'where': 'event_type = \'globalusage\'', 'fields': default_fields},
    {'name': 'image', 'where': 'event_type = \'image\'', 'fields': default_fields},
    {'name': 'imagemiss', 'where': 'event_type = \'image\' AND LENGTH(event_XCache) > 0 AND event_varnish1hits = 0 AND event_varnish2hits = 0 AND event_varnish2hits = 0', 'fields': 'event_type, event_total, timestamp, wiki, event_XCache, event_varnish1hits, event_varnish2hits, event_varnish3hits'},
    {'name': 'imagehit', 'where': 'event_type = \'image\' AND LENGTH(event_XCache) > 0 AND (event_varnish1hits > 0 OR event_varnish2hits > 0 OR event_varnish2hits > 0)', 'fields': 'event_type, event_total, timestamp, wiki, event_XCache, event_varnish1hits, event_varnish2hits, event_varnish3hits'},
]

geo_perf_metrics = [
    {'name': 'api', 'where': 'event_type != \'image\'', 'fields': ''},
    {'name': 'image', 'where': 'event_type = \'image\'', 'fields': ''},
]


def generate(folder, wiki, metric=None):
    replacement = ''

    if wiki != 'global':
        replacement = 'wiki = \'' + wiki + '\' AND'

    sql = open(
        os.path.dirname(os.path.realpath(__file__)) +
        '/' + folder + '/template.sql').read(10000)
    sql = sql.replace('%wiki%', replacement)

    if metric is not None:
        sql = sql.replace('%metricname%', metric['name'])
        sql = sql.replace('%metricfields%', metric['fields'])
        sql = sql.replace('%metricwhere%', metric['where'])

    f = open(
        sys.argv[1] + '/' + folder + '/' +
        wiki + ('' if metric is None else '-' + metric['name']) + '.sql', 'w')
    f.write(sql)
    f.close()

if len(sys.argv) != 2:
    print 'Must specific a folder to send generated SQL to'
    sys.exit(2)

for wiki in wikis:
    for perf_metric in perf_metrics:
        generate('perf', wiki, perf_metric)

    for geo_perf_metric in geo_perf_metrics:
        generate('geoperf', wiki, geo_perf_metric)

    generate('actions', wiki)
