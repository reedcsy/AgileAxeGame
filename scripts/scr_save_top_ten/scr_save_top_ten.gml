function scr_save_top_ten(_new_time, _new_points = 0, _new_gems = 0) {
    var _times  = array_create(10, 999999); 
    var _points = array_create(10, 0);
    var _gems   = array_create(10, 0);
    
    ini_open("scores.ini");
    
    // 1. LOAD
    for (var i = 0; i < 10; i++) {
        _points[i] = ini_read_real("TopTen", "Points" + string(i), 0);
        _times[i]  = ini_read_real("TopTen", "Time" + string(i), 999999);
        _gems[i]   = ini_read_real("TopTen", "Gems" + string(i), 0);
    }
    
    // 2. SORT BY SCORE (Primary)
    var _made_the_list = false;
    for (var i = 0; i < 10; i++) {
        // Condition: New score is higher than the one in this slot
        if (_new_points > _points[i]) {
            _made_the_list = true;
            
            // Shift down
            for (var j = 9; j > i; j--) {
                _times[j]  = _times[j - 1];
                _points[j] = _points[j - 1];
                _gems[j]   = _gems[j - 1];
            }
            
            // Insert
            _points[i] = _new_points;
            _times[i]  = _new_time;
            _gems[i]   = _new_gems;
            break; 
        }
    }
    
    // 3. SAVE
    for (var i = 0; i < 10; i++) {
        ini_write_real("TopTen", "Points" + string(i), _points[i]);
        ini_write_real("TopTen", "Time" + string(i), _times[i]);
        ini_write_real("TopTen", "Gems" + string(i), _gems[i]);
    }
    ini_close();
}