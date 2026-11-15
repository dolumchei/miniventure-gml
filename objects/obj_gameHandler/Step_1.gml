var configKeybind = vk_lcontrol;
if (keyboard_check_combo(configKeybind, "I"))
	global.config_displayInput = !global.config_displayInput;
if (keyboard_check_combo(configKeybind, "T"))
	global.config_displayTiming = !global.config_displayTiming;
if (keyboard_check_combo(configKeybind, "D"))
	global.config_debugKeys = !global.config_debugKeys;
if (keyboard_check_combo(configKeybind, "M"))
	global.config_debugMenu = !global.config_debugMenu;