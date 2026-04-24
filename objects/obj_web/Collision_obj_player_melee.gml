/// @desc Destroyed by Melee

// 1. VISUAL FEEDBACK
// If you have a particle effect or a "pop" sprite, spawn it here
// instance_create_layer(x, y, "Instances", obj_web_pop);

// 2. AUDIO FEEDBACK
//var _snd = asset_get_index("snd_web_break"); // Or any generic "snip" sound
//if (_snd != -1) audio_play_sound(_snd, 10, false);

// 3. REMOVAL
instance_destroy();