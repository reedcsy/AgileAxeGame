if (wobble_timer > 0) {
    wobble_timer -= 1;

    // Use sine to swing the angle back and forth around the base_angle
    // The "0.00001" controls the speed of the vibration
    image_angle = base_angle + sin(get_timer() * 0.00001) * wobble_amount;
} else {
    // Optional: Snap back to the original random angle once finished
    image_angle = base_angle;
}
// If the web moves off-screen, destroy it to save memory
if (y < 0 || y > room_height) {
    instance_destroy();
}