unit U002;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, StdCtrls, FileCtrl;

type
  TForm1 = class(TForm)
    TCPS: TIdTCPServer;
    FLB: TFileListBox;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure TCPSExecute(AThread: TIdPeerThread);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1; path:string; cnt:integer;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
     path:='D:\(TEST)\(FTP)\';
     FLB.Directory:=path;
end;

procedure TForm1.TCPSExecute(AThread: TIdPeerThread);
var s,ans:string;i,k:integer; ms:Tmemorystream;
begin
     {flag}cnt:=cnt+1;ListBox1.Items.add('*Thread '+inttostr(cnt)+'*');
     repeat
           s:=AThread.Connection.ReadLn();
           ListBox1.Items.add(s);
     until s='';
     {Hyper Table}
     FLB.Refresh;
     {ans:='<html><center><table border=1 width=40%>';
     for i:=0 to FLB.Count-1 do
     begin
        ans:=ans+'<tr><th><a href="http://134.208.62.211:7001/'+FLB.Items[i]+'">'+FLB.Items[i]+'</a></th></tr>';
     end;
     ans:=ans+'</center></table></html>';}

     {Sent HtmlFile}
     ms:=Tmemorystream.Create;
     ms.LoadFromFile('C:\Users\user\Desktop\Enterprise\新增資料夾\191211\Bowser_Get\GetVar.html');
     k:=ms.Size;
     setlength(s,k);
     ms.Read(s[1],k);
     listbox1.Items.Add('*FILE*: '+s);

     AThread.Connection.WriteLn('HTTP/1.1 200 OK');
     AThread.Connection.WriteLn('Content-Length: '+inttostr(length(s)+2));
     AThread.Connection.WriteLn('');
     AThread.Connection.WriteLn(s);

     ms.Free;
     AThread.Connection.Disconnect;
end;

end.
