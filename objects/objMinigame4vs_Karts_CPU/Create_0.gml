position = 0;
check_position = 0;

function karts_cpu_choose_path() {
	path_start(choose(pthMinigame4vs_Karts_CPU_1, pthMinigame4vs_Karts_CPU_2, pthMinigame4vs_Karts_CPU_3, pthMinigame4vs_Karts_CPU_4), 5, path_action_stop, true);
}

karts_cpu_choose_path();