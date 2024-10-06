event_inherited();
width = 400;
height = 180;
stock = [
	{
		text: "{SPRITE,sprCoin,0,0,0,0.7,0.7} ", name: language_get_text("WORD_GENERIC_COINS"), desc: language_get_text("PARTY_BOARD_BLACKHOLE_COINS_DESCRIPTION"), price: global.min_blackhole_coins, can_select: function() {
			for (var i = 1; i <= global.player_max; i++) {
				if (i == global.player_turn) {
					continue;
				}
			
				if (player_info_by_turn(i).coins > 0) {
					return true;
				}
			}
		
			return false;
		}()
	},
	
	{
		text: "{SPRITE,sprShine,0,-6,-5,0.5,0.5}", name: language_get_text("WORD_GENERIC_SHINE"), desc: language_get_text("PARTY_BOARD_BLACKHOLE_SHINE_DESCRIPTION"), price: global.max_blackhole_coins, can_select: function() {
			for (var i = 1; i <= global.player_max; i++) {
				if (i == global.player_turn) {
					continue;
				}
			
				if (player_info_by_turn(i).shines > 0) {
					return true;
				}
			}
		
			return false;
		}()
	}
];

option_selected = -1;
option_previous = 0;
item_selected = -1;
selecting = true;
player_info = player_info_by_turn();
offset_target = 1;
offset_pos = 0;
offset_y = -454;

function blackhole_end() {
	offset_target = 0;
	
	if (is_local_turn()) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.EndBlackhole);
		network_send_tcp_packet();
	}
}

if (is_local_turn()) {
	buffer_seek_begin();
	buffer_write_action(ClientTCP.ShowBlackhole);
	network_send_tcp_packet();
}

with (objDialogue) {
	active = false;
	endable = false;
}