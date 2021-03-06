unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, IdBaseComponent, IdComponent,
  IdUDPBase, IdUDPClient;

type
  TForm1 = class(TForm)
    Image1: TImage;
    CD1: TColorDialog;
    tb1: TTrackBar;
    UDPC: TIdUDPClient;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tb1Change(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1; bm: TBitmap; pw: integer=1; clr: integer=$000000;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
    bm:=image1.Picture.Bitmap;
    bm.Width:=image1.Width;
    bm.Height:=image1.Height;
    bm.PixelFormat:=pf24bit;
end;

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
   if (ssLeft in shift) or(ssRight in shift)  then
   begin
      bm.Canvas.Pen.Width:=pw;
      if ssLeft in shift then
      begin
      bm.Canvas.Pen.Color:=clr;
      UDPC.Send( 'ML'+inttostr(x)+','+inttostr(y) );
      end
      else
      begin
      bm.Canvas.Pen.Color:=$ffffff;
      UDPC.Send( 'mL'+inttostr(x)+','+inttostr(y) );
      end;
      bm.Canvas.LineTo(x,y);

   end;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    if (ssLeft in shift)or(ssRight in shift) then
    begin
        bm.Canvas.MoveTo(x,y);

        UDPC.Send( 'MT'+inttostr(x)+','+inttostr(y) );
    end;
end;

procedure TForm1.tb1Change(Sender: TObject);
begin
    pw:=tb1.Position;
    UDPC.Send('MW'+inttostr(pw));
end;

procedure TForm1.Panel1Click(Sender: TObject);
begin
    if cd1.Execute=true then
    begin
        clr:=cd1.Color;
        panel1.Color:=clr;
        UDPC.Send('MR'+inttostr(clr));
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    bm.Canvas.Brush.Color:=$ffffff;
    bm.Canvas.Pen.Color:=$ffffff;
    bm.Canvas.Rectangle(0,0,bm.Width,bm.Height);
    udpc.Send('MC');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    bm.Canvas.Brush.Color:=clr;
    //bm.Canvas.Pen.Color:=$ffffff;
    bm.Canvas.Rectangle(0,0,bm.Width,bm.Height);
    udpc.Send('AP');
end;

procedur
