/// @desc Move between Start and End

// 1. Handle the timer (back and forth)
if (moving_forward) {
    move_timer += 1;
    if (move_timer >= duration) moving_forward = false;
} else {
    move_timer -= 1;
    if (move_timer <= 0) moving_forward = true;
}

// 2. Calculate the percentage (0 to 1)
var t = move_timer / duration;

// 3. Linear Interpolation (Lerp) to find the new position
var _next_x = lerp(start_x, target_x, t);
var _next_y = lerp(start_y, target_y, t);

// 4. Calculate velocity (needed to move the Raccoon Princess)
hsp = _next_x - x;
vsp = _next_y - y;

// 5. Apply the movement
x = _next_x;
y = _next_y;

// 6. Carry the Player (obj_player)
var _player = instance_place(x, y - 1, obj_player);
if (_player != noone) {
    _player.x += hsp;
    _player.y += vsp;
}