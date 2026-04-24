// 1. GATEKEEPER: If already reached, stop everything
// We check the sprite_index to see if we've already swapped
if (sprite_index == spr_checkpoint_active) exit;

// 2. TRIGGER THE "REACHED" STATE & SPRITE SWAP
// Swap from spr_checkpoint_idle to spr_checkpoint_active
sprite_index = spr_checkpoint_active;
image_index = 0; // Start the new animation from the beginning
image_speed = 1; // Ensure it animates (useful for flickering torches/flags)

// 3. PERMANENT DATA SAVE
global.checkpoint_x = x;
global.checkpoint_y = y;
global.checkpoint_room = room;

// 4. ONE-TIME VISUAL FX
if (audio_exists(snd_checkpoint)) {
    audio_play_sound(snd_checkpoint, 10, false);
}

// Built-in sparkle effect
effect_create_above(ef_spark, x, y - 16, 1, c_aqua);

// Custom Particle spawning
if (object_exists(obj_particle)) {
    repeat(20) {
        var _p = instance_create_layer(x, y - 16, "Instances", obj_particle);
        _p.image_blend = c_aqua; 
    }
}
// Save the game automatically when hitting a checkpoint
ini_open("savedata.ini");
ini_write_real("Player", "Gems", global.player_score);
ini_write_real("Progress", "Room", room);
ini_write_real("Progress", "CheckX", x);
ini_write_real("Progress", "CheckY", y);
ini_close();