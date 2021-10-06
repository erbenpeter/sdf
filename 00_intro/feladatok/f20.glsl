const float hsize = 0.3;
const int STEPS = 4;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (2.0 * fragCoord - iResolution.xy) / iResolution.y;
  for (int i = 0; i < STEPS; i++)
  {
    if (abs(uv.x) <= 3.0 * hsize && abs(uv.y) <= 3.0 * hsize)
    {
      // indeces in {-1, 0, 1}
      float si = floor((uv.x + 3.0 * hsize) / (2.0 * hsize)) - 1.0;
      float sj = floor((uv.y + 3.0 * hsize) / (2.0 * hsize)) - 1.0;
      if ( si != 0.0 || sj != 0.0 )
      {
        uv.x -= si * 2.0 * hsize;
        uv.y -= sj * 2.0 * hsize;
        uv *= 3.0;
      }
    }
  }
  vec3 col = vec3(abs(uv.x)<= hsize && abs(uv.y)<= hsize ? 0.0 : 1.0);
  fragColor = vec4(col,1.0);
}
