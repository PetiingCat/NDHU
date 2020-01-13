unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, IdIPWatch, IdUDPServer,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,IdSocketHandle;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    Panel4: TPanel;
    tb1: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Button2: TButton;
    Button3: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    ListBox1: TListBox;
    Edit2: TEdit;
    Button1: TButton;
    Button4: TButton;
    Button5: TButton;
    Label3: TLabel;
    Button6: TButton;
    UDPC: TIdUDPClient;
    UDPS: TIdUDPServer;
    IdIPWatch1: TIdIPWatch;
    cd1: TColorDialog;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure UDPSUDPRead(Sender: TObject; AData: TStream;
      ABinding: TIdSocketHandle);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tb1Change(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1; bm: TBitmap; pw:integer=1; clr:integer=$000000;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
    Listbox1.Items.Add('['+IdIPWatch1.LocalIP+'(Me)]->[Edit1.Text]: '+Edit2.Text);
    UDPC.Active:=false;
    UDPC.Host:=Edit1.Text;
    UDPC.Active:=true;
    UDPC.send('MS'+Edit2.Text);
    Edit2.Text :='';
end;

procedure TForm1.UDPSUDPRead(Sender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);
var s,z,p1,p2:string; k:integer;
begin
     k:=AData.Size;
     setlength(s,k);
     AData.Read(s[1],k);
     z:=copy(s,1,2);
     s:=copy(s,3,length(s));

  if z='MT' then
  begin
     k:=pos(',',s);
     p1:=copy(s,1,k-1); p2:=copy(s,k+1,length(s));
     bm.Canvas.MoveTo( strtoint(p1),strtoint(p2));
  end
  else if (z='ML')or(z='mL') then
  begin
     k:=pos(',',s);
     p1:=copy(s,1,k-1); p2:=copy(s,k+1,length(s));

     if z ='mL' then begin bm.Canvas.Pen.Color:=$ffffff; end
     else begin bm.Canvas.Pen.Color:=clr; end;
     bm.Canvas.LineTo( strtoint(p1),strtoint(p2));
  end
  else if z='MR' then
  begin
      bm.Canvas.Pen.Color:=strtoint(s);
      clr:=strtoint(s);
  end
  else if z='MW' then
  begin
      bm.Canvas.Pen.Width:=strtoint(s);
  end
  else if z='MC' then
  begin
      bm.Canvas.Brush.Color:=$ffffff;
      bm.Canvas.Pen.Color:=$ffffff;
      bm.Canvas.Rectangle(0,0,bm.Width,bm.Height);
  end
  else if z='AP' then
  begin
    bm.Canvas.Brush.Color:=clr;
    //bm.Canvas.Pen.Color:=$ffffff;
    bm.Canvas.Rectangle(0,0,bm.Width,bm.Height);
  end
  else if z='MS' then
  begin
      Listbox1.Items.Add('['+ABinding.PeerIP+']: '+s);
  end;
end;

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
       else begin
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

procedure TForm1.Panel4Click(Sender: TObject);
begin
    if cd1.Execute=true then
      begin
        clr:=cd1.Color;
        panel4.Color:=clr;
        UDPC.Send('MR'+inttostr(clr));
      end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    bm.Canvas.Brush.Color:=$ffffff;
    bm.Canvas.Pen.Color:=$ffffff;
    bm.Canvas.Rectangle(0,0,bm.Width,bm.Height);
    udpc.Send('MC');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    bm.Canvas.Brush.Color:=clr;
    //bm.Canvas.Pen.Color:=$ffffff;
    bm.Canvas.Rectangle(0,0,bm.Width,bm.Height);
    udpc.Send('AP');
end;

end.
