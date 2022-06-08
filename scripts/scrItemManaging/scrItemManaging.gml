function Item(id, name, desc, sprite, price, animation = null, stock_criteria = null, use_criteria = function() { return true; }) constructor {
	self.id = id;
	self.name = name;
	self.desc = desc;
	self.sprite = sprite;
	self.price = price;
	self.animation = animation;
	self.stock_criteria = stock_criteria;
	self.use_criteria = use_criteria;
}

enum ItemType {
	DoubleDice,
	TripleDice,
	Clock,
	Poison,
	Reverse,
	Ice,
	ItemSteal,
	Warp,
	SuperWarp,
	Cellphone,
	Blackhole,
	Mirror,
	Medal,
	ItemBag,
	Length
}

global.board_items = [
	new Item(ItemType.DoubleDice, "Double Dice", "Lets you roll two die.", sprItemDoubleDice, 10),
	new Item(ItemType.TripleDice, "Triple Dice", "Lets you roll three die.", sprItemTripleDice, 20),
	new Item(ItemType.Clock, "Clock", "Makes your dice roll slow.", sprItemClock, 20),
	new Item(ItemType.Poison, "Poison", "Dice gets only a roll from 1-3.\nCan be used on other players.", sprItemPoison, 5, objItemPoisonAnimation,, function() {
		for (var i = 1; i <= global.player_max; i++) {
			if (player_info_by_turn(i).item_effect == null) {
				return true;
			}
		}
		
		return false;
	}),
	
	new Item(ItemType.Reverse, "Reverse", "Lets you go backwards on the board.", sprItemReverse, 9),
	new Item(ItemType.Ice, "Ice", "Freezes the player you choose.", sprItemIce, 15, objItemIceAnimation,, function() {
		for (var i = 1; i <= global.player_max; i++) {
			if (player_info_by_turn(i).item_effect == null) {
				return true;
			}
		}
		
		return false;
	}),
	
	new Item(ItemType.ItemSteal, "Item Steal", "Steals a random item from the player you choose.", sprItemItemSteal, 1000),
	new Item(ItemType.Warp, "Warp", "Changes location with a random player.", sprItemWarp, 12, objItemWarpAnimation),
	new Item(ItemType.SuperWarp, "Super Warp", "Changes location with the player you choose.", sprItemSuperWarp, 25, objItemSuperWarpAnimation),
	new Item(ItemType.Cellphone, "Cellphone", "You can get an item from the shop delivered.", sprItemCellphone, 8,,, function() {
		return (player_info_by_turn().coins >= global.min_shop_coins && global.board_turn < global.max_board_turns);
	}),
	
	new Item(ItemType.Blackhole, "Blackhole", "Summons a blackhole that can steal coins or shines from other players.", sprItemBlackhole, 30, objItemBlackholeAnimation,, function() {
		var other_has_things = false;
		
		for (var i = 1; i <= global.player_max; i++) {
			if (i == global.player_turn) {
				continue;
			}
			
			var player_info = player_info_by_turn(i);
			
			if (player_info.coins > 0 || player_info.shines > 0) {
				other_has_things = true;
				break;
			}
		}
		
		return (player_info_by_turn().coins >= global.min_blackhole_coins && other_has_things);
	}),
	
	new Item(ItemType.Mirror, "Mirror", "Teleports you right next to the shine.", sprItemMirror, 30, objItemMirrorAnimation),
	new Item(ItemType.Medal, "Medal", "???.", sprItemMedal, 1000),
	new Item(ItemType.ItemBag, "Item Bag", "Fills your item slots with random items.", sprItemItemBag, 1000),
];

function get_item(id) {
	return global.board_items[id];
}
