// Destroy the dagger (unless you want it to pierce through)
with (other) {
    instance_destroy();
}

// Destroy the web
instance_destroy();
// Just destroy the web piece
instance_destroy();

// Optional: Create a small puff of silk particles
 effect_create_above(ef_smoke, x, y, 0, c_white);
 
 // Stop the wobble and start falling/fading
can_wobble = false; 
image_alpha -= 0.1; 

// If it's mostly invisible, kill it
if (image_alpha <= 0) {
    instance_destroy();
}