function Random() constructor {
	static seed = 0;
	
	static rand = function(n) {
	    self.seed = (141592653589.2305873647 * self.seed + 793238462.987443) % n;
	    return self.seed
	}
    
	static irand = function(n) {
	    return floor(self.rand(n));
	}
    
	static range = function(n1, n2) {
	    return self.rand(n2 - n1) + n1;
	}

	static irange = function(n1, n2) {
	    return floor(self.range(n1, n2));
	}
	
	static choice = function() {
		return argument[self.irand(argument_count)];
	}
	
	static set_seed = function(seed) {
		self.seed = seed;
	}
	
	static get_seed = function() {
		return self.seed;
	}
}

global.rng_class = new Random();
#macro rng global.rng_class

function next_seed_inline() {
	var next_seed = ++global.current_seed;
	
	if (next_seed == array_length(global.seed_bag)) {
		next_seed = 0;
		global.current_seed = 0;
	}
	
	random_set_seed(global.seed_bag[next_seed]);
}

function set_seed_inline(n) {
	global.current_seed = n;
	global.current_seed %= array_length(global.seed_bag);
	random_set_seed(global.seed_bag[global.current_seed]);
}

function shuffle_seed_inline() {
	for (var i = 0; i < array_length(global.seed_bag); i++) {
		global.seed_bag[i] += 3141592;
		global.seed_bag[i] %= 9999999999;
	}
}

function reset_seed_inline() {
	global.current_seed = 0;
	random_set_seed(global.seed_bag[global.current_seed]);
}
