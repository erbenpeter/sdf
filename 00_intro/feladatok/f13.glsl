const float N = 12.;
const float sr = 0.4;
const float l = 0.25;
const float PI = 3.14159;

bool inSun(vec2 pos)
{
  float r = length(pos);
  float alpha = atan(pos.y, pos.x);
  float h = sr + l * pow(0.5 + 0.5 * cos(N * alpha), 6.0); 
  return r <= h;
}

vec3 color(bool inner)
{
  return inner ? vec3(0.) : vec3(.95);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
  vec3 color = color(inSun(uv));
  fragColor = vec4(color, 1.0);
}
