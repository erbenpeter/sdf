const float R = 0.2;
const float hd = 0.25;

float c(vec2 pos)
{
  return length(pos) - R;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2. * fragCoord - iResolution.xy)/iResolution.y;
  if ( abs(uv.x) <= 5. * hd && abs(uv.y) <= 3. * hd )
  {
    uv = mod( uv + hd, 2. * hd) - hd;
  }
  
  vec3 col = vec3(step(0., c(uv)));
  fragColor = vec4(col,1.0);
}
