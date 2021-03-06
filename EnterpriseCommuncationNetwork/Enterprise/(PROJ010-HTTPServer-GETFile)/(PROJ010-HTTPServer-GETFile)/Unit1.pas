unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer;

type
  TForm1 = class(TForm)
    TCPS: TIdTCPServer;
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
var s, fname: string; k: integer; ms: TMemoryStream;
begin
    fname:='';
    repeat
        s:=AThread.Connection.ReadLn();
        k:=pos('GET ',s);
        if k=1 then
        begin
            s:=copy(s,5,10000);
            k:=pos(' HTTP',s);
            fname:=copy(s,1,k-1); caption:=fname;
        end;
    until s='';

    if fname<>'' then
    begin
       ms:=TMemoryStream.Create;
       if fname='/favicon.ico' then
       begin ms.LoadFromFile('D:\(WMCHEN)\(FTP)\p0005.jpg'); end
       else
       begin ms.LoadFromFile('D:\(WMCHEN)\(FTP)\'+copy(fname,2,1000)); end;

       ms.Position:=0;
       AThread.Connection.WriteLn('HTTP 200 OK');
       AThread.Connection.WriteLn('Content-Length: '+ inttostr(ms.size));
       AThread.Connection.WriteLn('');
       AThread.Connection.WriteStream(ms);
       ms.Free;
    end;


    //Athread.Connection.Disconnect;
end;

end.
