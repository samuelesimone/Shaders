vec3 palette( float t ) {
     vec3 a = vec3(0.5,0.5,0.5);
     vec3 b = vec3(0.5,0.5,0.5);
     vec3 c = vec3(-3.142, 1.000, 1.000);
     vec3 d = vec3(-2.022, 0.618, 0.667);
     return a + b * cos(6.28318 * (c * t + d));

}

mat2 rotationMatrix(float angle)
{
	angle *= 3.14 / 180.0;
    float s=sin(angle), c=cos(angle);
    return mat2( c, -s, s, c );
}

#define UV_ORIGIN 0.5
#define ZOOM 1.0
#define SPEED 10.0

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord * 2.0 - iResolution.xy) / iResolution.y;
    vec2 nextColor = uv*rotationMatrix( SPEED * iTime ) * ZOOM;;
    
    vec3 finalColor = vec3(0.0);
    
    for (float i = 0.0; i < 4.0; i++) {
        uv = fract(uv * 1.3) - 0.5;

        float d = length(uv) * exp(-length(nextColor)*sin(iTime)*1.3);
        nextColor =nextColor *i ;
        vec3 col = palette(length(nextColor) + i * .8 - iTime*.4);

        d = sin(d*8. - iTime)/8.;
        d = abs(d)*.8;
        d = pow(0.01 / d, 2.2);

        finalColor += col * d;
    }
        
    fragColor = vec4(finalColor, 1.0);
}