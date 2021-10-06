const float PRECISION = 0.001;
const float MAX_DEPTH = 100.0;

float rayMarch(vec3 ro, vec3 rd)
{
  float depth = 0.0;
  for ( int i = 0; i < 255; i++ )
  {
    vec3 pos = ro + depth * rd;
    float d = map(pos);
    depth += d;
    if ( d < PRECISION || depth >= MAX_DEPTH ) break;
  }
  return depth;
}
