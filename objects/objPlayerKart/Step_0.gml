if (frozen) {
	exit;
}

//if (network_id == global.player_id) {
//	array_push(cpu_recordings, {cpu_x: x, cpu_y: y, cpu_z: z, cpu_dir: direction, cpu_tex: drawTex});
//}

if (on_ground) {
    if (place_meeting(x, y, objMinigame4vs_Karts_TrackCol)) {
		max_speed = base_max_speed;
    } else {
        max_speed = offtrack_speed;
		
        if (drift) {
            drift = false;
			audio_stop_sound(drift_sound);
            drift_skid = 0;
            min_tex = 2;
            max_tex = 4;
            draw_tex = clamp(draw_tex, min_tex, max_tex);
        }
    }
}
    
if (global.actions.up.held(network_id)) {
    speed += 0.025;
	
    if (speed > max_speed) {
        speed = max_speed;
	}
	
    if (drift) {
        if (speed > drift_speed) {
            speed = drift_speed;
		}
    }
} else if (global.actions.down.held(network_id)) {
    speed -= 0.05;
	
    if (speed < -1) {
        speed = -1;
	}
} else {
    speed += ((-speed) * 0.02);
	
    if (abs(speed < 0.3)) {
        speed = 0
	}
}
    
var set_engine_sound = noone;
    
if (abs(speed) > engine_max_speed) {
    set_engine_sound = sndMinigame4vs_Karts_PlayerEngineHigh;
} else if (abs(speed) > 0) {
    set_engine_sound = sndMinigame4vs_Karts_PlayerEngineLow;
} else {
    set_engine_sound = sndMinigame4vs_Karts_PlayerEngineIdle;
}
    
if (set_engine_sound != prev_engine_sound) {
    audio_stop_sound(engine_sound);
	engine_sound = audio_play_sound(set_engine_sound, 1, true);
}
    
prev_engine_sound = set_engine_sound;

var turn_rate = 0.25;
    
if (on_ground) {
    if (drift) {
        if (!global.actions.jump.held(network_id)) {
            drift = 0;
            drift_skid = 0;
            min_tex = 2;
            max_tex = 4;
            draw_tex = clamp(draw_tex, min_tex, max_tex);
            turn_rate = normal_turn_rate;
        } else {
            turn_rate = drift_turn_rate;
		}
    } else {
        turn_rate = normal_turn_rate;
	}
}
        
if (abs(speed) > 0) {
    if (global.actions.left.held(network_id)) {
        if (abs(speed) >= 0.25) {
            if (!drift) {
                direction = (direction + turn_rate + 360) % 360;
				
                if (--steer_anim_time <= 0) {
                    steer_anim_time = steer_anim_delay;
                    draw_tex--;
					
                    if (draw_tex < min_tex) {
                        draw_tex = min_tex;
					}
                }
            } else {
                if (drift_skid >= 0) {
                    direction = (direction + turn_rate + 360) % 360;
					
                    if (--steer_anim_time <= 0) {
                        steer_anim_time = steer_anim_delay;
                        draw_tex--;
						
                        if (draw_tex < min_tex) {
                            draw_tex = min_tex;
						}
                    }
                }
				
                if (drift_skid == 0) {
                    drift_skid = 1;
				}
            }
        }
    } else if (global.actions.right.held(network_id)) {
        if (abs(speed) >= 0.25) {
            if (!drift) {
                direction = (direction - turn_rate + 360) % 360;
				
                if (--steer_anim_time <= 0) {
                    steer_anim_time = steer_anim_delay;
                    draw_tex++;
					
                    if (draw_tex > max_tex) {
                        draw_tex = max_tex;
					}
                }
            } else {
                if (drift_skid <= 0) {
                    direction = (direction - turn_rate + 360) % 360;
					
                    if (--steer_anim_time <= 0) {
                        steer_anim_time = steer_anim_delay;
                        draw_tex++;
						
                        if (draw_tex > max_tex) {
                            draw_tex = max_tex;
						}
                    }
                }
				
                if (drift_skid == 0) {
                    drift_skid = -1;
				}
            }
        }
    } else {
        drift = false;
        drift_skid = 0;
        min_tex = 2;
        max_tex = 4;
    }
}

if ((!global.actions.left.held(network_id) && !global.actions.right.held(network_id)) || speed < 0.5) {
    if (--steer_anim_time <= 0) {
        steer_anim_time = steer_anim_delay;
		
        if (draw_tex < 3) {
            draw_tex++;
		} else if (draw_tex > 3) {
            draw_tex--;
		}
    }
}

zspeed -= 0.1;

if (zspeed < -1) {
    zspeed = -1;
}

z += zspeed;

if (z <= 0) {
    z = 0;
    zspeed = 0;
	
    if (!on_ground) {
        on_ground = true;
        audio_play_sound(sndMinigame4vs_Karts_PlayerLanding, 0, false);
		
        if ((global.actions.left.held(network_id) || global.actions.right.held(network_id)) && global.actions.jump.held(network_id)) {
            drift = true;

			audio_stop_sound(drift_sound);
            drift_sound = audio_play_sound(sndMinigame4vs_Karts_PlayerDrift, 0, true);
            audio_sound_pitch(drift_sound, random_range(0.9, 1.1));
            min_tex = 0;
            max_tex = 6;
        }
    }
}

    
if (global.actions.jump.pressed(network_id) && on_ground) {
    audio_play_sound(sndMinigame4vs_Karts_PlayerJump, 0, false);
    zspeed = jump_speed;
    on_ground = false;
}  
        
if (!drift) {
    audio_stop_sound(drift_sound);
}