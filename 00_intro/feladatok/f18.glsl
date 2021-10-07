bool inCircle(vec2 pos, vec2 o)
{
  return length(pos - o) <= .2;
}

vec3 color(bool inner)
{
  return inner ? vec3(0.) : vec3(.95);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2.0 * fragCoord - iResolution.xy) / iResolution.y * 2.;
  float ox = mod(iTime, 6.28) - 3.14;
  float oy = sin(ox);
  vec3 color = color(inCircle(uv, vec2(ox, oy)));
  fragColor = vec4(color, 1.0);
}
