
uses
  SysUtils,
  Math,
  AggExample,
  agg_2D,
  agg_basics;

type
  TAggExample1 = class(TAggExample)
  protected
    procedure Draw(agg: Agg2D_ptr); override;
    procedure Draw1(agg: Agg2D_ptr; angle: double);
    procedure DrawAngle(agg: Agg2D_ptr; angle1, angle2: double);
    procedure DrawArc(agg: Agg2D_ptr; radius, angle1, angle2: double);
  private
    cl_earth, cl_stick, cl_ray, cl_shadow, cl_angle, cl_shade: Color;
  public
    procedure SetColors;
  end;

const
  SURFACE_WIDTH = 1600;
  SURFACE_HEIGHT = 1200;
  CENTER_X = 560;
  CENTER_Y = 640;
  EARTH_RADIUS = 480;
  STICK_HEIGHT = 60;
  ANGLE_RADIUS = 90;
  SHADE_WIDTH = 2.4;
  FIRST_ANGLE = 45;
  ANGLE_STEP = 10;
  STICK_COUNT = 3;

procedure TAggExample1.Draw(agg: Agg2D_ptr);
var
  i: integer;
begin
  agg^.translate(CENTER_X, CENTER_Y);
  agg^.lineWidth(1.2);

  agg^.clearAll(255, 255, 255);

 {agg^.noFill;}
  agg^.fillColor(cl_shadow);
  agg^.lineColor(cl_earth);
  agg^.arc(0, 0, EARTH_RADIUS, EARTH_RADIUS, 0, 2 * PI);

  for i := 0 to STICK_COUNT - 1 do
    Draw1(agg, DegToRad(FIRST_ANGLE + i * ANGLE_STEP));

  DrawAngle(agg, DegToRad(FIRST_ANGLE), DegToRad(FIRST_ANGLE + (STICK_COUNT - 1) * ANGLE_STEP));
end;

procedure TAggExample1.DrawAngle(agg: Agg2D_ptr; angle1, angle2: double);
var
  sin_, cos_: double;
begin
  agg^.lineColor(cl_angle);
  agg^.lineWidth(1.2);

  SinCos(angle1, sin_, cos_);
  agg^.line(0, 0, cos_ * EARTH_RADIUS, sin_ * EARTH_RADIUS);
  SinCos(angle2, sin_, cos_);
  agg^.line(0, 0, cos_ * EARTH_RADIUS, sin_ * EARTH_RADIUS);

  DrawArc(agg, ANGLE_RADIUS, angle1, angle2);
end;

procedure TAggExample1.DrawArc(agg: Agg2D_ptr; radius, angle1, angle2: double);
const
  ARC_STEPS = 32;
var
  sin_, cos_: double;
  k: integer;
begin
  agg^.noFill;
  agg^.resetPath;
  for k := 0 to ARC_STEPS do
  begin
    SinCos(angle1 + k * (angle2 - angle1) / ARC_STEPS, sin_, cos_);
    if k = 0 then
      agg^.moveTo(cos_ * radius, sin_ * radius)
    else
      agg^.lineTo(cos_ * radius, sin_ * radius);
  end;
  agg^.drawPath;
end;

procedure TAggExample1.Draw1(agg: Agg2D_ptr; angle: double);
type
  TPoint = record
    x, y: double;
  end;
const
  a_: double = 0.4;
var
  x3, y3: double;
  p1, p2, p3: TPoint;
  b_: double;
  delta: double;
  sin_, cos_: double;
begin
  SinCos(angle, sin_, cos_);
  
  p1.x := cos_ * EARTH_RADIUS;
  p1.y := sin_ * EARTH_RADIUS;
  p2.x := cos_ * (EARTH_RADIUS + STICK_HEIGHT);
  p2.y := sin_ * (EARTH_RADIUS + STICK_HEIGHT);

  b_ := p2.y - a_ * p2.x;
  
  x3 := SURFACE_WIDTH;
  y3 := a_ * x3 + b_;
  
  delta := Sqr(2 * a_ * b_) - 4 * (Sqr(a_) + 1) * (Sqr(b_) - Sqr(EARTH_RADIUS));
  
  if delta < 0 then
    Exit;
  
  p3.x := (-2 * a_ * b_ + Sqrt(delta)) / (2 * (Sqr(a_) + 1));
  p3.y := a_ * p3.x + b_;
  
 {agg^.resetPath;
  agg^.moveTo(p1.x, p1.y);
  agg^.lineTo(p2.x, p2.y);
  agg^.lineTo(p3.x, p3.y);
  agg^.arcTo(EARTH_RADIUS, EARTH_RADIUS, 0, false, false, p1.x, p1.y);
  agg^.closePolygon;
  agg^.noLine;
  agg^.fillColor(cl_shadow);
  agg^.drawPath;}
  
  agg^.lineColor(cl_shade);
  agg^.lineWidth(SHADE_WIDTH);
  agg^.lineCap(CapButt);
  DrawArc(agg, EARTH_RADIUS, ArcTan2(p1.y, p1.x), ArcTan2(p3.y, p3.x));
  agg^.lineWidth(1.2);

  agg^.lineColor(cl_ray);
  agg^.line(x3, y3, p3.x, p3.y);

  agg^.lineColor(cl_stick);
  agg^.line(p1.x, p1.y, p2.x, p2.y);
  
 {agg^.arc(0, 0, Width, Height, ArcTan2(p1.y, p1.x), ArcTan2(p3.y, p3.x));}
end;

procedure TAggExample1.SetColors;
begin
  cl_earth.Construct(0, 0, 0);
  cl_stick.Construct(0, 0, 0);
  cl_ray.Construct(255, 140, 0);
  cl_shadow.Construct(128, 128, 128, 32);
  cl_angle.Construct(128, 128, 128);
  cl_shade.Construct(0, 0, 0);
end;

var
  p: TAggExample1;
  
begin
  p := TAggExample1.Create(SURFACE_WIDTH, SURFACE_HEIGHT, ChangeFileExt({$I %FILE%}, '.png'));
  p.SetColors;
  p.DrawImage;
  p.SaveToPng;
  p.Free;
end.
