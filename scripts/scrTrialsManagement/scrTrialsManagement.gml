function Trial(title, minigames, reward = 100) constructor {
	self.title = title;
	self.minigames = minigames;
	self.reward = reward;
	self.index = -1;
}

function trial_init() {
	global.trials = [
		new Trial("Test", [
			TRIAL TOWER_ASCENSION SOLO,
			TRIAL MAGIC_MEMORY SOLO
		]),
		
		new Trial("Test 2", [
			TRIAL FOLLOW_THE_LEAD SOLO,
			TRIAL GIGANTIC_RACE TEAM
		]),
		
		new Trial("Platform trial", [
			TRIAL PAINTING_PLATFORMS SOLO,
			TRIAL TOWER_ASCENSION SOLO,
			TRIAL WARPING_UP SOLO,
			TRIAL HIDDEN_HOST SOLO
		], 500)
	];
	
	for (var i = 0; i < array_length(global.trials); i++) {
		var trial = global.trials[i];
		trial.index = i;

		for (var j = 0; j < array_length(trial.minigames); j++) {
			trial.minigames[j][0] = minigame_by_title(trial.minigames[j][0]);
		}
	}
}

function trial_collected(index) {
	return array_search(global.collected_trials, index);
}

function trial_collect(index) {
	array_push(global.collected_trials, index);
	array_sort(global.collected_trials, true);
	save_file();
}

function trial_beaten(index) {
	return array_search(global.beaten_trials, index);
}

function trial_beat(index) {
	array_push(global.beaten_trials, index);
	array_sort(global.beaten_trials, true);
	save_file();
}