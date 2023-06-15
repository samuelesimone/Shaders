vec3 palette1(float t)
{
     vec3 a = vec3(0.5,0.5,0.5);
     vec3 b = vec3(0.5,0.5,0.5);
     vec3 c = vec3(-3.142, 1.000, 1.000);
     vec3 d = vec3(-2.022, 0.618, 0.667);
     return a + b * cos(6.28318 * (c * t + d));
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    
    //in one step
    vec2 uv = (fragCoord * 2.0 - iResolution.xy )/iResolution.y;
    vec2 uv0 = uv;
    vec3 finalColor = vec3(0.0);
    
    //Zoom
    float zoom = 1.;
    //iteration for creating multiple pattern
    
        //add space fration and obv center it like before
   
    for(float i=0.0; i < 4.0; i++){
         uv = fract(uv * 1.5) - 0.5;
         float d = length(uv) * atanh(length(uv0)) * zoom;
         vec3 col = palette1(length(uv0)  + i * 0.5 + iTime * 0.3);

        d= sin(d * 4. + iTime)/4.;
        //d = abs(d);
        //adding pow increase the contrast
        d = pow(0.01/d, 1.2);

        finalColor +=  col * d;
    }
    

    // Output to screen
    fragColor = vec4(finalColor,1);
}