if (global.player_id != 1 || !movable || !hittable) {
    exit;
}

var dir = point_direction(other.x, other.y, x, y - 16);
hspeed = lengthdir_x(6, (other.xscale == 1) ? 0 : 180);
vspeed = lengthdir_y(6, dir);
gravity = 0.4;

if (hittable) {
    var kick_volume = remap(abs(hspeed), 0, 6, 0.5, 1);
    var kick_sound = choose(sndMinigame2vs2_Soccer_Hit_Player, sndMinigame2vs2_Soccer_Hit_Player2);
    audio_play_sound(kick_sound, 0, false, kick_volume,, random_range(0.9, 1.1));
}

alarm_frames(1, 6);