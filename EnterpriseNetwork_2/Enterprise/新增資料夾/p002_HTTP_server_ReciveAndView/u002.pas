unit u002;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, StdCtrls;

type
  TForm1 = class(TForm)
    TCPS: TIdTCPServer;
    ListBox1: TListBox;
    Memo1: TMemo;
    ListBox2: TListBox;
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
var s:string; k,sz:integer; ms:Tmemorystream;
begin
  sz:=-1;
     repeat
        s:=AThread.Connection.ReadLn();
        listbox1.Items.Add(s);
        k:=pos('Content-Length:',s);
        listbox1.Items.Add('*k.pos='+inttostr(k));
        if k>0 then
        begin
          sz:=strtoint(copy(s,16,1000));
          listbox1.Items.Add('sz='+inttostr(sz));
        end;
     until s='';

     if sz>0 then
     begin
        ms:=Tmemorystream.Create;
        Athread.Connection.ReadStream(ms,sz);
        ms.Position:=0;
        setlength(s,sz);ms.Read(s[1],sz);
        //caption:=s;
        memo1.Text:=s;
        listbox2.Items.Add(s);
        ms.Free;
     end;

     Athread.Connection.Disconnect;
     Athread.Terminate;
end;

end.
