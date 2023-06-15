vec3 palette(float t)
{

    vec3 a = vec3(0.5,0.5,0.5);
    vec3 b = vec3(0.5,0.5,0.5);
    vec3 c = vec3(1,1,1);
    vec3 d = vec3(0.263,0.416,0.557);
    
    return a + b * cos(6.28318 * (c * t + d));

}

float sdCircle( in vec2 p, in float r ) 
{
    return length(p)-r;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 p = (2.0*fragCoord-iResolution.xy)/iResolution.y;

	float d = sdCircle(sin(p),0.5 * iTime/8.);
    
	// coloring
  
        p = fract(p * 1.5) - 0.5;
        vec3 col = (d>0.0) ? vec3(0.9,0.6,0.3) : vec3(0.65,0.85,1.0);
        col *= 1.0 - palette(exp(-6.0*length(d * iTime/8.)));
        col *= 1.0 - palette(exp(-6.0*abs(d) + iTime/8. ));
        col *= 0.8 + 0.2*sin(150.0 * d +  iTime/8.);
        col = mix( col, vec3(1.0), 1.0-smoothstep(0.0,0.01,abs(d)) );
        fragColor = vec4(col,1.0);
    
}