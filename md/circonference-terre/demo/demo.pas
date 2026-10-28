
program SunHeight;
{$MODE objfpc}{$H+}

uses
{$IFDEF UNIX}
  CThreads,
{$ENDIF}
  Classes,
  SysUtils,
  Math,
  fpg_base,
  fpg_main,
  fpg_form,
  fpg_widget,
  fpg_trackbar,
  Agg2D;

{$IFDEF WINDOWS}
{$R demo.rc}
{$ENDIF}

type
  TFpgWidget1 = class(TFpgWidget)
  private
    FImage: TFpgImage;
  protected
    procedure HandlePaint; override;
  public
    constructor Create(AComp: TComponent); override;
    destructor Destroy; override;
    procedure DoAggPainting;
  end;
  
  TFpgForm1 = class(TFpgForm)
  private
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  protected
    procedure HandleKeyPress(var KeyCode: word; var ShiftState: TShiftState; var Consumed: boolean); override;
  public
    LWidget: TFpgWidget1;
    TrackBar: TfpgTrackBar;
    constructor Create(AOwner: TComponent); override;
    procedure AfterCreate; override;
    procedure OnTrackBarChange(Sender: TObject; APosition: integer);
  end;

const
  CWidgetWidth = 600;
  CWidgetHeight = CWidgetWidth;
  CWindowWidth = 800;
  CWindowHeight = CWidgetHeight;
  CEarthRadius = 400;
  CBodyHeight = 80;

var
  a_: double;

procedure TFpgWidget1.DoAggPainting;
const
{$IFDEF Unix}
  CFont = 'arial.ttf';
{$ELSE}
  CFont = 'Arial';
{$ENDIF}
var
  LAgg: TAgg2D;
  
procedure DrawStickAndShadow(angle: double);
type
  TPoint = record
    x, y: double;
  end;
{
const
  a_: double = 1.0;
}
var
  x3, y3: double;
  p1, p2, p3: TPoint;
  b_: double;
  delta: double;
  sin_, cos_: double;
begin
  SinCos(angle, sin_, cos_);
  
  p1.x := cos_ * CEarthRadius;
  p1.y := sin_ * CEarthRadius;
  p2.x := cos_ * (CEarthRadius + CBodyHeight);
  p2.y := sin_ * (CEarthRadius + CBodyHeight);

  b_ := p2.y - a_ * p2.x;
  
  x3 := CWidgetWidth;
  y3 := a_ * x3 + b_;
  
  delta := Sqr(2 * a_ * b_) - 4 * (Sqr(a_) + 1) * (Sqr(b_) - Sqr(CEarthRadius));
  
  if delta >= 0 then
  begin
    p3.x := (-2 * a_ * b_ + Sqrt(delta)) / (2 * (Sqr(a_) + 1));
    p3.y := a_ * p3.x + b_;
    {
    LAgg.ResetPath;
    LAgg.MoveTo(p1.x, p1.y);
    LAgg.LineTo(p2.x, p2.y);
    LAgg.LineTo(p3.x, p3.y);
    LAgg.ArcTo(CEarthRadius, CEarthRadius, 0, false, false, p1.x, p1.y);
    LAgg.ClosePolygon;
    LAgg.NoLine;
    LAgg.FillColor(192, 192, 192);
    LAgg.DrawPath; 
    }
    LAgg.LineColor(255, 0, 0);
    LAgg.Line(x3, y3, p3.x, p3.y);
    
    LAgg.LineColor(0, 0, 0);
    LAgg.ResetPath;
    LAgg.MoveTo(p3.x, p3.y);
    LAgg.ArcTo(CEarthRadius, CEarthRadius, 0, false, false, p1.x, p1.y);
    LAgg.DrawPath;
  end;
  
  LAgg.LineColor(0, 0, 0);
  LAgg.Line(p1.x, p1.y, p2.x, p2.y);
end;
  
begin
  LAgg := TAgg2D.Create(self);
  if LAgg.Attach(FImage, false) then
  begin
    LAgg.Scale(1, -1);
    LAgg.Translate(0, CWidgetHeight);
    LAgg.ClearAll($FF, $FF, $FF);
    
    LAgg.NoLine;
    LAgg.FillColor(192, 192, 192);
    LAgg.Arc(0, 0, CEarthRadius, CEarthRadius, PI, 2 * PI);
    
    DrawStickAndShadow(PI / 4);
    DrawStickAndShadow(PI / 4 + PI / 9);
    {
    LAgg.NoFill;
    LAgg.LineColor(192, 192, 192);
    LAgg.Arc(0, 0, CEarthRadius, CEarthRadius, 3 * PI / 2, 2 * PI); 
    }
    {
    LAgg.NoLine;
    LAgg.Font(CFont, 18);
    LAgg.TextAlignment(AGG_AlignRight, AGG_AlignBottom);
    LAgg.Text(CImgWidth div 2 - 12, CImgHeight div 2 - 12, 'AGGPas', true, 0.0, 0.0);
    }
  end;
  
  FImage.UpdateImage;
  LAgg.Free;
end;

constructor TFpgWidget1.Create(AComp: TComponent);
begin
  inherited Create(AComp);
  FImage := TFpgImage.Create;
  FImage.AllocateImage(32, CWidgetWidth, CWidgetHeight);
end;

destructor TFpgWidget1.Destroy;
begin
  FImage.Free;
  inherited Destroy;
end;

procedure TFpgWidget1.HandlePaint;
begin
  DoAggPainting;
  Canvas.DrawImage(0, 0, FImage);
end;

constructor TFpgForm1.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  a_ := 1.0;
end;

procedure TFpgForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
end;

procedure TFpgForm1.FormDestroy(Sender: TObject);
begin
end;

procedure TFpgForm1.HandleKeyPress(var KeyCode: word; var ShiftState: TShiftState; var Consumed: boolean);
begin
  if KeyCode = KeyEscape then
  begin
    Consumed := TRUE;
    Close;
  end;
  inherited HandleKeyPress(KeyCode, ShiftState, Consumed);
end;

procedure TFpgForm1.AfterCreate;
begin
  Name := 'TFpgForm1';
  WindowTitle := 'Longueurs des ombres à midi [touche Échap pour fermer]';
  
  Width := CWindowWidth;
  Height := CWindowHeight;
  WindowPosition := wpScreenCenter;
  Sizeable := FALSE;
  
  LWidget := TFpgWidget1.Create(self);
  LWidget.Width := CWidgetWidth;
  LWidget.Height := CWidgetHeight;
  
  TrackBar := TfpgTrackBar.Create(self);
  with TrackBar do
  begin
    Name := 'TrackBar';
    Left := CWidgetWidth + 8;
    Top := 8;
    Width := CWindowWidth - CWidgetWidth - 16; 
    Height := 30;
    Anchors := [anLeft,anBottom];
    OnChange := @OnTrackBarChange;
  end;
end;

procedure TFpgForm1.OnTrackBarChange(Sender: TObject; APosition: integer);
begin
  a_ := 1 - APosition / 100;
  LWidget.Invalidate;
end;

var
  frm: TFpgForm1;

begin
  fpgApplication.Initialize;
  frm := TFpgForm1.Create(nil);
  try
    frm.Show;
    fpgApplication.Run;
  finally
    frm.Free;
  end;
end.
