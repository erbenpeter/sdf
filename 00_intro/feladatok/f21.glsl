const int STEPS = 5;
const float SQRT3 = 1.732;

bool innerSmall(vec2 pos)
{
  bool f1 = pos.y <= SQRT3 / 4.0;
  bool f2 = pos.y >= -SQRT3 / 2.0 + pos.x * SQRT3;
  bool f3 = pos.y >=  SQRT3 / 2.0 - pos.x * SQRT3;
  return f1 && f2 && f3;
}

bool inner(vec2 pos)
{
  bool f1 = pos.y >= 0.0;
  bool f2 = pos.y <= pos.x * SQRT3;
  bool f3 = pos.y <= SQRT3 - pos.x * SQRT3;
  return f1 && f2 && f3;
}

float tri(vec2 pos)
{
  return innerSmall(pos) ? 0.0 : 1.0;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = fragCoord/iResolution.y; // origó bal alul
  vec2 pos = uv;
  // Rekurzio
  for (int i = 0; i < STEPS; i++)
  {
    if (inner(pos))
    {
      if (!innerSmall(pos))
      {
        // upper triangle
        if (pos.y > SQRT3 / 4.0)
        {
          pos -= vec2(0.25, SQRT3 / 4.0);
        }
        // right triangle
        else if ( pos.y <= -SQRT3 / 2.0 + pos.x * SQRT3)
        {
          pos -= vec2(0.5, 0.0);
        }
        pos *= 2.0;
      }
    }
  }    
  vec3 col = vec3(tri(pos));
  fragColor = vec4(col,1.0);
}
