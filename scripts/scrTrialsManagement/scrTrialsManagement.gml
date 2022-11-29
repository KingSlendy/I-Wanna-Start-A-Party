#macro EITHER 0
#macro SOLO 1
#macro TEAM 2

#region Names
#macro RAPID_ASCENSION "Rapid Ascension"
#macro HAUNTED_REFLEXES "Haunted Reflexes"
#macro BUGS_EVERYWHERE "Bugs Everywhere"
#macro STINGY_CHESTS "Stingy Chests"
#macro AVOID_THE_ANXIETY "Avoid The Anxiety"
#macro RANDRANDRAND_TIME "RandRandRand Time"
#macro INVERTED_COMPETITION "Inverted Competition"
#macro FOGGY_DAY "Foggy Day"
#macro INVISI_GAME "Invisi-game"
#macro FLIPPED_WORLD "Flipped World"
#macro COLORFUL_MADNESS "Colorful Madness"
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
		]),
		
		new Trial(STINGY_CHESTS, [
			new Prove(CRAZY_CHESTS)
		]),
		
		new Trial(AVOID_THE_ANXIETY, [
			new Prove(AVOID_THE_ANGUISH, TEAM)
		], 200),
		
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
			new Prove(GETTINGS_COINS, SOLO)
		], 400),
		
		new Trial(FLIPPED_WORLD, [
			new Prove(MAGIC_MEMORY),
			new Prove(GIGANTIC_RACE, SOLO)
		], 400),
		
		new Trial(COLORFUL_MADNESS, [
			new Prove(COLORFUL_INSANITY)
		], 300)
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
	array_push(global.beaten_trials, index);
	array_sort(global.beaten_trials, true);
	save_file();
}

function trial_info_reset() {
	global.trial_info = {
		reference: null,
		current: 0
	};
}

function trial_start() {
	var minigame_info = global.minigame_info;
	var trial_info = global.trial_info;
	var exit_trial = false;
	
	if (trial_info.current > 0) {
		if (!array_contains(minigame_info.players_won, global.player_id) || minigame_info.player_scores[global.player_id - 1].points == 0) {
			exit_trial = true;
		} else if (trial_info.current == array_length(trial_info.reference.minigames)) {
			change_collected_coins(trial_info.reference.reward);
			
			if (!trial_beaten(trial_info.reference.index)) {
				trial_beat(trial_info.reference.index);
			}
			
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
	
	minigame_info_set(prove.reference, prove.type, team);
	global.minigame_info.is_trials = true;
	room_goto(prove.reference.scene);
}

function trial_is_title(title) {
	var info = global.trial_info;
	
	if (info.reference == null) {
		return false;
	}
	
	return (info.reference.title == title);
}