
if !layer_exists("Fog1")
	exit


var conf = global.configFog

// override config by level

		
switch room {
	// all  "case" rooms will be affected...
	//case W1_2_part1:
	case W1_2_part2: 
	case W1_2_part3:
	case W1_2_part4_AutoScroller1:
	case W1_2_part5_AutoScroller2:
	case W1_2_part6_END:
	// ... by this config
		conf = {
			alpha1: 0.1,
			alpha2: 0.15,
			alpha3: 0.15,
			color: #f2c672 //#e3b357//#f2e094 //#f2ec94 //#bb5828 
			//these are here just to test different colors 
		}
		break
	
	// you can also add new room sets like this:
	/*
	case W1_3_part4_AutoScroller1:
	case W1_3_part5_AutoScroller2:
	case W1_3_part6_END:
		conf = {
			alpha1: 0.1,
			alpha2: 0.15,
			alpha3: 0.15,
			color: #94C8F2,
		}
		break
	*/
}

instance_create_layer(0, 0, "Fog1", oFogEffect, {color: conf.color, alpha: conf.alpha1})
instance_create_layer(0, 0, "Fog2", oFogEffect, {color: conf.color, alpha: conf.alpha2})
instance_create_layer(0, 0, "Fog3", oFogEffect, {color: conf.color, alpha: conf.alpha3})
