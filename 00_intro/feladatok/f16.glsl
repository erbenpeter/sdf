const float PRECISION = 0.01;
const float size = 0.3;
const float PI = 3.14159;

bool inGrid(vec2 pos)
{
  if (max(abs(pos.x), abs(pos.y)) > 2. * size + PRECISION)
  {
    return false;
  }
  pos -= vec2(size / 2.);
  bool x = abs(mod(pos.x, size) - size / 2.) < PRECISION;
  bool y = abs(mod(pos.y, size) - size / 2.) < PRECISION;
  return x || y;
}

vec3 color(bool inner)
{
  return inner ? vec3(0.) : vec3(.95);
}

vec2 trA(vec2 pos, vec2 shift)
{
  return pos - shift;
}

vec2 trB(vec2 pos, float alpha)
{
  mat2 R = mat2(
    vec2(cos(alpha), -sin(alpha)),
    vec2(sin(alpha), cos(alpha))
  );
  return R * pos;
}

vec2 trC(vec2 pos, float lambda)
{
  return pos / lambda;
}

vec2 trD(vec2 pos, float r)
{
  return r * r / dot(pos, pos) * pos;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
  // uv = trA(uv, vec2(2. * size, -1. * size)); // eltolás
  // uv = trB(uv, PI / 8.); // forgatás
  // uv = trC(uv, 1.4); // nagyítás
  uv = trD(uv, 0.5); // inverzió
  vec3 color = color(inGrid(uv));
  fragColor = vec4(color, 1.0);
}
