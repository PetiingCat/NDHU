unit u001;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPServer, FileCtrl;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    FLB: TFileListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListBox2: TListBox;
    TCPS: TIdTCPServer;
    procedure TCPSExecute(AThread: TIdPeerThread);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1; path:string;

implementation

{$R *.dfm}

procedure TForm1.TCPSExecute(AThread: TIdPeerThread);
var s,fname,msg:string; i,k,f,cl:integer; ms:TMemorystream;
begin
    cl:=-1;
    {Receive HTTP GET/POST package}
    {!--viewEvent--}listbox1.Items.Add('{---Receive HTTP GET/POST package---}');
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

    {HTTP Message Judgement}
      {!--viewEvent--}listbox1.Items.Add('{---HTTP_Message---}');
      {!--viewEvent--}listbox1.Items.Add(msg);
      {!--viewEvent--}listbox1.Items.Add('{---End HTTP_Message---}');
      if pos('/?',msg)<1 then begin fname:=copy(msg,2,length(msg));end//(!assume?)If HTTP_msg is either Hyperlink_Path or variable.
      else begin msg:='Exception'; end;

    {Server_FileSend/User_DownloadFile}
    if fname<>'' then
    begin
    {!--viewEvent--}listbox1.Items.Add('{---Server_FileSend/User_DownloadFile---}');
      ms:=Tmemorystream.Create;
      f:=0;
      if fname='/favicon.ico' then
      begin f:=1;ms.LoadFromFile('C:\Users\user\Desktop\EP_EXProject\FileServer\HTML\webicon.png');end//If bowser require web's icon
      else
      begin
        i:=0;
        repeat
          if fname=FLB.Items[i] then begin f:=1;break; end;
          i:=i+1;
        until i=FLB.Count;
        if f=1 then
        begin ms.LoadFromFile('C:\Users\user\Desktop\EP_EXProject\FileServer\FileFolder\'+fname);end
        else msg:='Exception';
      end;
      if f=1 then
      begin
      ms.Position:=0;
      AThread.Connection.WriteLn('HTTP 200 OK');
      AThread.Connection.WriteLn('Content-Length: '+inttostr(ms.Size));
      AThread.Connection.WriteLn('');
      AThread.Connection.WriteStream(ms);//File have to send by type of stream
      ms.Free;
      end;
    end;

    {Server_FileReceive&Save/User_UploadFile}
    if cl>0 then
    begin
    {!--viewEvent--}listbox1.Items.Add('{---Server_FileReceive&Save/User_UploadFile---}');
        fname:='';
        repeat
            s:=AThread.Connection.ReadLn();//(!assume?)when user upload File HTTP will send 2 packages
            {!--view(s)--}listbox1.Items.Add(s);
            cl:=cl-length(s)-2;//FileSize=cl-EverySingleLineOf(s)-2(10LF&13CR)
            k:=pos('filename="',s);//find position of 'filename=" in s
            if k>0 then
            begin s:=copy(s,k+10,1000);k:=pos('"',s);fname:=copy(s,1,k-1);end;//Save the FileName
        until s='';
        ms:=TMemoryStream.Create;
        AThread.Connection.ReadStream(ms,cl);
        ms.Position:=0;
        ms.SaveToFile('C:\Users\user\Desktop\EP_EXProject\FileServer\FileFolder\'+fname);
        ms.Free;
    end;

    {EchoToBrowser:GetFolderList, MakeHTMLTable, ShowHTMLToBrowser}
    if (msg='')or(msg='/')or(msg='Exception') then
    begin
    {!--viewEvent--}listbox1.Items.Add('{---EchoToBrowser---}');
    FLB.Update;
    s:='<html><center><table border=1 width=40%>';
    for i:=0 to FLB.Count-1 do
    begin
        s:=s+'<tr><th><a href="http://127.0.0.1:7000/'+FLB.Items[i]+'">'+FLB.Items[i]+'</a></th></tr>';
    end;
    s:=s+'</center></table></html>';
    AThread.Connection.WriteLn('HTTP 200 OK');//('HTTP/1.1 200 OK');
    AThread.Connection.WriteLn( 'Content-Length: '+ inttostr(length(s)+2) );
    AThread.Connection.WriteLn( '' );
    AThread.Connection.WriteLn( s );

    AThread.Connection.Disconnect;
    AThread.Terminate;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     {SetDataBasePath}
     path:='C:\Users\user\Desktop\EP_EXProject\FileServer\FileFolder\';
     FLB.Directory:=path;
end;

end.

