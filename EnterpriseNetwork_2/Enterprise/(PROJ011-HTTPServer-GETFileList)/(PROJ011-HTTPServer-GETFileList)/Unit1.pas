unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, StdCtrls, FileCtrl;

type
  TForm1 = class(TForm)
    TCPS: TIdTCPServer;
    FLB: TFileListBox;
    procedure FormCreate(Sender: TObject);
    procedure TCPSExecute(AThread: TIdPeerThread);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1; path: string;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
    path:='D:\(WMCHEN)\(FTP)\';
    FLB.Directory:=path;
end;

procedure TForm1.TCPSExecute(AThread: TIdPeerThread);
var s, ans: string; i: integer;
begin
    repeat
        s:=AThread.Connection.ReadLn();
    until s='';

    FLB.Refresh;
    ans:='<html><center><table border=1 width=40%>';
    for i:=0 to FLB.Count-1 do
    begin
        ans:=ans+'<tr><th><a href="http://127.0.0.1:7001/'+FLB.Items[i]+'">'+
             FLB.Items[i]+'</a></th></tr>';
    end;
    ans:=ans+'</center></table></html>';

    AThread.Connection.WriteLn('HTTP 200 OK');
    AThread.Connection.WriteLn('Content-Length: '+ inttostr(length(ans)+2) );
    AThread.Connection.WriteLn('');
    AThread.Connection.WriteLn(ans);
end;

end.
