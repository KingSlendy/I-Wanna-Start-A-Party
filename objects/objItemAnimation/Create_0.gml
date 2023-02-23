event_inherited();
depth = -9001;
type = -1;
sprite = null;
additional = noone;
current_player = null;
final_action = null;
timer = 1;
end_map();

function create_effect(part_sprite, part_color)  {
	instance_create_depth(current_player.x, current_player.bbox_bottom, depth - 1, objItemApplyEffect, {
		particle_sprite: part_sprite,
		image_blend: part_color
	});
}