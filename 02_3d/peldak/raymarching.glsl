const float PRECISION = 0.001;
const float MAX_DEPTH = 100.0;

float rayMarch(vec3 ro, vec3 rd)
{
  float depth = 0.0;
  for ( int i = 0; i < 255; i++ )
  {
    float d = map(ro + depth * rd); 
    if ( d < PRECISION || depth >= MAX_DEPTH ) break;
    depth += d;
  }
  return depth;
}
