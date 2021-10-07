const vec3 fcol = vec3(0., .8, 0.); // green
const float PRECISION = 0.005;
const float PI = 3.14159;

float f (float x)
{
  return 0.5 - .5 * cos(x * PI);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = fragCoord/iResolution.xy;

  float v = f(uv.x);
  vec3 col = vec3(v);    
  if (abs(v-uv.y) < PRECISION)
  {
    col = mix(col, fcol, .9);
  }
  fragColor = vec4(col,1.0);
}
