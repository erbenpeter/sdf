float sdSegment(in vec2 p, in vec2 a, in vec2 b)
{
  vec2 v = normalize(b - a);
  float l = clamp(dot(v, p-a), 0.0, length(b-a));
  return length(p - a - l * v);
}

float map(vec2 pos)
{
  float d = sdSegment(pos, vec2(-1., -0.3), vec2(-1., 0.3));
  d = min(d, sdSegment(pos, vec2(-1., 0.3), vec2(-0.7, 0.0)));
  d = min(d, sdSegment(pos, vec2(-0.7, 0.0), vec2(-0.4, 0.3)));
  d = min(d, sdSegment(pos, vec2(-0.4, 0.3), vec2(-0.4, -0.3)));
  d = min(d, sdSegment(pos, vec2(-0.3, -0.3), vec2(0., 0.3)));
  d = min(d, sdSegment(pos, vec2(0., 0.3), vec2(0.3, -0.3)));
  d = min(d, sdSegment(pos, vec2(0.4, 0.3), vec2(1., 0.3)));
  d = min(d, sdSegment(pos, vec2(0.7, 0.3), vec2(0.7, -0.3)));
  return d;
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
