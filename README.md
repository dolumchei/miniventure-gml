# miniventure-gml
Minicraft port to Gamemaker based on [shylor/miniventure](https://github.com/shylor/miniventure).

### main-objects (this branch)
porting every class to a respective object and replacing things with gamemaker builtins
### main 
the base port

---

## Added features / Todo
#### Features
- Everything has been ported, with minor bugs still needing to be found/fixed
#### Todo
- Port every class over to a respective object
- Optimization, it runs fine on my computer but ive noticed other lower-end laptops run slow

---

### Notes
- Nothing was AI generated, all port code was done by myself
- Rendering system has been changed, as drawing pixel per pixel is slow. It now uses shaders and draw_sprite_part()

## Credits
- [github.com/shylor/miniventure](https://github.com/shylor/miniventure) (minicraft source used to port)
- [github.com/Phyyl/miniventure-sharp](https://github.com/Phyyl/miniventure-sharp) (inspiration to port, also based the random implementation off of their Random.cs)
- [gmshaders.com](https://gmshaders.com) (useful info on creating shaders)
- Markus Persson (made minicraft for ludum dare 22)
