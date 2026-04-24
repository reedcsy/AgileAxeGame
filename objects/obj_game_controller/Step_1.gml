// Check if player exists
if (instance_exists(obj_player)) {
    
    // Wall Dust Logic
    if (obj_player.spawn_wall_dust) {
        part_particles_create(global.part_sys, obj_player.x, obj_player.y, global.part_jump, 5);
        obj_player.spawn_wall_dust = false; // Reset the flag
    }
    
    // Double Jump Logic
    if (obj_player.spawn_double_dust) {
        part_particles_create(global.part_sys, obj_player.x, obj_player.y + 10, global.part_jump, 10);
        obj_player.spawn_double_dust = false; // Reset the flag
    }
}