if (global.config_displayInput)
{
	var guiSize =
	{
		width: display_get_gui_width(),
		height: display_get_gui_height()
	};
	
	display_set_gui_size(GAME_WIDTH, GAME_HEIGHT);
	
	var inputDisplayX = 267 - 34;
	var inputDisplayY = 200 - 9
	
	var colorAlpha = 1;
	var colorInputDown = c_white;
	var colorInputJust = c_white;
	var colorInputUp = c_black;
	
	var inputArray =
	[ 
		global.InputHandler.up,
		global.InputHandler.down,
		global.InputHandler.left,
		global.InputHandler.right,
		undefined, // select
		undefined, // start
		global.InputHandler.menu,
		global.InputHandler.attack
	];
	
	draw_set_alpha(colorAlpha);
	
	draw_set_color(c_white);
	draw_sprite_ext(spr_inputDisplay, 0, inputDisplayX, inputDisplayY, 1, 1, 0, draw_get_color(), draw_get_alpha());
	
	draw_set_color(colorInputUp);
	draw_sprite_ext(spr_inputDisplay, 1, inputDisplayX, inputDisplayY, 1, 1, 0, draw_get_color(), draw_get_alpha());
	
	for (var inputItr = 0; inputItr < array_length(inputArray); inputItr++)
	{
		var inputKey = inputArray[inputItr];
		if (is_undefined(inputKey))
		{
			draw_sprite_ext(spr_inputDisplay, inputItr + 2, inputDisplayX, inputDisplayY, 1, 1, 0, colorInputUp, draw_get_alpha());
			continue;
		}
		
		var colorInput = colorInputUp;
		if (inputKey.check() || inputKey.released())
			colorInput = colorInputJust;
		else if (inputKey.down())
			colorInput = colorInputDown;
		
		draw_set_color(colorInput);
		draw_sprite_ext(spr_inputDisplay, inputItr + 2, inputDisplayX, inputDisplayY, 1, 1, 0, draw_get_color(), draw_get_alpha());
		
		draw_set_color(c_white);
		draw_text(2, 2 + (inputItr * 12), "");
	}
	
	display_set_gui_size(guiSize.width, guiSize.height);
	
	draw_reset();
}

if (global.config_displayFPS)
{
	var fpsText = $"fps: {fps}\n";
	draw_set_alpha(1);

	draw_set_color(c_black);
	draw_rectangle(0, 0, string_width(fpsText) + 2, string_height(fpsText) + 2, false);
	
	draw_set_color(c_white);
	draw_text(0, 0, fpsText);
	
	draw_reset();
}