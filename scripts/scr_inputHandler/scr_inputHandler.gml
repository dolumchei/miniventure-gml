function singleton_InputHandler() constructor
{
	static Key = function(keycode, keyname) constructor
	{
		var keycodeTemp = keycode;
		if (!is_array(keycodeTemp))
		{
			if (is_string(keycode))
				keycodeTemp = [ ord(keycode) ];
			else
				keycodeTemp = [ keycode ];
		}
		else
		{
			for (var keycodeItr = 0; keycodeItr < array_length(keycodeTemp); keycodeItr++)
			{
				var keycodeTempItem = keycodeTemp[keycodeItr];
				if (is_string(keycodeTempItem))
					keycodeTempItem = ord(keycodeTempItem);

				keycodeTemp[keycodeItr] = keycodeTempItem;
			}
		}
		
		keycodes = keycodeTemp;
		self.keyname = keyname ?? $"<undefined:{keycodes}>";
		
		keycodeRepeatCounter = 0;
		keycodeRepeating = false;
		
		keycodeRepeatMax = 10;
		keycodeRepeatInterval = 5;
	
		update = function()
		{
			if (down())
			{
				keycodeRepeatCounter++;
				if (keycodeRepeatCounter > 30)
					keycodeRepeating = true;	
			}
			else
				keycodeRepeatCounter = 0;	
		
			if (keycodeRepeating)
			{
				if (keycodeRepeatCounter > keycodeRepeatMax * 2)
					keycodeRepeatCounter = keycodeRepeatMax;
			}
		
			if (keycodeRepeatCounter < keycodeRepeatMax)
				keycodeRepeating = false;
		}
		
		releaseAll = function()
		{
			for (var keycodeItr = 0; keycodeItr < array_length(keycodes); keycodeItr++)
			{
				if (keyboard_check(keycodes[keycodeItr]))
					keyboard_key_release(keycodes[keycodeItr]);
			}	
		}
	
		check = function()
		{
			return pressed() || ((keycodeRepeatCounter - keycodeRepeatMax) % keycodeRepeatInterval == 0 && keycodeRepeating);
		}
	
		pressed = function() 
		{
			for (var keycodeItr = 0; keycodeItr < array_length(keycodes); keycodeItr++)
			{
				if (keyboard_check_pressed(keycodes[keycodeItr]))
					return true;
			}
			
			return false;
		}
		down = function() 
		{
			for (var keycodeItr = 0; keycodeItr < array_length(keycodes); keycodeItr++)
			{
				if (keyboard_check(keycodes[keycodeItr]))
					return true;
			}
			
			return false;
		}
		released = function() 
		{
			for (var keycodeItr = 0; keycodeItr < array_length(keycodes); keycodeItr++)
			{
				if (keyboard_check_released(keycodes[keycodeItr]))
					return true;
			}
			
			return false;
		}
	}
	
	up = new Key([ vk_numpad8, "W", vk_up ], "Up");
	down = new Key([ vk_numpad2, "S", vk_down ], "Down");
	left = new Key([ vk_numpad4, "A", vk_left ], "Left");
	right = new Key([ vk_numpad6, "D", vk_right ], "Right");
	attack = new Key([ vk_space, vk_control, vk_numpad0, vk_insert, "C" ], "Attack");
	menu = new Key([ vk_tab, vk_alt, vk_enter, "X" ], "Menu");
	
	keys = [ up, down, left, right ];
	
	static update = function()
	{
		for (var keyItr = 0; keyItr < array_length(keys); keyItr++)
			keys[keyItr].update();
	}
	static releaseAll = function()
	{
		for (var keyItr = 0; keyItr < array_length(keys); keyItr++)
			keys[keyItr].releaseAll();
	}
}