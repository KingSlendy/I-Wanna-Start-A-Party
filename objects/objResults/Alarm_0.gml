if (global.give_bonus_shines) {
	start_dialogue([
		new Message("But first we need to give the bonus shines!\nThey could change the course of the whole game!",, results_bonus)
	]);
} else {
	start_dialogue([
		new Message("Now it's finally time to reveal the winner!\nI'm so nervous...",, results_won)
	]);
	
	//If it increased a bonus round that means this option was enabled from the start
	if (bonus_round > 0) {
		global.give_bonus_shines = true;
	}
}
