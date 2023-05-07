function Item(id, name, desc, sprite, price, animation = null, stock_criteria = null, use_criteria = function() { return true; }, ignore_in = []) constructor {
	self.id = id;
	self.name = name;
	self.desc = desc;
	self.sprite = sprite;
	self.price = price;
	self.animation = animation;
	self.stock_criteria = stock_criteria;
	self.use_criteria = use_criteria;
	self.ignore_in = ignore_in;
}

enum ItemType {
	DoubleDice,
	TripleDice,
	Clock,
	Poison,
	Reverse,
	Ice,
	//ItemSteal,
	Warp,
	SuperWarp,
	Cellphone,
	Blackhole,
	Mirror,
	//Medal,
	ItemBag,
	Length
}

global.board_items = [
	new Item(ItemType.DoubleDice, language_get_text("PARTY_ITEM_DOUBLE_DICE_NAME"), language_get_text("PARTY_ITEM_DOUBLE_DICE_EFFECT"), sprItemDoubleDice, 10),
	new Item(ItemType.TripleDice, language_get_text("PARTY_ITEM_TRIPLE_DICE_NAME"), language_get_text("PARTY_ITEM_TRIPLE_DICE_EFFECT"), sprItemTripleDice, 20),
	new Item(ItemType.Clock, language_get_text("PARTY_ITEM_CLOCK_NAME"), language_get_text("PARTY_ITEM_CLOCK_NAME_EFFECT"), sprItemClock, 15),
	new Item(ItemType.Poison, language_get_text("PARTY_ITEM_POISON_NAME"), language_get_text("PARTY_ITEM_POISON_EFFECT"), sprItemPoison, 5, objItemPoisonAnimation,, function() {
		for (var i = 1; i <= global.player_max; i++) {
			if (player_info_by_turn(i).item_effect == null) {
				return true;
			}
		}
		
		return false;
	}),
	
	new Item(ItemType.Reverse, language_get_text("PARTY_ITEM_REVERSE_NAME"), language_get_text("PARTY_ITEM_REVERSE_EFFECT"), sprItemReverse, 9, objItemReverseAnimation,, function() {
		for (var i = 1; i <= global.player_max; i++) {
			if (player_info_by_turn(i).item_effect == null) {
				return true;
			}
		}
		
		return false;
	}, [rBoardNsanity]),
	
	new Item(ItemType.Ice, language_get_text("PARTY_ITEM_ICE_NAME"), language_get_text("PARTY_ITEM_ICE_EFFECT"), sprItemIce, 12, objItemIceAnimation,, function() {
		for (var i = 1; i <= global.player_max; i++) {
			if (i == global.player_turn) {
				continue;
			}
			
			if (player_info_by_turn(i).item_effect == null) {
				return true;
			}
		}
		
		return false;
	}),
	
	//new Item(ItemType.ItemSteal, "Item Steal", "Steals a random item from the player you choose.", sprItemItemSteal, 1000),
	new Item(ItemType.Warp, language_get_text("PARTY_ITEM_WARP_NAME"), language_get_text("PARTY_ITEM_WARP_EFFECT"), sprItemWarp, 12, objItemWarpAnimation),
	new Item(ItemType.SuperWarp, language_get_text("PARTY_ITEM_SUPER_WARP_NAME"), language_get_text("PARTY_ITEM_SUPER_WARP_EFFECT"), sprItemSuperWarp, 25, objItemSuperWarpAnimation),
	new Item(ItemType.Cellphone, language_get_text("PARTY_ITEM_CELLPHONE_NAME"), language_get_text("PARTY_ITEM_CELLPHONE_EFFECT"), sprItemCellphone, 8,,, function() {
		return (player_info_by_turn().coins >= global.min_shop_coins && global.board_turn < global.max_board_turns);
	}),
	
	new Item(ItemType.Blackhole, language_get_text("PARTY_ITEM_BLACKHOLE_NAME"), language_get_text("PARTY_ITEM_BLACKHOLE_EFFECT"), sprItemBlackhole, 20, objItemBlackholeAnimation,, function() {
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
	
	new Item(ItemType.Mirror, language_get_text("PARTY_ITEM_MIRROR_NAME"), language_get_text("PARTY_ITEM_MIRROR_EFFECT"), sprItemMirror, 30, objItemMirrorAnimation),
	//new Item(ItemType.Medal, "Medal", "???.", sprItemMedal, 1000),
	new Item(ItemType.ItemBag, language_get_text("PARTY_ITEM_ITEM_BAG_NAME"), language_get_text("PARTY_ITEM_ITEM_BAG_EFFECT"), sprItemItemBag, 40)
];

function get_item(id) {
	return global.board_items[id];
}