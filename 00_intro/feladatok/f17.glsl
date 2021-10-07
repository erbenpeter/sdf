const float size = 0.2;

bool inChess(vec2 pos)
{
  if (max(abs(pos.x), abs(pos.y)) > 4. * size)
  {
    return false;
  }
  pos = floor(mod(pos, vec2(2. * size)) / size);
  return pos.x + pos.y == 1.;
}

vec3 color(bool inner)
{
  return inner ? vec3(0.) : vec3(.95);
}

vec2 rot(vec2 pos, float alpha)
{
  mat2 R = mat2(
    vec2(cos(alpha), -sin(alpha)),
    vec2(sin(alpha), cos(alpha))
  );
  return R * pos;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
  uv = rot(uv, iTime * 0.2);
  vec3 color = color(inChess(uv));
  fragColor = vec4(color, 1.0);
}
