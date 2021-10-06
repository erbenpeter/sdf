bool inRect(vec2 pos)
{
  pos = pos - vec2(.1, .2);
  return abs(pos.x) <= .7 && abs(pos.y) <= .4;
}

vec3 color(bool inner)
{
  return inner ? vec3(0.) : vec3(.95);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
  vec3 color = color(inRect(uv));
  fragColor = vec4(color, 1.0);
}
