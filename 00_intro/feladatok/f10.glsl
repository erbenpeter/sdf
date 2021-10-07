const float size = 0.2;

bool inChess(vec2 pos)
{
  pos = floor(mod(pos, vec2(2. * size)) / size);
  return pos.x + pos.y == 1.;
}

vec3 color(bool inner)
{
  return inner ? vec3(0.) : vec3(.95);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
  vec3 color = color(inChess(uv));
  fragColor = vec4(color, 1.0);
}
