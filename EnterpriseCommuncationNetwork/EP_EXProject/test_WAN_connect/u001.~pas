unit u001;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, FileCtrl, StdCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    FLB: TFileListBox;
    TCPS: TIdTCPServer;
    procedure FormCreate(Sender: TObject);
    procedure TCPSExecute(AThread: TIdPeerThread);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1; path:string;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
     path:='D:\(TEST)\(FTP)\';
     FLB.Directory:=path;
end;

procedure TForm1.TCPSExecute(AThread: TIdPeerThread);
var s,ans:string;i:integer;
begin
     repeat
           s:=AThread.Connection.ReadLn();
           ListBox1.Items.add(s);
     until s='';
     FLB.Refresh;
     ans:='<html><center><table border=1 width=40%>';
     for i:=0 to FLB.Count-1 do
     begin
        ans:=ans+'<tr><th><a href="http://134.208.62.211:7001/'+FLB.Items[i]+'">'+FLB.Items[i]+'</a></th></tr>';
     end;
     ans:=ans+'</center></table></html>';
     
     AThread.Connection.WriteLn('HTTP 200 OK');
     AThread.Connection.WriteLn('Content-Length: '+inttostr(length(ans)+2));
     AThread.Connection.WriteLn('');
     AThread.Connection.WriteLn(ans);
end;

end.
