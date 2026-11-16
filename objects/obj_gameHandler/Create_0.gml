randomize();

screen = undefined;
lightScreen = undefined;

input = new InputHandler();

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

scheduleLevelChange = function(dir)
{
	pendingLevelChange = dir;
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

scheduleLevelChange = function(dir)
{
	pendingLevelChange = dir;
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

try 
{
	screen = new Screen(GAME_WIDTH, GAME_HEIGHT, spr_icons);
	lightScreen = new Screen(GAME_WIDTH, GAME_HEIGHT, spr_icons);
}
catch (e) 
{ print(e.longMessage); }
	
setMenu(new TitleMenu());