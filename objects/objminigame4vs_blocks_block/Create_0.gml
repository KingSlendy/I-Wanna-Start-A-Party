enabled = false;
active = false;

alarms_init(1);

alarm_create(function() {
	instance_destroy();
});

function block_destabilize(network = true) {
	image_blend = c_red;
	alarm_call(0, 1);
	active = true;
	
	if (network) {
		buffer_seek_begin();
		buffer_write_action(ClientTCP.Minigame4vs_Blocks_BlockDestabilize);
		buffer_write_data(buffer_s32, x);
		buffer_write_data(buffer_s32, y);
		network_send_tcp_packet();
	}
}