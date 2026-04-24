// 2. Trigger the Parent's logic 
// (This handles: global.player_score += value, the sparkle, and instance_destroy)
event_inherited();

// Add the custom value variable to the score
global.player_score += gem_value;

if (audio_exists(snd_big_bonus)) {
    audio_play_sound(snd_big_bonus, 5, false);
}

// 2. Add the sparkle effect at the gem's location
if (object_exists(obj_sparkle_effect)) {
    instance_create_layer(x, y, "Instances", obj_sparkle_effect);
}

instance_destroy();