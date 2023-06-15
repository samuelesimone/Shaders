//Author @kishimisu
vec3 palette(float t)
{

    vec3 a = vec3(0.5,0.5,0.5);
    vec3 b = vec3(1.568, 0.500,0.278);
    vec3 c = vec3(2.388, 1.000, 1.000);
    vec3 d = vec3(0.000, 0.333, 0.667);

    
    return a + b * cos(6.28318 * (c * t + d));

}



void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    //vec2 uv = fragCoord/iResolution.xy;

    //Prevent the scaling 
    //uv.x *= iResolution.x / iResolution.y;
    // Shift the origin into (0,0)
    // Update the corner coordinates in order to have (1,1)
    //uv = (uv -0.5) * 2.0;
    
    //in one step
    vec2 uv = (fragCoord * 2.0 - iResolution.xy )/iResolution.y;
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);
    
    //iteration for creating multiple pattern
    for (float i = 0.0; i < 6.0; i++){
        //add space fration and obv center it like before
     uv = fract(uv * (0.5 + i / 3.)) - 0.5 ;
    
    float d = length(uv) * inversesqrt(-length(uv0));
    
    vec3 col = palette(length(uv0) + i * 0.2 + iTime * 0.4);
    
    d= sin(d * 8. + (iTime * i) / 6.)/8.;
    d = abs(d);
    //adding pow increase the contrast
    d = pow(0.01/d, 1.2);
    
    finalColor +=  col * d;
    }
    

    // Output to screen
    fragColor = vec4(finalColor,1);
}