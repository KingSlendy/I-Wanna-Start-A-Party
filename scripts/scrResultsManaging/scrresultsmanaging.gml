function BonusShine(text) constructor {
	self.text = text;
	
	static reset_scores = function() {
		self.scores = array_create(global.player_max, 0);
	}
	
	self.reset_scores();
	
	static increase_score = function(player_turn = global.player_turn, amount = 1) {
		if (player_turn > global.player_max) {
			return;
		}
		
		self.scores[player_turn - 1] += amount;
	}
	
	static set_score = function(player_turn = global.player_turn, score = 0) {
		if (player_turn > global.player_max) {
			return;
		}
		
		self.scores[player_turn - 1] = score;
	}
	
	static is_candidate = function() {
		return (array_count(self.scores, 0) < global.player_max);
	}
	
	static max_players = function() {
		var players = [];
		var max_score = -infinity;
		
		for (var i = 0; i < global.player_max; i++) {
			max_score = max(self.scores[i], max_score);
		}
		
		for (var i = 0; i < global.player_max; i++) {
			if (self.scores[i] == max_score) {
				array_push(players, i + 1);
			}
		}
		
		return players;
	}
}

enum BonusShines {
	MostCoins,
	MostItems,
	MostMinigames,
	MostRoll,
	MostRedSpaces,
	MostCoinSpaces,
	MostItemSpaces,
	MostChanceTimeSpaces,
	MostTheGuySpaces,
	MostSurpriseSpaces,
	MostPurchases,
	MostSteals
}

global.bonus_shines = [
	new BonusShine("got the most Coins"),
	new BonusShine("used the most Items"),
	new BonusShine("won the most Minigames"),
	new BonusShine("rolled the biggest Numbers on the die"),
	new BonusShine("landed on the most Red spaces"),
	new BonusShine("landed on the most Coin spaces"),
	new BonusShine("landed on the most Item spaces"),
	new BonusShine("landed on the most Chance Time spaces"),
	new BonusShine("landed on the most The Guy spaces"),
	new BonusShine("spent the most Coins on the Shop"),
	new BonusShine("lost most stuff due to Blackhole"),
	new BonusShine("had the worst luck on the Party")
];

for (var i = 0; i < array_length(global.bonus_shines); i++) {
	global.bonus_shines[i].index = i;
}

global.bonus_shines_ready = array_create(global.player_max, false);

function bonus_shine_by_id(bonus_id) {
	return global.bonus_shines[bonus_id];
}