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
	new Item(ItemType.DoubleDice, "Double Dice", "Lets you roll two dice.", sprItemDoubleDice, 10),
	new Item(ItemType.TripleDice, "Triple Dice", "Lets you roll three dice.", sprItemTripleDice, 20),
	new Item(ItemType.Clock, "Clock", "Makes your dice roll slow.", sprItemClock, 15),
	new Item(ItemType.Poison, "Poison", "Dice gets only a roll from 1-3.\nCan be used on other players.", sprItemPoison, 5, objItemPoisonAnimation,, function() {
		for (var i = 1; i <= global.player_max; i++) {
			if (player_info_by_turn(i).item_effect == null) {
				return true;
			}
		}
		
		return false;
	}),
	
	new Item(ItemType.Reverse, "Reverse", "Board direction is reversed with this item.\nCan be used on other players.", sprItemReverse, 9, objItemReverseAnimation,, function() {
		for (var i = 1; i <= global.player_max; i++) {
			if (player_info_by_turn(i).item_effect == null) {
				return true;
			}
		}
		
		return false;
	}, [rBoardNsanity]),
	
	new Item(ItemType.Ice, "Ice", "Completely freezes a player of your choosing.\nDisabling all actions on their turn.", sprItemIce, 12, objItemIceAnimation,, function() {
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
	new Item(ItemType.Warp, "Warp", "Changes space with a player chosen at random.", sprItemWarp, 12, objItemWarpAnimation),
	new Item(ItemType.SuperWarp, "Super Warp", "Changes space with any player of your choosing.", sprItemSuperWarp, 25, objItemSuperWarpAnimation),
	new Item(ItemType.Cellphone, "Cellphone", "You can call the shop and get an item directly from the comfort of your space.", sprItemCellphone, 8,,, function() {
		return (player_info_by_turn().coins >= global.min_shop_coins && global.board_turn < global.max_board_turns);
	}),
	
	new Item(ItemType.Blackhole, "Blackhole", "Summons the blackhole, allowing you to steal Coins or Shines from other players.", sprItemBlackhole, 30, objItemBlackholeAnimation,, function() {
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
	
	new Item(ItemType.Mirror, "Mirror", "It teleports you directly on top of the Shine space.", sprItemMirror, 30, objItemMirrorAnimation,,, [rBoardWorld]),
	//new Item(ItemType.Medal, "Medal", "???.", sprItemMedal, 1000),
	new Item(ItemType.ItemBag, "Item Bag", "Gives you 3 random items!", sprItemItemBag, 40)
];

function get_item(id) {
	return global.board_items[id];
}