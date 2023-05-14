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
	new BonusShine(language_get_text("PARTY_RESULTS_BONUS_COINS")),
	new BonusShine(language_get_text("PARTY_RESULTS_BONUS_ITEMS")),
	new BonusShine(language_get_text("PARTY_RESULTS_BONUS_MINIGAMES")),
	new BonusShine(language_get_text("PARTY_RESULTS_BONUS_ROLLS")),
	new BonusShine(language_get_text("PARTY_RESULTS_BONUS_RED_SPACES")),
	new BonusShine(language_get_text("PARTY_RESULTS_BONUS_COIN_SPACES")),
	new BonusShine(language_get_text("PARTY_RESULTS_BONUS_ITEM_SPACES")),
	new BonusShine(language_get_text("PARTY_RESULTS_BONUS_CHANCE_SPACES")),
	new BonusShine(language_get_text("PARTY_RESULTS_BONUS_GUY_SPACES")),
	new BonusShine(language_get_text("PARTY_RESULTS_BONUS_SURPRISE_SPACES")),
	new BonusShine(language_get_text("PARTY_RESULTS_BONUS_SHOP")),
	new BonusShine(language_get_text("PARTY_RESULTS_BONUS_BLACKHOLE"))
];

for (var i = 0; i < array_length(global.bonus_shines); i++) {
	global.bonus_shines[i].index = i;
}

global.bonus_shines_ready = array_create(global.player_max, false);

function bonus_shine_by_id(bonus_id) {
	return global.bonus_shines[bonus_id];
}