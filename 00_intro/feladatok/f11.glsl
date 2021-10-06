const float SQRT3 = 1.732;

bool inTri(vec2 pos)
{
  bool o1 = pos.y >= 0.0;
  bool o2 = pos.y <= SQRT3 * pos.x;
  bool o3 = pos.y <= SQRT3 * (1.0 - pos.x);
  return o1 && o2 && o3;
}

vec3 color(bool inner)
{
  return inner ? vec3(0.) : vec3(.95);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
  vec3 color = color(inTri(uv));
  fragColor = vec4(color, 1.0);
}
