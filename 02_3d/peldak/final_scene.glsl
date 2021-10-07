float sdCapsule( vec3 p, vec2 a, vec2 b )
{
  vec3 aa = vec3(a, .0), bb = vec3(b, .0);
  float r = 0.12;
  vec3 pa = p - aa, ba = bb - aa;
  float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
  return length(pa - ba * h) - r;
}

float map(vec3 p)
{
  float d = sdCapsule(p,  vec2(-1.1, -.6), vec2(-1.1, .6));
  d = min(d, sdCapsule(p, vec2(-1.1,  .6), vec2(-.7,  .3)));
  d = min(d, sdCapsule(p, vec2(-.7,   .3), vec2(-.3,  .6)));
  d = min(d, sdCapsule(p, vec2(-.3,   .6), vec2(-.3, -.6)));
  d = min(d, sdCapsule(p, vec2(.3,    .6), vec2(1.1,  .6)));
  d = min(d, sdCapsule(p, vec2(.7,    .6), vec2(.7,  -.6)));
  return d;
}

// folyt. köv.