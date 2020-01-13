unit u001;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, StdCtrls;

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
var msg,s,s1,s2,ans,fname:string; f,cl,k:integer; ms:Tmemorystream;

begin
      repeat
        s:=AThread.Connection.ReadLn();//s=HTTP_message
        {!--view(s)--}listbox1.Items.Add(s);
        k:=pos('Content-Length:',s);//find position of 'Content-Length:' in s
        if k>0 then
        begin cl:=strtoint( copy(s,16,1000) ); end;//cl=Content-Length=The size of package(all line of strings + stream of file)

        {if HTTP GET}
        f:=pos('GET ',s);//find position of 'GET' in s(complete_Singleline_GET_msg)
        if f=1 then
        begin
           s:=copy(s,5,10000);//s=Singleline_msg_after_'GET'
           f:=pos(' HTTP',s);//find position of 'HTTP' in s(ingleline_msg_after_'GET')
           msg:=copy(s,1,f-1);//HTTP_GET=>'GET / HTTP', msg='/' or '/XXX.jpg' or '/?OO=10&XX=01'
        end;
        {if HTTP POST}
    until s='';

  if fname='/favicon.ico' then
  begin f:=1;ms.LoadFromFile('C:\Users\user\Desktop\EP_EXProject\FileServer\HTML\webicon.png');end;
  
  ms:=Tmemorystream.Create;
  ms.LoadFromFile('C:\Users\user\Desktop\EP_EXProject\test_web_open_html\testhtml\p001.html');
  setlength(s2,ms.Size);
  ms.Read(s2[1],ms.Size);
  Listbox1.Items.add('OK'+s2);
  ms.Free;

  AThread.Connection.WriteLn('HTTP 200 OK');
  AThread.Connection.WriteLn('Content-Length: '+inttostr(length(s2)+2));
  AThread.Connection.WriteLn('');
  AThread.Connection.WriteLn(s2);


end;

end.
