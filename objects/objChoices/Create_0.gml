image_alpha = 0;
alpha_target = 1;

choice_selected = -1;
choice_texts = [
	"Dice",
	"Item",
	"Map"
];

function can_choose() {
	var choosing = (!instance_exists(objDice) && !instance_exists(objMapLook));
	alpha_target = choosing;
	return choosing;
}