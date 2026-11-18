draw_set_alpha(1);
draw_set_color(c_white);

// render
var player_x = 0;
var player_y = 0;
	
var level_w = 128;
var level_h = 128;
	
if (!is_undefined(player))
{
	player_x = player.x;
	player_y = player.y;
}
if (!is_undefined(level))
{
	level_w = level.w;
	level_h = level.h;
}
	
var xScroll = player_x - screen.w / 2;
var yScroll = player_y - (screen.h - 8) / 2;
if (xScroll < 16)
	xScroll = 16;
if (yScroll < 16)
	yScroll = 16;
if (xScroll > (level_w * 16 - screen.w - 16))
	xScroll = (level_w * 16 - screen.w - 16);
if (yScroll > level_h * 16 - screen.h - 16)
	yScroll = level_h * 16 - screen.h - 16;
	
if (!is_undefined(level))
{
	if (currentLevel > 3)
	{
		var col = Color.get(20, 20, 121, 121);
		for (var yy = 0; yy < 14 * 2; yy++)
		{
			for (var xx = 0; xx < 24 * 2; xx++)
				screen.render(xx * 8 - ((xScroll / 4) & 7), yy * 8 - ((yScroll / 4) & 7), 0, col, 0);
		}
	}
	
	level.renderBackground(screen, xScroll, yScroll);
	level.renderSprites(screen, xScroll, yScroll);
	
	if (currentLevel < 3 && !global.config_fullBright)
	{
		lightScreen.clear(0);
		level.renderLight(lightScreen, xScroll, yScroll);
		screen.overlay(lightScreen, xScroll, yScroll);
	}
}

// renderGui
for (var py = 0; py < 2; py++)
{
	for (var px = 0; px < 20; px++) 
		screen.render(px * 8, screen.h - 16 + py * 8, 0 + 12 * 32, Color.get(000, 000, 000, 000), 0);
}

if (player != undefined)
{
	for (var i = 0; i < 10; i++)
	{
		if (i < player.healthValue)
			screen.render(i * 8, screen.h - 16, 0 + 12 * 32, Color.get(000, 200, 500, 533), 0);
		else
			screen.render(i * 8, screen.h - 16, 0 + 12 * 32, Color.get(000, 100, 000, 000), 0);

		if (player.staminaRechargeDelay > 0)
		{
			if (player.staminaRechargeDelay / 4 % 2 <= 1)
				screen.render(i * 8, screen.h - 8, 1 + 12 * 32, Color.get(000, 555, 000, 000), 0);
			else
				screen.render(i * 8, screen.h - 8, 1 + 12 * 32, Color.get(000, 110, 000, 000), 0);
		}
		else
		{
			if (i < player.stamina)
				screen.render(i * 8, screen.h - 8, 1 + 12 * 32, Color.get(000, 220, 550, 553), 0);
			else
				screen.render(i * 8, screen.h - 8, 1 + 12 * 32, Color.get(000, 110, 000, 000), 0);
		}
	}
	if (player.activeItem != undefined)
		player.activeItem.renderInventory(screen, 10 * 8, screen.h - 16);
}

if (menu != undefined)
	menu.render(screen);
	
// renderFocusRequester
if (!window_has_focus())
{
	if (!is_undefined(level))
	{
		var msg = "Click to focus!";
		var xx = (GAME_WIDTH - string_length(msg) * 8) / 2;
		var yy = (GAME_HEIGHT - 8) / 2;
		var w = string_length(msg);
		var h = 1;

		screen.render(xx - 8, yy - 8, 0 + 13 * 32, Color.get(-1, 1, 5, 445), 0);
		screen.render(xx + w * 8, yy - 8, 0 + 13 * 32, Color.get(-1, 1, 5, 445), 1);
		screen.render(xx - 8, yy + 8, 0 + 13 * 32, Color.get(-1, 1, 5, 445), 2);
		screen.render(xx + w * 8, yy + 8, 0 + 13 * 32, Color.get(-1, 1, 5, 445), 3);
		for (var xp = 0; xp < w; xp++)
		{
			screen.render(xx + xp * 8, yy - 8, 1 + 13 * 32, Color.get(-1, 1, 5, 445), 0);
			screen.render(xx + xp * 8, yy + 8, 1 + 13 * 32, Color.get(-1, 1, 5, 445), 2);
		}
		for (var yp = 0; yp < h; yp++)
		{
			screen.render(xx - 8, yy + yp * 8, 2 + 13 * 32, Color.get(-1, 1, 5, 445), 0);
			screen.render(xx + w * 8, yy + yp * 8, 2 + 13 * 32, Color.get(-1, 1, 5, 445), 1);
		}

		if ((tickCount / 20) % 2 <= 1)
			Font.draw(msg, screen, xx, yy, Color.get(5, 333, 333, 333));
		else
			Font.draw(msg, screen, xx, yy, Color.get(5, 555, 555, 555));
	}
}

if (surface_exists(screen.surface))
	draw_surface(screen.surface, 0, 0);
