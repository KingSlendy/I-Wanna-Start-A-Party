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

if ((self_pokemon.power_type == other_pokemon.power_type && irandom(1) == 0) || win_types[$ self_pokemon.power_type] == other_pokemon.power_type) {
	with (other_pokemon) {
		if (place_meeting(x, y - 32, objShine)) {
			change_shines(1, ShineChangeType.Get).final_action = choose_shine;
		} else {
			change_coins(10, CoinChangeType.Gain).final_action = board_advance;
		}
	}
} else {
	change_coins(-10, CoinChangeType.Lose).final_action = board_advance;
}

instance_destroy();