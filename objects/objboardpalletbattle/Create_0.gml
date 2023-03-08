with (objBoardPalletPokemon) {
	if (sprite_index == player_info_by_turn().pokemon) {
		other.self_pokemon = id;
		break;
	}
}

with (objBoardPalletPokemon) {
	if (sprite_index == other.sprite) {
		other.other_pokemon = id;
		break;
	}
}

/*
You       Shine
Grass ->  Water   WIN
Water ->  Fire    WIN
Fire  ->  Grass   WIN
Water ->  Grass   LOSE
Fire  ->  Water   LOSE
Grass ->  Fire    LOSE
Grass ->  Grass   50/50
Water ->  Water   50/50
Fire  ->  Fire    50/50
*/

var win_types = {
	"Water": "Fire",
	"Grass": "Water",
	"Fire": "Grass"
};

var win_chance = 0;
var win_favorable = 0;

if (win_types[$ self_pokemon.power_type] == other_pokemon.power_type) {
	win_chance = 0.9;
	win_favorable = 1;
} else if (self_pokemon.power_type == other_pokemon.power_type) {
	win_chance = 0.5;
} else {
	win_chance = 0.15;
	win_favorable = -1;
}

if (win_chance > random(1)) {
	with (other_pokemon) {
		if (has_shine()) {
			change_shines(1, ShineChangeType.Get).final_action = choose_shine;
		} else {
			change_coins(10, CoinChangeType.Gain).final_action = board_advance;
		}
	}
	
	if (focused_player().network_id == global.player_id && win_favorable == -1) {
		achieve_trophy(74);
	}
} else {
	change_coins(-10, CoinChangeType.Lose).final_action = board_advance;
	
	if (focused_player().network_id == global.player_id && win_favorable == 1) {
		achieve_trophy(73);
	}
}

instance_destroy();