#macro EITHER 0
#macro SOLO 1
#macro TEAM 2

#region Names
#macro RAPID_ASCENSION language_get_text("TRIALS_RAPID_ASCENSION_NAME")
#macro HAUNTED_REFLEXES language_get_text("TRIALS_HAUNTED_REFLEXES_NAME")
#macro BUGS_EVERYWHERE language_get_text("TRIALS_BUGS_EVERYWHERE_NAME")
#macro STINGY_CHESTS language_get_text("TRIALS_STINGY_CHESTS_NAME")
#macro AVOID_THE_ANXIETY language_get_text("TRIALS_AVOID_THE_ANXIETY_NAME")
#macro RANDRANDRAND_TIME language_get_text("TRIALS_RANDRANDRAND_TIME_NAME")
#macro INVERTED_COMPETITION language_get_text("TRIALS_INVERTED_COMPETITION_NAME")
#macro FOGGY_DAY language_get_text("TRIALS_FOGGY_DAY_NAME")
#macro INVISI_GAME language_get_text("TRIALS_INVISI-GAME_NAME")
#macro FLIPPED_WORLD language_get_text("TRIALS_FLIPPED_WORLD_NAME")
#macro COLORFUL_MADNESS language_get_text("TRIALS_COLORFUL_MADNESS_NAME")
#macro SPEEDY_KIDZALES language_get_text("TRIALS_SPEEDY_KIDZALES_NAME")
#macro WIDE_KID language_get_text("TRIALS_WIDE_KID_NAME")
#macro SLOW_POKE language_get_text("TRIALS_SLOW_POKE_NAME")
#macro PERFECT_AIM language_get_text("TRIALS_PERFECT_AIM_NAME")
#macro TOUGH_IGNITION language_get_text("TRIALS_TOUGH_IGNITION_NAME")
#macro GREEN_DIVING language_get_text("TRIALS_GREEN_DIVING_NAME")
#macro WAKA_DODGES language_get_text("TRIALS_WAKA_DODGES_NAME")
#macro TINY_TEAMING language_get_text("TRIALS_TINY_TEAMING_NAME")
#macro CHALLENGE_MEDLEY language_get_text("TRIALS_CHALLENGE_MEDLEY_NAME")
#endregion

function Trial(title, minigames, reward = 100) constructor {
	self.title = title;
	self.minigames = minigames;
	self.reward = reward;
	self.index = -1;
}

function Prove(title, team = SOLO) constructor {
	self.title = title;
	self.team = team;
	self.reference = null;
	self.type = null;
	
	static init = function() {
		var minigame = minigame_by_title(self.title);
		self.reference = minigame[0];
		self.type = minigame[1];
	}
}

function trial_init() {
	global.trials = [
		new Trial(RAPID_ASCENSION, [
			new Prove(TOWER_ASCENSION)
		]),
		
		new Trial(HAUNTED_REFLEXES, [
			new Prove(HAUNTED_FOREST)
		]),
		
		new Trial(BUGS_EVERYWHERE, [
			new Prove(BUGS_AROUND)
		], 200),
		
		new Trial(STINGY_CHESTS, [
			new Prove(CRAZY_CHESTS)
		]),
		
		new Trial(AVOID_THE_ANXIETY, [
			new Prove(AVOID_THE_ANGUISH, TEAM)
		], 400),
		
		new Trial(RANDRANDRAND_TIME, [
			new Prove(HUNT_TROUBLE, SOLO),
			new Prove(DRAWN_KEYS),
			new Prove(PAINTING_PLATFORMS),
			new Prove(UNSTABLE_BLOCKS),
		], 300),
		
		new Trial(INVERTED_COMPETITION, [
			new Prove(BUBBLE_DERBY),
			new Prove(ROCKET_IGNITION)
		], 500),
		
		new Trial(FOGGY_DAY, [
			new Prove(HAUNTED_FOREST),
			new Prove(DIZZY_CONUNDRUM)
		], 300),
		
		new Trial(INVISI_GAME, [
			new Prove(CONVEYOR_HAVOC, TEAM),
			new Prove(WARPING_UP, SOLO),
			new Prove(GETTING_COINS, SOLO)
		], 400),
		
		new Trial(FLIPPED_WORLD, [
			new Prove(GIGANTIC_RACE, SOLO),
			new Prove(MAGIC_MEMORY)
		], 400),
		
		new Trial(COLORFUL_MADNESS, [
			new Prove(COLORFUL_INSANITY)
		], 600),
		
		new Trial(SPEEDY_KIDZALES, [
			new Prove(TOWER_ASCENSION),
			new Prove(CONVEYOR_HAVOC, TEAM),
			new Prove(AVOID_THE_ANGUISH, TEAM)
		], 500),
		
		new Trial(WIDE_KID, [
			new Prove(SPRINGING_PIRANHA),
			new Prove(AVOID_THE_ANGUISH, TEAM)
		]),
		
		new Trial(SLOW_POKE, [
			new Prove(BAD_HOUSE, SOLO),
			new Prove(HIDDEN_HOST, SOLO),
			new Prove(CATCH_THE_FRUITS)
		], 200),
		
		new Trial(PERFECT_AIM, [
			new Prove(TARGETING_TARGETS),
			new Prove(GOLF_COURSE)
		], 600),
		
		new Trial(TOUGH_IGNITION, [
			new Prove(ROCKET_IGNITION)
		], 500),
		
		new Trial(GREEN_DIVING, [
			new Prove(SKY_DIVING)
		], 300),
		
		new Trial(WAKA_DODGES, [
			new Prove(WAKA_EVASION)
		], 400),
		
		new Trial(TINY_TEAMING, [
			new Prove(SOCCER_MATCH),
			new Prove(SPRINGING_PIRANHA),
			new Prove(CATCH_THE_FRUITS)
		], 300),
		
		new Trial(CHALLENGE_MEDLEY, [
			new Prove(DYNYAAMIC_DUOS),
			new Prove(WARPING_UP),
			new Prove(A_MAZE_ING),
			new Prove(BUTTONS_EVERYWHERE)
		], 1000)
	];
	
	for (var i = 0; i < array_length(global.trials); i++) {
		var trial = global.trials[i];
		trial.index = i;

		for (var j = 0; j < array_length(trial.minigames); j++) {
			trial.minigames[j].init();
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
	if (!trial_beaten(index)) {
		array_push(global.beaten_trials, index);
		array_sort(global.beaten_trials, true);
	}
	
	if (array_length(global.beaten_trials) == array_length(global.trials)) {
		achieve_trophy(77);
	}
	
	save_file();
}

function trial_info_reset() {
	global.trial_info = {
		reference: null,
		current: 0
	};
}

function trial_start() {
	var trial_info = global.trial_info;
	var exit_trial = false;
	
	if (trial_info.current > 0) {
		if (!minigame_has_won()) {
			exit_trial = true;
		} else if (trial_info.current == array_length(trial_info.reference.minigames)) {
			change_collected_coins(trial_info.reference.reward);
			trial_beat(trial_info.reference.index);
			exit_trial = true;
		}
	
		if (exit_trial) {
			disable_board();
			room_goto(rTrials);
			return;
		}
	}
	
	var prove = trial_info.reference.minigames[trial_info.current++];
	var team = null;
	
	switch (prove.type) {
		case "4vs": team = [1, 2, 3, 4]; break;
		
		case "1vs3":
			switch (prove.team) {
				case EITHER: team = [irandom_range(1, global.player_max)]; break;
				case SOLO: team = [1]; break;
				case TEAM: team = [irandom_range(2, global.player_max)]; break;
			}
			break;
			
		case "2vs2": team = [1, 2]; break;
	}
	
	minigame_info_set(prove.reference, prove.type,, team);
	global.minigame_info.is_trials = true;
	room_goto(prove.reference.scene);
}

function trial_restart() {
	global.trial_info.current = 0;
	trial_start();
}

function trial_is_title(title) {
	var info = global.trial_info;
	
	if (info.reference == null) {
		return false;
	}
	
	return (info.reference.title == title);
}