varying vec2 v_vTexcoord;

uniform vec2 u_lightCenter;
uniform float u_lightRadius;

void main()
{
    vec4 source = texture2D(gm_BaseTexture, v_vTexcoord);

    vec2 pos = gl_FragCoord.xy;

    vec2 delta = pos - u_lightCenter;
    float dist = dot(delta, delta);

    float radiusSq = u_lightRadius * u_lightRadius;

    if (dist <= radiusSq)
    {
        float brightness = 1.0 - floor(dist * 255.0 / radiusSq) / 255.0;

        float current = max(source.r, max(source.g, source.b));
        float result = max(current, brightness);

        if (current > 0.0001)
            source.rgb *= result / current;
        else
            source.rgb = vec3(result);
    }

    gl_FragColor = source;
}
