if (y - vspeed / 2 <= other.y) {
    if (other.vspeed >= 0) {
        y = other.y - 9;
        vspd = other.vspeed;
    }
        
    on_platform = true;
    reset_jumps();
}