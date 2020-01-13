unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, StdCtrls;

type
  TForm1 = class(TForm)
    TCPS: TIdTCPServer;
    ListBox1: TListBox;
    Memo1: TMemo;
    procedure TCPSExecute(AThread: TIdPeerThread);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.TCPSExecute(AThread: TIdPeerThread);
var s: string; k, sz: integer; ms: TMemorystream;
begin
    sz:=-1;
    repeat
        s:=AThread.Connection.ReadLn();
        listbox1.Items.Add(s);

        k:=pos('Content-Length:',s);
        if k>0 then
        begin sz:=strtoint( copy(s,16,1000) ); end;
    until s='';
    if sz>0 then
    begin
        ms:=TMemoryStream.Create;
        AThread.Connection.ReadStream(ms,sz);
        ms.Position:=0;
        setlength(s,sz); ms.Read( s[1],sz );
        //caption:=s;
        memo1.Text:=s;
        ms.Free;
    end;

    AThread.Connection.WriteLn( 'HTTP/1.1 200 OK' );
    AThread.Connection.WriteLn( 'Content-Length: 0' );
    AThread.Connection.WriteLn( '' );

    //AThread.Connection.Disconnect;
    //AThread.Terminate;
end;

end.
