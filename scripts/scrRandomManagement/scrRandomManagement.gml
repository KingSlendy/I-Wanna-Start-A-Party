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
