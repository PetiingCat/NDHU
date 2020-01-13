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
var s,fname: string; k, sz: integer; ms: TMemorystream;
begin
    sz:=-1;
    repeat
        s:=AThread.Connection.ReadLn();
        listbox1.Items.Add(s);

        k:=pos('Content-Length:',s);
        if k>0 then
        begin sz:=strtoint( copy(s,16,1000) ); end;
    until s='';

    listbox1.Items.Add('----------------------------');

    if sz>0 then
    begin
        fname:='';
        repeat
           s:=AThread.Connection.ReadLn();
           sz:=sz-length(s)-2;(*-2 is delete the ascii(10-Line Feed,13-Carrage return)*)

           k:=pos('filename="',s);
           if k>0 then
           begin
              s:=copy(s,k+10,1000);
              k:=pos('"',s);
              fname:=copy(s,1,k-1);
           end;

           listbox1.Items.Add(s);
        until s='';(*HTTP use '' to be a end-check*)

        ms:=TMemoryStream.Create;
        AThread.Connection.ReadStream(ms,sz);
        ms.Position:=0;
        ms.savetofile('d:\(TEST)\(FTP)\'+fname);
        ms.Free;
    end;

    s:='<html><form method="POST" action="http://127.0.0.1:7000/postphp.php"enctype="multipart/form-data">File:<input type="file" id="f001" name="f001"></input><br><input type="submit"></input></form></html>';
    AThread.Connection.WriteLn( 'HTTP/1.1 200 OK' );
    AThread.Connection.WriteLn( 'Content-Length: '+ inttostr(length(s)+2) );
    AThread.Connection.WriteLn( '' );
    AThread.Connection.WriteLn( s );

    //AThread.Connection.Disconnect;
    //AThread.Terminate;
end;

end.
