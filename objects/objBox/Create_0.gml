focus_player = focused_player();
network_id = focus_player.network_id;
focus_player.can_jump = true;
depth = -9000;
image_xscale = 0;
image_yscale = 0;
sequence = layer_sequence_create("Assets", x, y, seqBoxes);
sequence_instance_override_object(layer_sequence_get_instance(sequence), objBox, id);

function box_activate() {}