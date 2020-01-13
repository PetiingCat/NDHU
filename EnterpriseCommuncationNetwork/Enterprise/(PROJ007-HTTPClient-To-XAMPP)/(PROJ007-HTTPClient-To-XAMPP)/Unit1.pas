unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient;

type
  TForm1 = class(TForm)
    TCPC: TIdTCPClient;
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var s: string; ms: TMemoryStream; n: integer;
begin
    TCPC.Connect();
    if TCPC.Connected=true then
    begin
        Button1.Caption:='Connected';

        TCPC.WriteLn('GET /P0001.jpg HTTP/1.0');
        TCPC.WriteLn('');          

        repeat
            s:=TCPC.ReadLn();
            listbox1.Items.Add(s);
            if copy(s,1,15)='Content-Length:' then
            begin n:=strtoint( copy(s,16,1000) ); end;
        until s='';

        //**** Get Data ****
        ms:= TMemoryStream.Create;
        TCPC.ReadStream(ms,n);
        ms.SaveToFile('d:\12345.jpg');
        ms.Free;
        //******************

        TCPC.Disconnect;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var s: string; ms: TMemoryStream; n: integer;
begin
    TCPC.Connect();
    if TCPC.Connected=true then
    begin
        Button1.Caption:='Connected';

        TCPC.WriteLn('GET /cwm01.php?V01=34&V02=77 HTTP/1.0');
        TCPC.WriteLn('');

        repeat
            s:=TCPC.ReadLn();
            listbox1.Items.Add(s);
            if copy(s,1,15)='Content-Length:' then
            begin n:=strtoint( copy(s,16,1000) ); end;
        until s='';

        //**** Get Data ****
        form1.caption:=TCPC.ReadString(n);
        //******************

        TCPC.Disconnect;
    end;
end;


end.
