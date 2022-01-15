global.skin_sprites = [
	"Normal",
	"Crimson",
	"Tribute",
	"Justice"
];

global.skin_current = 0;

function get_skin(type = global.skin_current) {
	var skin = {};
	var poses = ["Idle", "Run", "Jump", "Fall"];
	
	for (var i = 0; i < array_length(poses); i++) {
		skin[$ poses[i]] = asset_get_index("spr" + global.skin_sprites[type] + "Player" + poses[i]);
	}
	
	return skin;
}

function get_skin_pose_object(object, pose) {
	if (object == null) {
		return sprNothing;
	}
	
	if (instance_exists(object)) {
		return get_skin_pose(object.sprite_index, pose);
	}
	
	return sprNothing;
}

function get_skin_pose(sprite, pose) {
	var name = sprite_get_name(sprite);
	var check = "";
	
	for (var i = 4; i <= string_length(name); i++) {
		check += string_char_at(name, i);
		
		if (array_contains(global.skin_sprites, check)) {
			return asset_get_index("spr" + check + "Player" + pose);
		}
	}
	
	return sprNothing;
}