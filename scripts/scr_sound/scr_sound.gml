function singleton_Sound(name, __singleton = false) constructor
{
	if (__singleton)
	{
		playerHurt = new singleton_Sound(sfx_playerhurt);
		playerDeath = new singleton_Sound(sfx_death);
		monsterHurt = new singleton_Sound(sfx_monsterhurt);
		test = new singleton_Sound(sfx_test);
		pickup = new singleton_Sound(sfx_pickup);
		bossdeath = new singleton_Sound(sfx_bossdeath);
		craft = new singleton_Sound(sfx_craft);		
	}
	else
		clip = name;
		
	play = function()
	{
		audio_play_sound(clip, 0, false, audio_sound_get_gain(clip));
	}
}