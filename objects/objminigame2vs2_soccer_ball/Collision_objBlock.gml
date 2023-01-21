x = xprevious;
y = yprevious;

if (place_meeting(x + hspeed, y, objBlock)) {
    while (!place_meeting(x + sign(hspeed), y, objBlock)) {
        x += sign(hspeed);
    }
    
    hspeed *= -1;
    
    if (movable) {
        var bounce_volume = remap(abs(hspeed), 0, 6, .5, 1.2);
        var bounce_sound = choose(sndMinigame2vs2_Soccer_Ground_Bounce, sndMinigame2vs2_Soccer_Ground_Bounce2);
        audio_play_sound(bounce_sound, 0, false, bounce_volume,, random_range(0.9, 1.1));
    }
}

if (place_meeting(x, y + vspeed, objBlock)) {
    while (!place_meeting(x, y + sign(vspeed), objBlock)) {
        y += sign(vspeed);
    }
    
    vspeed *= -0.75;
    
    if (movable) {
        var bounce_volume = remap(abs(vspeed), 0, 6, 0.5, 1.2);
        var bounce_sound = choose(sndMinigame2vs2_Soccer_Ground_Bounce, sndMinigame2vs2_Soccer_Ground_Bounce2);
        audio_play_sound(bounce_sound, 0, false, bounce_volume,, random_range(0.9, 1.1));
    }
}