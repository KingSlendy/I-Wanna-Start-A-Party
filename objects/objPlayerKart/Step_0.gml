if (!frozen) {
}

if (onGround) {
    if (place_meeting(x, y, objMinigame4vs_Karts_TrackCol)) {
        if (true/*!(place_meeting(x, y, objKartsRumbleRoad))*/)
            maxSpeed = baseMaxSpeed
        else
        {
            maxSpeed = roughTerrainSpeed
            drift = 0
            audio_stop_sound(driftSound)
            driftSkid = 0
            minTex = 2
            maxTex = 4
            drawTex = clamp(drawTex, minTex, maxTex)
        }
    }
    else
    {
        maxSpeed = offTrackSpeed
		
        if drift
        {
            drift = 0
            audio_stop_sound(driftSound)
            driftSkid = 0
            minTex = 2
            maxTex = 4
            drawTex = clamp(drawTex, minTex, maxTex)
        }
    }
}
    
if global.actions.up.held(network_id)
{
    speed += 0.025
    if (speed > maxSpeed)
        speed = maxSpeed
    if drift
    {
        if (speed > driftSpeed)
            speed = driftSpeed
    }
}
else if global.actions.down.held(network_id)
{
    speed -= 0.05
    if (speed < -1)
        speed = -1
}
else
{
    speed += ((-speed) * 0.02)
    if abs(speed < 0.3)
        speed = 0
}
    
var setEngineSound = noone;
    
if (abs(speed) > engineMaxSpeed) {
    setEngineSound = sndMinigame4vs_Karts_PlayerEngineHigh;
} else if (abs(speed) > 0) {
    setEngineSound = sndMinigame4vs_Karts_PlayerEngineLow;
} else {
    setEngineSound = sndMinigame4vs_Karts_PlayerEngineIdle;
}
    
if (setEngineSound != prevEngineSound) {
    audio_stop_sound(engineSound);
		
	if (network_id == global.player_id) {
		engineSound = audio_play_sound(setEngineSound, 1, true);
	}
}
    
prevEngineSound = setEngineSound;
    
if onGround
{
    if drift
    {
        if (!global.actions.jump.held(network_id))
        {
            drift = 0
            driftSkid = 0
            minTex = 2
            maxTex = 4
            drawTex = clamp(drawTex, minTex, maxTex)
            turnRate = normalTurnRate
        }
        else
            turnRate = driftTurnRate
    }
    else
        turnRate = normalTurnRate
}
else
    turnRate = 0.25
        
if (abs(speed) > 0)
{
    if global.actions.left.held(network_id)
    {
        if (abs(speed) >= 0.25)
        {
            if (!drift)
            {
                direction = (direction + turnRate + 360) % 360;
                if (steerAnimTime <= 0)
                {
                    steerAnimTime = steerAnimDelay
                    drawTex--
                    if (drawTex < minTex)
                        drawTex = minTex
                }
                else
                    steerAnimTime--
            }
            else
            {
                if (driftSkid >= 0)
                {
                    direction = (direction + turnRate + 360) % 360;
                    if (steerAnimTime <= 0)
                    {
                        steerAnimTime = steerAnimDelay
                        drawTex--
                        if (drawTex < minTex)
                            drawTex = minTex
                    }
                    else
                        steerAnimTime--
                }
                if (driftSkid == 0)
                    driftSkid = 1
            }
        }
    }
    else if global.actions.right.held(network_id)
    {
        if (abs(speed) >= 0.25)
        {
            if (!drift)
            {
                direction = (direction - turnRate + 360) % 360;
                if (steerAnimTime <= 0)
                {
                    steerAnimTime = steerAnimDelay
                    drawTex++
                    if (drawTex > maxTex)
                        drawTex = maxTex
                }
                else
                    steerAnimTime--
            }
            else
            {
                if (driftSkid <= 0)
                {
                    direction = (direction - turnRate + 360) % 360;
                    if (steerAnimTime <= 0)
                    {
                        steerAnimTime = steerAnimDelay
                        drawTex++
                        if (drawTex > maxTex)
                            drawTex = maxTex
                    }
                    else
                        steerAnimTime--
                }
                if (driftSkid == 0)
                    driftSkid = -1
            }
        }
    }
    else
    {
        drift = 0
        driftSkid = 0
        minTex = 2
        maxTex = 4
    }
}
if (((!global.actions.left.held(network_id)) && (!global.actions.right.held(network_id))) || speed < 0.5)
{
    if (steerAnimTime <= 0)
    {
        steerAnimTime = steerAnimDelay
        if (drawTex < 3)
            drawTex++
        else if (drawTex > 3)
            drawTex--
    }
    else
        steerAnimTime--
}
zSpeed -= 0.1
if (zSpeed < -1)
    zSpeed = -1
z += zSpeed
if (z <= 0)
{
    z = 0
    zSpeed = 0
    if (!onGround)
    {
        onGround = 1
        audio_play_sound(sndMinigame4vs_Karts_PlayerLanding, 0, false)
        if ((global.actions.left.held(network_id) || global.actions.right.held(network_id)) && global.actions.jump.held(network_id))
        {
            drift = 1
            driftSound = audio_play_sound(sndMinigame4vs_Karts_PlayerDrift, 0, true)
            audio_sound_pitch(driftSound, random_range(0.9, 1.1))
            minTex = 0
            maxTex = 6
        }
    }
}

    
if global.actions.jump.pressed(network_id)
{
    if onGround
    {
        audio_play_sound(sndMinigame4vs_Karts_PlayerJump, 0, false)
        zSpeed = jumpSpeed
        onGround = 0
    }
}
    
lookBehind = (global.actions.shoot.held(network_id));    
        
if (!drift) {
    audio_stop_sound(driftSound)
}