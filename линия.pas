﻿uses GraphABC;  
procedure RLine(x, y, x1, y1: real) := Line(Round(x), Round(y), Round(x1), Round(y1));
 
function GetAngle(x, y, x2, y2: real): real;
begin
  var angle := Abs(RadToDeg(ArcTan((y2 - y) / (x2 - x))));
  if (x2 = x) and (y2 = y) then
    Result := 0
  else
  if x2 > x then
    if y2 > y then Result := angle else Result := 360 - angle
    else
  if y2 > y then Result := 180 - angle else Result := 180 + angle;
end;
 
function Distance(x, y, x1, y1: real) := Sqrt(Sqr(x1 - x) + Sqr(y1 - y)); 
 
procedure Draw(x, y, x1, y1: real);
begin
  var r := Distance(x, y, x1, y1);
  
  if r < 10 then
    RLine(x, y, x1, y1)
  else
  begin
    var angle := GetAngle(x, y, x1, y1);
    var angleP := DegToRad(angle + 90);
    var angleM := DegToRad(angle - 90);
    r /= 4;
    var dx := (x1 - x) / 4;
    var dy := (y1 - y) / 4;
    
    var xA := x + dx;
    var yA := y + dy;
    var xB := xA + dx;
    var yB := yA + dy;
    var xC := xB + dx;
    var yC := yB + dy;
    
    var x2 := xA + r * Cos(angleP);
    var y2 := yA + r * Sin(angleP);
    
    var x3 := xB + r * Cos(angleP);
    var y3 := yB + r * Sin(angleP);
    
    var x4 := xB + r * Cos(angleM);
    var y4 := yB + r * Sin(angleM);
    
    var x5 := xC + r * Cos(angleM);
    var y5 := yC + r * Sin(angleM);
    
    Draw(x, y, xA, yA);
    Draw(xA, yA, x2, y2);
    Draw(x2, y2, x3, y3);
    Draw(x3, y3, xB, yB);
    Draw(xB, yB, x4, y4);
    Draw(x4, y4, x5, y5);
    Draw(x5, y5, xC, yC);
    Draw(xC, yC, x1, y1);
  end;
end;
 
var
  x, y, x1, y1, k: integer;
procedure KeyDown(key: integer);//Движ
begin
  case key of
    VK_Up:
      begin

        y1 := y1 - 10;
      end;
    VK_Down:
      begin

        y1 := y1 + 10;
      end;
    VK_Left:
      begin

        x1 := x1 - 10;
      end;
    VK_Right:
      begin

        x1 := x1 + 10;
      end;
  end;
  Window.Clear;
end;
 
procedure KeyUp(a: integer);//глубина
begin
  case a of
    VK_A:
      begin
        x:=x-100;
      end; 
    VK_D:
      begin
        x:=x+100;
      end;
  end; 
  Window.Clear;
end;
 
procedure KeyPress(i: char);//масшатаб
var s:integer;
k:=1;
begin
  case i of
    'z':
      begin
        k := k * 2;
      end;
    'x':
      begin
        k := k div 2;  
      end;
  end;
  
  for s := 1 to 5 do
  begin
    x := x * k;
    x1 := x1 * k;
    y1 := y1 * k;
    y := y * k;
  end;
end;
begin
 textout(windowwidth-610,10,'A - увеличение, D - уменьшение');
begin
  LockDrawing;
  x := 100;
  y := 200;
  x1 := 400;
  y1 := 200;
  repeat
    redraw;
    sleep(1);
    draw(x, y, x1, y1);
    onKeyDown := keydown;
    onKeyUp := keyup;
    onKeyPress:=KeyPress;
  until(false);
  end;
end.