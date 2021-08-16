const float PI = 3.14159265359;

vec2 rotate(in vec2 position, in float angle)
{
  mat2 rotM = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
  return position * rotM;
}

vec2 transform(in vec2 position)
{
  float scaling = 2.0;
  float repeatWindow = 0.56;
  return mod(position * scaling, repeatWindow)- repeatWindow / 2.0;
}

float sdCircle(in vec2 position, in vec2 center, in float radius)
{
  return length(position - center) - radius;
}

float sdBox(in vec2 position, in vec2 size, in float angle)
{
  float corner = 0.01;
  vec2 rotPos = rotate(position, angle);
  vec2 d = abs(rotPos) - size;
  return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0) - corner;
}

float sdScene(in vec2 position, in float time)
{
   
  float doc = sdCircle(position, vec2(0.0, 0.0), 0.21);
  float dic = sdCircle(position, vec2(0.0, 0.0), 0.1);
  
  float animAngle = time;
  float db1 = sdBox(position, vec2(0.04, 0.26), animAngle + 0.0);
  float db2 = sdBox(position, vec2(0.04, 0.26), animAngle + PI / 4.0);
  float db3 = sdBox(position, vec2(0.04, 0.26), animAngle + 2.0 * PI / 4.0);
  float db4 = sdBox(position, vec2(0.04, 0.26), animAngle + 3.0 * PI / 4.0);
  
  float db = min(db1, min(db2, min(db3, db4)));
  float comp = min(doc, db);    
  float d = max(-dic, comp);
    
  return d;
}

vec4 color(in float dist)
{
  float c = clamp(300.0 * dist, 0.0, 1.0);
  return vec4(vec3(c),1.0);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = (fragCoord - iResolution.xy*0.5) / iResolution.y;
    vec2 position = transform(uv);
    float d = sdScene(position, iTime);
    fragColor = color(d);
}
