///@desc The Guy Revolution
if (alarm[8] != -1) {
	exit;
}

if (instance_exists(objStatChange)) {
	alarm[9] = 1;
	exit;
}

for (var i = 1; i <= global.player_max; i++) {
	change_coins(total_coins, CoinChangeType.Gain, i);
}

alarm[5] = 1;
