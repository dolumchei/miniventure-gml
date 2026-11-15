global.Sound = new singleton_Sound(undefined, true);

global.InputHandler = new singleton_InputHandler();
global.Color = new singleton_Color();
global.Font = new singleton_Font();
global.ToolType = new singleton_ToolType(undefined, undefined, true);

global.Tile = new singleton_Tile(undefined, true);
global.Resource = new singleton_Resource(undefined, undefined, undefined, true);
global.singleton_LevelGen = new LevelGen(undefined, undefined, undefined, true);

global.Tile.singleton_postInit();

global.Crafting = new singleton_Crafting();

global.u_PaletteColor = 
[
	shader_get_uniform(shd_palette, "u_paletteColor1"),
	shader_get_uniform(shd_palette, "u_paletteColor2"),
	shader_get_uniform(shd_palette, "u_paletteColor3"),
	shader_get_uniform(shd_palette, "u_paletteColor4")
];

global.u_DitherSize = shader_get_uniform(shd_dither, "u_ditherSize");
global.u_DitherOffset = shader_get_uniform(shd_dither, "u_ditherOffset");

global.u_LightCenter = shader_get_uniform(shd_light, "u_lightCenter");
global.u_LightRadius = shader_get_uniform(shd_light, "u_lightRadius");

instance_create_layer(0, 0, layer_get_id("lyr_instances"), obj_gameHandler);