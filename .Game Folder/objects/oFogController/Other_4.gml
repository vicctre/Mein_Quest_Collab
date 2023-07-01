
if !layer_exists("Fog1")
	exit

var conf = global.configFog
instance_create_layer(0, 0, "Fog1", oFogEffect, {alpha: conf.alpha1})
instance_create_layer(0, 0, "Fog2", oFogEffect, {alpha: conf.alpha2})
instance_create_layer(0, 0, "Fog3", oFogEffect, {alpha: conf.alpha3})
