float sdRect(vec2 p, vec2 hsize)
{
  vec2 dv = abs(p) - hsize;
  return length(max(dv, 0.0)) + min(max(dv.x, dv.y), 0.0);
}

float sdCircle(vec2 p, float r)
{
  return length(p) - r;
}

float map(vec2 pos)
{
  float d1 = sdRect(pos, vec2(0.4));
  float d2 = sdCircle(pos - vec2(0.4), 0.85);
  return max(d1, d2);
}

vec3 lines(float d)
{
  float a = pow(cos(d * 60.) * .5 + .5, 10.)*.8 + .2;
  vec3 c = mix(vec3(.8, .5,0.), vec3(.3, .3, .9), sign(d) * .5 + .5) * a;
  return mix(c, vec3(.8, .8, 1.), 1. / (abs(d) * 100. + 1.));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2. * fragCoord - iResolution.xy) / iResolution.y;
  float dist = map(uv);
  vec3 col = lines(dist);
  fragColor = vec4(col,1.0);
}
