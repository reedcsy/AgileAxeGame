/// @desc Parent Combat & Persistence Logic

if (global.paused) exit;

// --- 1. DAMAGE DETECTION (Melee & Dagger) ---
var _hit_by_melee = place_meeting(x, y, obj_player_melee);
var _hit_by_dagger = place_meeting(x, y, obj_dagger);

if (_hit_by_melee || _hit_by_dagger) {
    if (!is_hit) { 
        hp -= 1;  
        is_hit = true;
        flash = 5;
        
        // Impact Sound
        var _snd_hit = asset_get_index("snd_dagger_hit");
        if (_snd_hit != -1) audio_play_sound(_snd_hit, 10, false);
        
        // Specific Dagger Handling: Destroy the dagger instance that hit us
        if (_hit_by_dagger) {
            var _inst_dagger = instance_place(x, y, obj_dagger);
            if (_inst_dagger != noone) instance_destroy(_inst_dagger);
        }
    }
} else {
    is_hit = false; 
}

// --- 2. DEATH LOGIC ---
if (hp <= 0 && !is_dying) {
    is_dying = true; // LOCK IT: Prevents double-counting and multi-frame destruction
    
    // A. PERSISTENCE: Record death in the DS Map
    if (variable_global_exists("dead_enemies") && ds_exists(global.dead_enemies, ds_type_map)) {
        if (variable_instance_exists(id, "my_key")) {
            ds_map_add(global.dead_enemies, my_key, true);
        }
    }
    
    // B. TRACKING: Increment kill count
    global.enemies_killed++;

    // C. DIRECTIONAL CALCULATION (For particle trajectory)
    var _dir = 1; 
    if (instance_exists(obj_player)) {
        _dir = sign(x - obj_player.x);
        if (_dir == 0) _dir = obj_player.image_xscale; 
    }

    // D. SPAWN PARTICLES (obj_death_effect)
    var _p_asset = asset_get_index("obj_death_effect");
    if (_p_asset != -1) {
        repeat(50) {
            var _p = instance_create_depth(x, y, -9000, _p_asset);
            _p.hsp = (_dir * random_range(3, 10)); 
            _p.vsp = random_range(-10, 2); 
            
            // Set Color
            if (variable_instance_exists(id, "blood_color")) {
                _p.color = blood_color;
            } else {
                _p.color = choose($800080, $4B0082, $EE82EE, c_fuchsia);
            }
        }
    }

    // E. JUICE: SCREEN SHAKE & HIT-STOP
    if (instance_exists(obj_camera)) {
        obj_camera.shake_remain = 8; 
        obj_camera.shake_magnitude = 8;
    }
    
    if (instance_exists(obj_game_controller)) {
        obj_game_controller.freeze_timer = 5; 
    }

    // F. FINAL DESTRUCTION
    instance_destroy();
}