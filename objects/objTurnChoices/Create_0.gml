event_inherited();
image_alpha = 0;
alpha_target = 1;

player_info = player_info_by_turn();
option_selected = -1;
choice_texts = [
	"Dice",
	"Item"
];

available_item = false;

function can_choose() {
	var choosing = !(
		instance_exists(objChooseShine) ||
		instance_exists(objDice) ||
		instance_number(objInterface) > 1
	);
	
	if (is_local_turn()) {
		var prev_alpha_target = alpha_target;
		alpha_target = choosing;
	
		if (prev_alpha_target != alpha_target) {
			buffer_seek_begin();
			buffer_write_action(ClientTCP.ChangeChoiceAlpha);
			buffer_write_data(buffer_u8, alpha_target);
			network_send_tcp_packet();
		}
	}
	
	return choosing;
}