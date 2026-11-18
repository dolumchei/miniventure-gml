var configKeybind = vk_shift;
if (keyboard_check_combo(configKeybind, "I"))
	global.config_displayInput = !global.config_displayInput;
if (keyboard_check_combo(configKeybind, "T"))
	global.config_displayFPS = !global.config_displayFPS;
if (keyboard_check_combo(configKeybind, "M"))
	global.config_debugMenu = !global.config_debugMenu;
if (keyboard_check_combo(configKeybind, "F"))
	global.config_fullBright = !global.config_fullBright;
if (keyboard_check_combo(configKeybind, "D"))
	global.config_noDamage = !global.config_noDamage;
if (keyboard_check_combo(configKeybind, "S"))
	global.config_fullStamina = !global.config_fullStamina;