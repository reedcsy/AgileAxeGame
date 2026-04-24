/// @desc Damage & Knockback Logic

if (ds_exists(hit_list, ds_type_list)) {
    // 1. Check if we've already hit this specific enemy instance
    if (ds_list_find_index(hit_list, other.id) == -1) {
        ds_list_add(hit_list, other.id);
        
        // 2. APPLY TO ENEMY
        with (other) {
            hp -= 3;
            flash = 10;
            
            // Disable ledge detection/AI flipping during knockback
            if (variable_instance_exists(id, "knockback_timer")) {
                knockback_timer = 30; 
            }
            
            // Calculate direction away from the swing center
            var _dir = sign(x - other.x);
            if (_dir == 0) _dir = obj_player.image_xscale; // Fallback if perfectly centered
            
            hsp = _dir * 5; 
            vsp = -3;
        }

        // 3. APPLY TO PLAYER (Recoil)
        if (instance_exists(obj_player)) {
            with (obj_player) {
                // Push player back slightly in opposite direction of facing
                hsp = -image_xscale * 2; 
            }
        }
        
        // 4. HIT-STOP (Game Juice)
        if (instance_exists(obj_game_controller)) {
            obj_game_controller.freeze_timer = 5; 
        }
    }
}