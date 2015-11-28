function log_play_history(sources) {
    _.each(sources, function (source) {
        _.each(source.tracks.models, function (model) {
            ts = new Date(model.attributes.time).getTime() / 1000
            console.log(ts, model.attributes.track.name, model.attributes.track.artist, model.attributes.track.album, model.attributes.track.albumArtist);
        });
    });
}

// Walk back through history using these.
var start = 0;
var count = 10;


R.Api.request({
    method: 'getHistoryForUser',
    content: {
        'user': R.currentUser.id,
        start: start,
        count: count
    }
}).done(function (r) {
    log_play_history(r.result.sources);
})
