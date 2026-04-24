// This must be in a Script asset, NOT inside an object's event
function init_campaign_data() {
    var _data = [];
    for (var e = 0; e < 4; e++) {
        var _episode = [];
        for (var m = 0; m < 5; m++) {
            _episode[m] = {
                status: 0, 
                score: 0,
                stars: 0
            };
        }
        _data[e] = _episode;
    }
    _data[0][0].status = 1; // Unlock first level
    return _data;
}