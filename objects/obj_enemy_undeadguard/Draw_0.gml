/// @desc Draw with Hit-Flash
draw_self();

// Draw Event
if (flash > 0) {
    gpu_set_fog(true, c_white, 0, 0); // Quick white flash
    draw_self();
    gpu_set_fog(false, c_white, 0, 0);
} else {
    draw_self();
}