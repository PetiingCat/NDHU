unit U001;
(*get file*)
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, StdCtrls, IdIPWatch;

type
  TForm1 = class(TForm)
    TCPS: TIdTCPServer;
    ListBox1: TListBox;
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
var s,fname: string; k:integer; ms:Tmemorystream;
begin
  repeat
        s:=AThread.Connection.ReadLn();
        //listbox1.Items.Add(Athread.Connection.Socket.Binding.PeerIP);
        listbox1.Items.Add(s);
        k:=pos('GET ',s);
        if k=1 then
        begin
           s:=copy(s,5,10000);
           k:=pos(' HTTP',s);
           fname:=copy(s,1,k-1);
           caption:=fname;
        end
  until s='';

  if fname<>'' then
  begin
     ms:=Tmemorystream.Create;
     if fname='/favicon.ico' then
     begin ms.LoadFromFile('D:\(TEST)\(FTP)\A.jpg');end
     else
     begin ms.LoadFromFile('D:\(TEST)\(FTP)\'+copy(fname,2,10000));end;
     ms.Position:=0;
     AThread.Connection.WriteLn('HTTP 200 OK');
     AThread.Connection.WriteLn('Content-Length: '+inttostr(ms.Size));
     AThread.Connection.WriteLn('');
     AThread.Connection.WriteStream(ms);

  end;
  AThread.Connection.Disconnect;
end;

end.
