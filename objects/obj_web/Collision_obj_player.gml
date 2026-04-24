// 1. Target the player to apply knockback
with (other) {
    var _dir = sign(x - other.x);
    if (_dir == 0) _dir = 1;
    
    hsp = _dir * 8; // Knock them back
    vsp = -3;       // Pop them up
    
    // Safety check: force visibility back on 
    // in case a hazard logic tried to hide the player
    visible = true; 
}

// 2. Destroy the web so you don't hit it twice
instance_destroy();