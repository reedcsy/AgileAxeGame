// Simple back-and-forth movement
if (place_meeting(x + hsp, y, obj_wall)) {
    hsp = -hsp; // Flip direction
}
x += hsp;

// Rotate the sprite for visual effect
image_angle += 5;