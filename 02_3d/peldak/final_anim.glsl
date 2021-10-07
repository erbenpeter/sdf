// folyt.

/*
float sdCapsule( vec3 p, vec2 a, vec2 b ) { }
float map(vec3 p) { }
float rayMarch(vec3 ro, vec3 rd) { }
mat3 camera(vec3 lookAt, vec3 ro) { }
vec3 calcNormal(vec3 pos) { }
vec3 phong(float d, vec3 ro, vec3 rd) { }
*/


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{  
  // rotating camera
  vec2 uv = (2.0 * fragCoord - iResolution.xy)/iResolution.y;
  float ang = -iTime;
  vec3 ro = vec3(0.0 + 1.5 * sin(ang), 1.3, 1.5 * cos(ang));
  vec3 lookAt = vec3(0.);
  float focD = 0.9;
  vec3 rd = camera(lookAt, ro) * normalize(vec3(uv, -focD));
    
  // raymarch  
  float d = rayMarch(ro, rd);
  vec3 col;
  if ( d >= 100. ) {
    col = vec3(0.05, 0.05, 0.4)*(2. - uv.y);
  } else {
    col = phong(d, ro, rd);  
  }
  fragColor = vec4(col, 1.0);
}
