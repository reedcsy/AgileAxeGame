// 1. Get Inputs
var _up    = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
var _down  = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
var _enter = keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space);

// 2. Move Selection
var _move = _down - _up;
index += _move;

// Loop selection (if you go up at the top, go to the bottom)
var _size = array_length(menu_options);
if (index < 0) index = _size - 1;
if (index >= _size) index = 0;

// 3. Select Option
if (_enter) {
    switch(index) {
        case 0: // Start Game
            room_goto(rm_level1); // MAKE SURE THIS MATCHES YOUR FIRST LEVEL NAME
            break;
        case 1: // Quit
            game_end();
            break;
    }
}