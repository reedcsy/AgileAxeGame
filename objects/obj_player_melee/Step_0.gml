/// @desc Hitbox Logic

// 1. FOLLOW THE PLAYER
// This ensures the "sword" moves with your Brave Knight
if (instance_exists(obj_player)) {
    x = obj_player.x + (obj_player.image_xscale * 24); // Adjusted offset for better reach
    y = obj_player.y;
    image_xscale = obj_player.image_xscale;
} else {
    instance_destroy(); // Safety: if the player dies, the hitbox should too
}

// 2. REMOVAL
// Note: We removed the "with(other)" and "instance_create" lines.
// "with(other)" only works in Collision Events.
// "instance_create" should only happen in the PLAYER object.