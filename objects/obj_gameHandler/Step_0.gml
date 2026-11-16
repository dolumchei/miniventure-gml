tick();

if (keyboard_check_pressed(ord("M")) && global.config_debugMenu)
{
	if (is_undefined(menu) && !is_undefined(player))
		setMenu(new DebugMenu(player));
}