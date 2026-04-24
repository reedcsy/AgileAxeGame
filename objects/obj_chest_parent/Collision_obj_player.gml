/// @desc Collision with Player - Persistence & Rewards

// 0. SAFETY GATE: Only trigger if not already opened
if (variable_instance_exists(id, "is_opened") && is_opened) exit;

/// @desc Collision with Player

// 1. SAVE TO PERMANENT RECORD FIRST
if (variable_global_exists("dead_enemies") && ds_exists(global.dead_enemies, ds_type_map)) {
    ds_map_add(global.dead_enemies, my_key, true);
    show_debug_message("CHEST LOGGED: " + string(my_key));
}

// 2. REWARDS & TRACKING
global.player_score += (variable_instance_exists(id, "value") ? value : 100);
global.gems_collected += (variable_instance_exists(id, "ruby_reward") ? ruby_reward : 1);
global.chests_found += 1;

// 3. VISUALS & AUDIO
instance_create_layer(x, y, "Instances", obj_chest_popup);
instance_create_layer(x, y, "Instances", obj_chest_audio_sequencer);

// 4. CLEANUP
instance_destroy();

// Optional: Instead of instance_destroy(), we keep it as a "hollow" open chest.
// If you MUST destroy it, keep this line. Otherwise, comment it out.
 instance_destroy();