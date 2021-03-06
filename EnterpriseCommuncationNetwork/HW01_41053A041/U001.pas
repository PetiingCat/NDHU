unit U001;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, IdIPWatch, IdUDPServer,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,IdSocketHandle,
  Buttons;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Edit1: TEdit;
    Panel4: TPanel;
    tb1: TTrackBar;
    Label1: TLabel;
    Label2: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    ListBox1: TListBox;
    Edit2: TEdit;
    UDPC: TIdUDPClient;
    UDPS: TIdUDPServer;
    IdIPWatch1: TIdIPWatch;
    cd1: TColorDialog;
    Image1: TImage;
    SaveDialog1: TSaveDialog;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    procedure UDPSUDPRead(Sender: TObject; AData: TStream;
      ABinding: TIdSocketHandle);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tb1Change(Sender: TObject);
    procedure Panel4Click(Sender: TObject);
    procedure BitBtn1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn5MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn6MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1; bm: TBitmap; pw:integer=1; clr:integer=$000000; PShape:integer=0;

implementation

{$R *.dfm}

procedure TForm1.UDPSUDPRead(Sender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);
var s,z,p1,p2,RR:string; k:integer;
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
  end
  else if z='PS' then
  begin
      Listbox1.Items.Add('***'+ABinding.PeerIP+' saved the canvas.***');
  end
  else if z='GO' then
  begin
    z:=copy(s,1,2);
    s:=copy(s,3,length(s));
    RR:=z;
    k:=pos(',',s);
    p1:=copy(s,1,k-1); p2:=copy(s,k+1,length(s));
    bm.Canvas.Ellipse(strtoint(p1)-strtoint(RR),strtoint(p2)-strtoint(RR),strtoint(p1)+strtoint(RR),strtoint(p2)+strtoint(RR));
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
if PShape=0 then
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
  end
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var RR:integer;
begin
  if (ssLeft in shift)or(ssRight in shift) then
   begin
    //listbox1.Items.Add(inttostr(x)+','+inttostr(y));
    if PShape=0 then
    begin
     bm.Canvas.MoveTo(x,y);
     UDPC.Send( 'MT'+inttostr(x)+','+inttostr(y) );
    end
    else if PShape=1 then
    begin
      pw:=tb1.Position;
      UDPC.Send('MW'+inttostr(pw));
      bm.Canvas.Pen.Color:=clred;
      UDPC.Send('MR'+inttostr(clred));
      RR:=50;
      bm.Canvas.Ellipse(x-RR,y-RR,x+RR,y+RR);
      UDPC.Send( 'GO'+inttostr(RR)+inttostr(x)+','+inttostr(y) );

      bm.Canvas.Pen.Color:=clr;
      UDPC.Send('MR'+inttostr(clr));
    end
    else if PShape=2 then
    begin
      //Line 1
      pw:=tb1.Position;
      UDPC.Send('MW'+inttostr(pw));
      bm.Canvas.Pen.Color:=clblue;
      UDPC.Send('MR'+inttostr(clblue));
      bm.Canvas.MoveTo(x-50,y-50);
      UDPC.Send( 'MT'+inttostr(x-50)+','+inttostr(y-50) );
      bm.Canvas.LineTo(x+50,y+50);
      UDPC.Send( 'ML'+inttostr(x+50)+','+inttostr(y+50) );
      //Line 2
      bm.Canvas.MoveTo(x+50,y-50);
      UDPC.Send( 'MT'+inttostr(x+50)+','+inttostr(y-50) );
      bm.Canvas.LineTo(x-50,y+50);
      UDPC.Send( 'ML'+inttostr(x-50)+','+inttostr(y+50) );

      bm.Canvas.Pen.Color:=clr;
      UDPC.Send('MR'+inttostr(clr));
    end
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

procedure TForm1.BitBtn1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
      if (x<5)or(x>Bitbtn1.Width-5)or(y<5)or(y>Bitbtn1.Height-5) then
      begin
        BitBtn1.Font.Color:=clblack;
      end
      else begin
        BitBtn1.Font.Color:=clblue;
      end
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
     if savedialog1.Execute then
     begin
      Image1.Picture.Graphic.SaveToFile(savedialog1.FileName+'.jpg');
      listbox1.Items.Add('***The canvos has been saved.***');
      UDPC.send('PS');
     end
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
    bm.Canvas.Brush.Color:=$ffffff;
    bm.Canvas.Pen.Color:=$ffffff;
    bm.Canvas.Rectangle(0,0,bm.Width,bm.Height);
    udpc.Send('MC');
end;

procedure TForm1.BitBtn2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
      if (x<5)or(x>Bitbtn2.Width-5)or(y<5)or(y>Bitbtn2.Height-5) then
      begin
        BitBtn2.Font.Color:=clblack;
      end
      else begin
        BitBtn2.Font.Color:=clred;
      end
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
    bm.Canvas.Brush.Color:=clr;
    //bm.Canvas.Pen.Color:=$ffffff;
    bm.Canvas.Rectangle(0,0,bm.Width,bm.Height);
    udpc.Send('AP');
end;

procedure TForm1.BitBtn3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
      if (x<5)or(x>Bitbtn3.Width-5)or(y<5)or(y>Bitbtn3.Height-5) then
      begin
        BitBtn3.Font.Color:=clblack;
      end
      else begin
        BitBtn3.Font.Color:=clred;
      end
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
    Listbox1.Items.Add('['+IdIPWatch1.LocalIP+'(Me)]->[Edit1.Text]: '+Edit2.Text);
    UDPC.Active:=false;
    UDPC.Host:=Edit1.Text;
    UDPC.Active:=true;
    UDPC.send('MS'+Edit2.Text);
    Edit2.Text :='';
end;

procedure TForm1.BitBtn4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
      if (x<5)or(x>Bitbtn4.Width-5)or(y<5)or(y>Bitbtn4.Height-5) then
      begin
        BitBtn4.Font.Color:=clblack;
      end
      else begin
        BitBtn4.Font.Color:=clgreen;
      end
end;

procedure TForm1.BitBtn5MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
      if (x<5)or(x>Bitbtn5.Width-5)or(y<5)or(y>Bitbtn5.Height-5) then
      begin
        BitBtn5.Font.Color:=clblack;
      end
      else begin
        BitBtn5.Font.Color:=clred;
      end
end;

procedure TForm1.BitBtn6MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if PShape <> 1 then
  begin
      if (x<5)or(x>Bitbtn6.Width-5)or(y<5)or(y>Bitbtn6.Height-5) then
      begin
        BitBtn6.Font.Color:=clblack;
      end
      else begin
        BitBtn6.Font.Color:=clred;
      end
  end
  else if PShape=1 then
  begin
    BitBtn6.Font.Color:=clred;
  end
end;

procedure TForm1.BitBtn7MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if PShape <> 2 then
  begin
      if (x<5)or(x>Bitbtn7.Width-5)or(y<5)or(y>Bitbtn7.Height-5) then
      begin
        BitBtn7.Font.Color:=clblack;
      end
      else begin
        BitBtn7.Font.Color:=clred;
      end
  end
  else if PShape=2 then
  begin
    BitBtn7.Font.Color:=clred;
  end
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
    bm.Canvas.Brush.Color:=$ffffff;
    bm.Canvas.Pen.Color:=$ffffff;
    bm.Canvas.Rectangle(0,0,bm.Width,bm.Height);
    udpc.Send('MC');
    //Line 1
    bm.Canvas.Pen.Width:=5;
    UDPC.Send('MW'+inttostr(5));
    bm.Canvas.Pen.Color:=clgreen;
    UDPC.Send('MR'+inttostr(clgreen));
    bm.Canvas.MoveTo(200,50);
    UDPC.Send( 'MT'+inttostr(200)+','+inttostr(50) );
    bm.Canvas.LineTo(200,450);
    UDPC.Send( 'ML'+inttostr(200)+','+inttostr(450) );
    //Line 2
    bm.Canvas.MoveTo(400,50);
    UDPC.Send( 'MT'+inttostr(400)+','+inttostr(50) );
        bm.Canvas.LineTo(400,450);
    UDPC.Send( 'ML'+inttostr(400)+','+inttostr(450) );
    //Line 3
    bm.Canvas.MoveTo(100,150);
    UDPC.Send( 'MT'+inttostr(100)+','+inttostr(150) );
    bm.Canvas.LineTo(500,150);
    UDPC.Send( 'ML'+inttostr(500)+','+inttostr(150) );
    //Line 4
    bm.Canvas.MoveTo(100,350);
    UDPC.Send( 'MT'+inttostr(100)+','+inttostr(350) );
    bm.Canvas.LineTo(500,350);
    UDPC.Send( 'ML'+inttostr(500)+','+inttostr(350) );
    //!!server's original pw no saved
    pw:=tb1.Position;
    UDPC.Send('MW'+inttostr(pw));
    bm.Canvas.Pen.Color:=clr;
    UDPC.Send('MR'+inttostr(clr));
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  if PShape <> 1 then
  begin
    PShape:=1;
    BitBtn7.Font.Color:=clblack;
  end
  else if PShape=1 then
  begin
    PShape:=0;
  end
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
  if PShape <> 2 then
  begin
    PShape:=2;
    BitBtn6.Font.Color:=clblack;
  end
  else if PShape=2 then
  begin
    PShape:=0;
  end
end;

end.
