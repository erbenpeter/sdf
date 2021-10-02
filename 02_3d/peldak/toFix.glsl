float sdBox( vec3 p, vec3 b, float e)
{
  p = abs(p  )-b;
  vec3 q = abs(p+e)-e;
  return min(min(
      length(max(vec3(p.x,q.y,q.z),0.0))+min(max(p.x,max(q.y,q.z)),0.0),
      length(max(vec3(q.x,p.y,q.z),0.0))+min(max(q.x,max(p.y,q.z)),0.0)),
      length(max(vec3(q.x,q.y,p.z),0.0))+min(max(q.x,max(q.y,p.z)),0.0));
}

float map(vec3 p)
{
  return sdBox(p, vec3(0.85,0.75,0.6), 0.1) - 0.05; 
}

float rayMarch(vec3 ro, vec3 rd)
{
  float depth = 0.0;
  for ( int i = 0; i < 255; i++ )
  {
    vec3 pos = ro + depth * rd;
    float d = map(pos);
    depth += d;
    if ( d < 0.001 || depth >= 100.0 ) break;
  }
  return depth;
}

float shadow(vec3 ro, vec3 rd)
{
  float k = 32.;
  float depth = 0.0;
  float res = 1.0;
  for ( int i = 0; i < 255; i++ )
  {
    vec3 pos = ro + depth * rd;
    float d = map(pos);
    if ( d < 0.001 ) return 0.0;
    res = min( res, k*d/depth );
    depth += d;
    if ( depth >= 100.0 ) return 1.0;
  }
  return 1.0;
}



mat3 camera(vec3 lookAt, vec3 ro)
{
  vec3 cz = normalize(lookAt - ro);
  vec3 cx = normalize(cross(cz, vec3(0., 1., 0.)));
  vec3 cy = normalize(cross(cx, cz));  
  return mat3(cx, cy, cz);
}

vec3 calcNormal(vec3 pos) {
  vec2 eps = vec2(0.0005, 0.0);
  return normalize(vec3(
    map(pos+eps.xyy) - map(pos-eps.xyy),
    map(pos+eps.yxy) - map(pos-eps.yxy),
    map(pos+eps.yyx) - map(pos-eps.yyx)
  ));
}

vec3 dColor(float d, vec3 ro, vec3 rd)
{
  vec3 lightColor = vec3(.8);
  vec3 ambLightColor = vec3(.7, .7, .1);
  vec3 col = vec3(0.);
  
  vec3 pos = ro + d * rd;
  vec3 nv = calcNormal(pos);
  vec3 lightPos = vec3(5.0, 5.0, -10.0);
  vec3 lightDir = normalize(lightPos - pos);
  
  // shadow
  vec3 sro = pos + 0.01 * nv;
  vec3 srd = lightPos - sro;
  float sha = shadow(sro, srd);
  
  
  // diffuse
  col += lightColor * clamp(dot(lightDir, nv), 0., 1.) * sha;
  
  // specular (with half-vector)
  vec3 eye = normalize(ro - pos);
  vec3 h = normalize(eye + lightDir);
  col += lightColor * pow(clamp(dot(h, nv), 0., 1.), 30.) * sha;
  
  
  // ambient
  col += 0.15 * ambLightColor;
  
  // gamma correction
  return pow(col, vec3(1. / 2.2));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{  
  // Scene settings
  vec2 uv = (2.0 * fragCoord - iResolution.xy)/iResolution.y;
  float mouseX = (2.0 * iMouse.x - iResolution.x)/iResolution.y;
  float ang = 1.2 * mouseX;
  vec3 ro = vec3(0.0 + 2.5 * sin(ang), .9, -2.5 * cos(ang));
  
  //camera
  vec3 lookAt = vec3(0.);
  mat3 camMatrix = camera(lookAt, ro);
  float focD = 0.9;
  vec3 rd = camMatrix * vec3(uv, focD);
    
    
 
  float d = rayMarch(ro, rd);
  vec3 col;
  if ( d > 100.0 ) {
    col = vec3(0.05, 0.05, 0.4)*(2. - uv.y);
  } else {
    col = dColor(d, ro, rd);  
  }
  fragColor = vec4(col, 1.0);
}