image_alpha = 0;
alpha_target = 1;

player_turn_info = get_player_turn_info();
choice_selected = -1;
choice_texts = [
	"Dice",
	"Item",
	"Map"
];

available_item = false;

function can_choose() {
	var choosing = (!instance_exists(objDice) && !instance_exists(objItemChange) && !instance_exists(objItem) && !instance_exists(objMapLook));
	alpha_target = choosing;
	return choosing;
}