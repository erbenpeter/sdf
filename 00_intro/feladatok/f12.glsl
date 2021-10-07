const float N = 7.;
const float r = 0.8;      // circum circle's radius
const float PI = 3.14159;

bool inNgon(vec2 pos)
{
  float ang = 2.0 * PI / N;
  for (float i = 0.0; i < N; i++)
  {
    vec2 a = r * vec2(cos(i * ang), sin(i * ang));
    vec2 b = r * vec2(cos((i + 1.0) * ang), sin((i + 1.0) * ang));
    vec2 f = 0.5 * (a + b);
    vec2 n = -f;
    vec2 p = pos - f;
    if ( dot(p, n) < 0.0 )
    {
      return false;
    }
  }
  return true;
}

vec3 color(bool inner)
{
  return inner ? vec3(0.) : vec3(.95);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
  vec3 color = color(inNgon(uv));
  fragColor = vec4(color, 1.0);
}
