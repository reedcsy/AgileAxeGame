// Draw Event
var _is_selected = (obj_map_controller.selected_index == button_index);
var _shadow_alpha = _is_selected ? 0.7 : 0.4;
var _shadow_dist = _is_selected ? 12 : 6;

// Draw Shadow
draw_sprite_ext(sprite_index, image_index, x + _shadow_dist, y + _shadow_dist, 
                image_xscale, image_yscale, image_angle, c_black, _shadow_alpha);

// Draw Self
draw_self();