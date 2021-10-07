const float d = 0.5; // incircle radius
const float PI = 3.14159;

bool inTri(vec2 pos)
{
  float r = length(pos);
  float alpha = atan(pos.y, pos.x);
  float a = mod(alpha, 2.0 * PI / 3.0); // repetition
  float b = abs(a - PI / 3.0);          // symmetry
  float h = d / cos(b);
  return r <= h;
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
