float sdRect(vec2 p, vec2 hsize)
{
  vec2 dv = abs(p) - hsize;
  return length(max(dv, 0.0)) + min(max(dv.x, dv.y), 0.0);
}

vec3 lines(float d)
{
  float a = pow(cos(d * 120.) * .5 + .5, 10.)*.8 + .2;
  vec3 c = mix(vec3(.8,.5,0.), vec3(.3,.3,.9), sign(d)*.5 + .5)*a;
  c = mix(c, vec3(.8,.8,1.), 1./(abs(d)*100.+1.));
  return c;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2. * fragCoord - iResolution.xy) / iResolution.y;
  float dist = sdRect(uv, vec2(0.8, 0.6));
  vec3 col = lines(dist);
  fragColor = vec4(col,1.0);
}
