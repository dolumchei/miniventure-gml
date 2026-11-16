function Sound(name) constructor
{
	static playerHurt = new Sound(sfx_playerhurt);
	static playerDeath = new Sound(sfx_death);
	static monsterHurt = new Sound(sfx_monsterhurt);
	static test = new Sound(sfx_test);
	static pickup = new Sound(sfx_pickup);
	static bossdeath = new Sound(sfx_bossdeath);
	static craft = new Sound(sfx_craft);		
	
	clip = name;
		
	play = function()
	{
		audio_play_sound(clip, 0, false, audio_sound_get_gain(clip));
	}
}