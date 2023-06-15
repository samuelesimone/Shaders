vec3 palette1(float t)
{
     vec3 a = vec3(0.5,0.5,0.5);
     vec3 b = vec3(0.5,0.5,0.5);
     vec3 c = vec3(1.0, 1.0, 1.0);
     vec3 d = vec3(0.30, 0.20, 0.20);
     return a + b * cos(6.28318 * (c * t + d));
}

const float PI = 3.14;

mat2 rotationMatrix(float angle)
{
	angle *= PI / 180.0;
    float s=sin(angle), c=cos(angle);
    return mat2( c, -s, s, c );
}
#define UV_ORIGIN 0.5
#define ZOOM 1.0
#define SPEED 10.0

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
    uv0 *= rotationMatrix( SPEED * iTime ) * ZOOM;
    //Zoom
    float zoom = 0.5;
    float speedi = 0.2;
    float speedtime = 0.1;
    //iteration for creating multiple pattern
    for (float i = 0.0; i < 4.0; i++){
        //add space fration and obv center it like before
    uv = fract(uv * 1.5) - 0.5;
    
    float d = length(uv) * log2(length(uv0));
    
    vec3 col = palette1(length(uv0) + i * (speedi*zoom) + iTime * (speedtime*zoom));
    
    d= cos(d * 8. + iTime)/8.;
    d = abs(d) * zoom;
    //adding pow increase the contrast
    d = pow(0.01/d, 1.2);
    
    finalColor +=  col * d;
    zoom+=1.;
    }
    

    // Output to screen
    fragColor = vec4(finalColor,1);
}