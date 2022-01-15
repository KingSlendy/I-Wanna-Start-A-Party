event_inherited();
image_alpha = 0;
alpha_target = 1;

player_turn_info = player_info_by_turn();
option_selected = -1;
choice_texts = [
	"Dice",
	"Item",
	"Map"
];

available_item = false;

function can_choose() {
	var choosing = !(
		instance_exists(objChooseShine) ||
		instance_number(objInterface) > 1
	);
	
	alpha_target = choosing;
	return choosing;
}