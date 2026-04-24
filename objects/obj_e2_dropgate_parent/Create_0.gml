image_angle = 90; // Start in the upright position
target_angle = 90;
is_open = false;
rotation_speed = 4; // Degrees per frame

has_landed = false;

// New movement variables
fall_speed = 0;
gravity_power = 0.5; // Higher = faster acceleration
max_fall_speed = 12; // Cap it so it doesn't skip over the floor
