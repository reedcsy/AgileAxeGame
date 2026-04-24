// 1. APPLY PHYSICS
// Increase vertical speed by gravity every frame
vsp += grav;

// Apply the custom speeds to the actual position
// Since hsp is -7 when facing left, x will decrease (move left)
x += hsp;
y += vsp;

// Only rotate if the dagger is actually flying
if (hsp != 0) {
    image_angle -= 20 * sign(hsp);
}

// 2. ROTATION (Choose ONE)
// Choice A: The Classic Wizards & Warriors "Spin" 
// We use sign(hsp) so it spins the correct way based on its movement
image_angle -= 20 * sign(hsp);

// Choice B: The "Dart" look (Comment out the spin above to use this)
// image_angle = point_direction(0, 0, hsp, vsp); 


// 3. CLEANUP
// Destroy if it goes off the left, right, or bottom of the room
if (x < 0 || x > room_width || y > room_height) {
    instance_destroy();
}

