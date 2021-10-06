bool innerPoint(vec2 p, vec2 o, float r)
{
  return length(p - o) <= r;
}

float f(float t)
{
  float x = fract(t);
  return x * (1. - x) * 6. - 1.;
}
  
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2. * fragCoord - iResolution.xy) / iResolution.y;
  vec2 center = vec2(0.0, f(iTime));
  vec3 col = vec3(innerPoint(uv, center, 0.2) ? 0. : 1.);
  fragColor = vec4(col,1.);
}
