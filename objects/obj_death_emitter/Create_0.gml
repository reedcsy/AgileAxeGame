/// @desc Explode Immediately
if (variable_global_exists("part_player_death")) {
    part_particles_create(global.part_sys, x, y, global.part_player_death, 150);
}
// Also trigger the built-in effect here as a backup
effect_create_above(ef_explosion, x, y, 1, c_purple);

alarm[0] = 120; // Destroy this emitter after 2 seconds