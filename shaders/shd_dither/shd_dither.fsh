
varying vec2 v_vTexcoord;

uniform vec2 u_ditherSize;
uniform vec2 u_ditherOffset;

void main()
{
    vec4 pixel = texture2D(gm_BaseTexture, v_vTexcoord);

    if (pixel.a <= 0.0)
        discard;

    vec2 pos = floor(v_vTexcoord * u_ditherSize) + u_ditherOffset;

    int x = int(mod(pos.x, 4.0));
    int y = int(mod(pos.y, 4.0));

    int index = x + y * 4;
    float threshold = 0.0;

    if (index == 0) threshold = 0.0;
    else if (index == 1) threshold = 8.0;
    else if (index == 2) threshold = 2.0;
    else if (index == 3) threshold = 10.0;
    else if (index == 4) threshold = 12.0;
    else if (index == 5) threshold = 4.0;
    else if (index == 6) threshold = 14.0;
    else if (index == 7) threshold = 6.0;
    else if (index == 8) threshold = 3.0;
    else if (index == 9) threshold = 11.0;
    else if (index == 10) threshold = 1.0;
    else if (index == 11) threshold = 9.0;
    else if (index == 12) threshold = 15.0;
    else if (index == 13) threshold = 7.0;
    else if (index == 14) threshold = 13.0;
    else threshold = 5.0;

    float intensity = floor((pixel.r * 0.30 + pixel.g * 0.59 + pixel.b * 0.11) * 255.0 / 10.0);

    if (intensity <= threshold)
        gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    else
        discard;
}
