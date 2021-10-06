const float PRECISION = 0.01;
const float size = 0.3;

bool inGrid(vec2 pos)
{
  pos -= vec2(size / 2.);
  bool x = abs(mod(pos.x, size) - size / 2.) < PRECISION;
  bool y = abs(mod(pos.y, size) - size / 2.) < PRECISION;
  return x || y;
}

vec3 color(bool inner)
{
  return inner ? vec3(0.) : vec3(.95);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
  vec3 color = color(inGrid(uv));
  fragColor = vec4(color, 1.0);
}
