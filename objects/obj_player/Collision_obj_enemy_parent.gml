/// @desc Player Collision with Enemy (Safe Death Trigger)

if (!is_dead && !invincible) {
    
    // 1. DAMAGE & I-FRAMES
    hp -= 1;
    invincible = true;
    inv_timer = 60; 
    
    // 2. KNOCKBACK
    vsp = -3;
    hsp = (x < other.x) ? -5 : 5; 

    // 3. SURVIVAL CHECK
    if (hp > 0) {
        // --- STANDARD HURT ---
        if (audio_exists(snd_hurt)) audio_play_sound(snd_hurt, 10, false);
        
        if (instance_exists(obj_game_controller)) {
            obj_game_controller.freeze_timer = 3;
        }// --- THE ARCADE FLASH ---
// This uses a built-in shader-less trick to make the player look like a silhouette
with(other) {
    image_blend = c_white;
    image_alpha = 1.0;
}

// If you have a screen-flash object or a global overlay:
// instance_create_layer(0, 0, "Overlay", obj_screen_flash);
    } 
	
    else {
        // --- THE BRUTE FORCE DEATH EFFECT ---
        is_dead = true;
        
        // A. Create the emitter on a guaranteed top-level layer
        var _effect_layer = layer_get_id("Instances");
        if (_effect_layer == -1) _effect_layer = layer_create(-15000, "EffectLayer");

        var _emitter = instance_create_layer(x, y, _effect_layer, obj_death_emitter);

        // B. CRITICAL: Manually trigger the emitter's particle burst NOW
        // We don't wait for its Create event to finish naturally
        with (_emitter) {
            if (variable_global_exists("part_player_death")) {
                part_particles_create(global.part_sys, x, y, global.part_player_death, 150);
            }
            effect_create_above(ef_explosion, x, y, 1, c_purple);
        }

        // C. THE HIT STOP (Now safe to freeze, particles are already spawned)
        if (instance_exists(obj_game_controller)) {
            obj_game_controller.freeze_timer = 30; 
        }

        // D. CAMERA SHAKE
        var _cam = asset_get_index("obj_camera");
        if (_cam != -1 && instance_exists(_cam)) {
            with(_cam) shake = 15;
        }

        // E. DISABLE PLAYER
        visible = false; 
        hsp = 0;
        vsp = 0;
        alarm[11] = 90; // Giving the particles more time to shine
        
        if (audio_exists(snd_player_death)) {
            audio_play_sound(snd_player_death, 15, false);
        }
        
        show_debug_message("DEATH: Emitter forced burst before Hit Stop.");
    }
}