if (final_action != null) {
	final_action();
}

//This resets which spaces/pokemons have been shines prior.
if (room != rBoardPallet) {
	with (objSpaces) {
		if (space_shine) {
			space_was_shine = false;
		}
	}
} else {
	with (objBoardPalletPokemon) {
		pokemon_was_shine = false;
	}
}