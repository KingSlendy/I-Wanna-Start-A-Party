audio_play_sound(sndDeath, 0, false);
x = checkX;
y = checkY;
direction = checkDir;
audio_stop_sound(engineSound);
audio_stop_sound(driftSound);

if (drift) {
    drift = 0;
    audio_stop_sound(driftSound);
    driftSkid = 0;
    minTex = 2;
    maxTex = 4;
    drawTex = clamp(drawTex, minTex, maxTex);
}

engineSpeed = 0;
speed = 0;
boosted = 0;

