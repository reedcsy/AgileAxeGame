/// @desc Dagger Impact - Safe Persistence & Death Juice

// 1. DAMAGE & SCORE
// 'other' is the dagger instance
hp -= other.damage;
global.player_score += 500; 

// 2. IMPACT FEEDBACK (Always runs on hit)
instance_create_layer(x, y, "Instances", obj_sparkle_effect);

if (audio_exists(snd_dagger_hit)) {
    audio_play_sound(snd_dagger_hit, 10, false);
}

// Destroy the dagger immediately so it doesn't hit twice
with(other) instance_destroy();

// 3. DEATH & PERSISTENCE LOGIC
if (hp <= 0) {
    // --- PERSISTENCE: The "Stay Dead" Registry ---
    var _key = room_get_name(room) + string(id);
    
	
    // THE FAIL-SAFE GATEKEEPER
    if (variable_global_exists("dead_enemies")) {
        if (ds_exists(global.dead_enemies, ds_type_map)) {
            // Map is healthy, add the kill
            ds_map_add(global.dead_enemies, _key, true);
        } else {
            // Map is invalid/missing, recreate it to prevent the crash
            global.dead_enemies = ds_map_create();
            ds_map_add(global.dead_enemies, _key, true);
        }
    }
    
    // Update Scorecard
    global.enemies_killed++;
    
    // --- JUICE: Death Effects ---
    // Screen Shake & Hit-Stop
    if (instance_exists(obj_camera)) {
        obj_camera.shake_remain = 6; 
        obj_camera.shake_magnitude = 4;
    }
    
    if (instance_exists(obj_game_controller)) {
        obj_game_controller.freeze_timer = 5; 
    }
    
    // Particles (Purple Ichor)
    if (variable_global_exists("part_sys")) {
        part_particles_create(global.part_sys, x, y, global.part_death_purple, 25);
    }
    
    // Sounds & Smoke
    var _hurt_snd = asset_get_index("snd_spider_hurt");
    if (_hurt_snd != -1) audio_play_sound(_hurt_snd, 11, false);
    
    effect_create_above(ef_smoke, x, y, 0, c_white);

    // Final Destruction
    instance_destroy();
    
} else {
    // --- SURVIVAL FEEDBACK ---
    flash = 5; // Trigger hit-flash shader
}