global.config_displayInput = true;
global.config_displayTiming = false;
global.config_debugKeys = GM_build_type == "run";

#macro WIDTH 267
#macro HEIGHT 200

randomize();

screen = undefined;
lightScreen = undefined;

input = global.InputHandler;

colors = array_create(257, 0);
tickCount = 0;
gameTime = 0;

level = undefined;

levels = undefined;

currentLevel = 3;
player = undefined;

menu = undefined;
playerDeadTime = 0;
pendingLevelChange = 0;
wonTimer = 0;
hasWon = false;

won = function()
{
	wonTimer = 60 * 3;
	hasWon = true;
}

setMenu = function(menu)
{
	self.menu = menu;
	if (menu != undefined)
		menu.init(self, input)
}

resetGame = function()
{
	playerDeadTime = 0;
	wonTimer = 0;
	gameTime = 0;
	hasWon = false;

	levels = array_create(5, undefined);
	currentLevel = 3;
	
	levels[4] = new Level(128, 128, 1, undefined);
	levels[3] = new Level(128, 128, 0, levels[4]);
	levels[2] = new Level(128, 128, -1, levels[3]);
	levels[1] = new Level(128, 128, -2, levels[2]);
	levels[0] = new Level(128, 128, -3, levels[1]);
	
	level = levels[currentLevel];
	player = new Player(self, input);
	player.findStartPos(level);
	
	level.add(player);
	
	for (var i = 0; i < 5; i++)
		levels[i].trySpawn(5000);
}

init = function()
{
	try 
	{
		screen = new Screen(WIDTH, HEIGHT, new SpriteSheet(spr_icons));
		lightScreen = new Screen(WIDTH, HEIGHT, new SpriteSheet(spr_icons));
	}
	catch (e) 
	{ print(e.longMessage); }
	
	setMenu(new TitleMenu());
}

run = function()
{
	init();
}

scheduleLevelChange = function(dir)
{
	pendingLevelChange = dir;
}

tick = function()
{
	tickCount++;
	if (!window_has_focus())
		input.releaseAll();	
	else
	{
		if (!is_undefined(player))
		{
			if (!player.removed && !hasWon)
				gameTime++;
		}
		
		input.update();
		
		if (!is_undefined(menu))
			menu.tick();
		else
		{
			if (!is_undefined(player))
			{
				if (player.removed)
				{
					playerDeadTime++;
					if (playerDeadTime > 60)
						setMenu(new DeadMenu());
				}
				else
				{
					if (pendingLevelChange != 0)
					{
						setMenu(new LevelTransitionMenu(pendingLevelChange));
						pendingLevelChange = 0;
					}
				}
			}
			
			if (wonTimer > 0)
			{
				if (--wonTimer == 0)
					setMenu(new WonMenu());
			}
			
			if (!is_undefined(level))
				level.tick();
			global.Tile.singleton_tick();
		}
	}
}

changeLevel = function(dir)
{
	level.remove(player);
	currentLevel += dir;
	level = levels[currentLevel];
	player.x = (player.x >> 4) * 16 + 8;
	player.y = (player.y >> 4) * 16 + 8;
	level.add(player);
}

render = function()
{	
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
			var col = global.Color.get(20, 20, 121, 121);
			for (var yy = 0; yy < 14 * 2; yy++)
			{
				for (var xx = 0; xx < 24 * 2; xx++)
					screen.render(xx * 8 - ((xScroll / 4) & 7), yy * 8 - ((yScroll / 4) & 7), 0, col, 0);
			}
		}
	
		level.renderBackground(screen, xScroll, yScroll);
		level.renderSprites(screen, xScroll, yScroll);
	
		if (currentLevel < 3)
		{
			lightScreen.clear(0);
			level.renderLight(lightScreen, xScroll, yScroll);
			screen.overlay(lightScreen, xScroll, yScroll);
		}
	}

	renderGui();
	
	if (!window_has_focus())
		renderFocusRequester();
}

renderGui = function()
{
	for (var py = 0; py < 2; py++)
	{
		for (var px = 0; px < 20; px++) 
			screen.render(px * 8, screen.h - 16 + py * 8, 0 + 12 * 32, global.Color.get(000, 000, 000, 000), 0);
	}

	if (player != undefined)
	{
		for (var i = 0; i < 10; i++)
		{
			if (i < player.healthValue)
				screen.render(i * 8, screen.h - 16, 0 + 12 * 32, global.Color.get(000, 200, 500, 533), 0);
			else
				screen.render(i * 8, screen.h - 16, 0 + 12 * 32, global.Color.get(000, 100, 000, 000), 0);

			if (player.staminaRechargeDelay > 0)
			{
				if (player.staminaRechargeDelay / 4 % 2 <= 1)
					screen.render(i * 8, screen.h - 8, 1 + 12 * 32, global.Color.get(000, 555, 000, 000), 0);
				else
					screen.render(i * 8, screen.h - 8, 1 + 12 * 32, global.Color.get(000, 110, 000, 000), 0);
			}
			else
			{
				if (i < player.stamina)
					screen.render(i * 8, screen.h - 8, 1 + 12 * 32, global.Color.get(000, 220, 550, 553), 0);
				else
					screen.render(i * 8, screen.h - 8, 1 + 12 * 32, global.Color.get(000, 110, 000, 000), 0);
			}
		}
		if (player.activeItem != undefined)
			player.activeItem.renderInventory(screen, 10 * 8, screen.h - 16);
	}

	if (menu != undefined)
		menu.render(screen);
}

renderFocusRequester = function()
{
	if (is_undefined(level))
		return;
	
	var msg = "Click to focus!";
	var xx = (WIDTH - string_length(msg) * 8) / 2;
	var yy = (HEIGHT - 8) / 2;
	var w = string_length(msg);
	var h = 1;

	screen.render(xx - 8, yy - 8, 0 + 13 * 32, global.Color.get(-1, 1, 5, 445), 0);
	screen.render(xx + w * 8, yy - 8, 0 + 13 * 32, global.Color.get(-1, 1, 5, 445), 1);
	screen.render(xx - 8, yy + 8, 0 + 13 * 32, global.Color.get(-1, 1, 5, 445), 2);
	screen.render(xx + w * 8, yy + 8, 0 + 13 * 32, global.Color.get(-1, 1, 5, 445), 3);
	for (var xp = 0; xp < w; xp++)
	{
		screen.render(xx + xp * 8, yy - 8, 1 + 13 * 32, global.Color.get(-1, 1, 5, 445), 0);
		screen.render(xx + xp * 8, yy + 8, 1 + 13 * 32, global.Color.get(-1, 1, 5, 445), 2);
	}
	for (var yp = 0; yp < h; yp++)
	{
		screen.render(xx - 8, yy + yp * 8, 2 + 13 * 32, global.Color.get(-1, 1, 5, 445), 0);
		screen.render(xx + w * 8, yy + yp * 8, 2 + 13 * 32, global.Color.get(-1, 1, 5, 445), 1);
	}

	if ((tickCount / 20) % 2 <= 1)
		global.Font.draw(msg, screen, xx, yy, global.Color.get(5, 333, 333, 333));
	else
		global.Font.draw(msg, screen, xx, yy, global.Color.get(5, 555, 555, 555));
}

run();

gpu_set_sprite_cull(true);