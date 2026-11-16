var configKeybind = vk_lcontrol;
if (keyboard_check_combo(configKeybind, "I"))
	global.config_displayInput = !global.config_displayInput;
if (keyboard_check_combo(configKeybind, "T"))
	global.config_displayFPS = !global.config_displayFPS;
if (keyboard_check_combo(configKeybind, "D"))
	global.config_debugMenu = !global.config_debugMenu;