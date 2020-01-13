unit u001;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, IdBaseComponent, IdComponent, IdTCPServer;

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
  Form1: TForm1;path:string;

implementation

{$R *.dfm}

procedure TForm1.TCPSExecute(AThread: TIdPeerThread);
var s, fname,msg: string; i,k,f,sz: integer; ms: TMemorystream;
begin
    sz:=-1;
    repeat
        s:=AThread.Connection.ReadLn();
        listbox1.Items.Add(s);
        {UploadFile}
        k:=pos('Content-Length:',s);
        if k>0 then
        begin sz:=strtoint( copy(s,16,1000) ); end;
        {DownloadFile}
        f:=pos('GET ',s);
        if f=1 then
        begin
           s:=copy(s,5,10000);
           f:=pos(' HTTP',s);
           msg:=copy(s,1,f-1);
           caption:=msg;
           listbox1.Items.Add('{---Get Msg:'+msg+'---}');

           f:=pos('/?',msg);
           if f<1 then begin fname:=msg;end;
        end
    until s='';

    {if  then
    begin  end;}

    if (msg<>'')and(fname<>'/') then
    begin
      ms:=Tmemorystream.Create;
      if fname='/favicon.ico' then
      begin ms.LoadFromFile('C:\Users\user\Desktop\EP_EXProject\FileServer\HTML\A.jpg');end
      else
      begin ms.LoadFromFile('C:\Users\user\Desktop\EP_EXProject\FileServer\FileFolder\'+copy(fname,1,10000));end;
      ms.Position:=0;
      AThread.Connection.WriteLn('HTTP 200 OK');
      AThread.Connection.WriteLn('Content-Length: '+inttostr(ms.Size));
      AThread.Connection.WriteLn('');
      AThread.Connection.WriteStream(ms);
    end;

    listbox1.Items.Add('<*------------------------------*>');

    if sz>0 then
    begin
        fname:='';
        repeat
            s:=AThread.Connection.ReadLn();
            sz:=sz-length(s)-2;//-2=10LF,13CR
            listbox1.Items.Add(s);
            k:=pos('filename="',s);
            if k>0 then
            begin
                {listbox1.Items.Add('<*FIND*>');}
                s:=copy(s,k+10,1000); k:=pos('"',s);  fname:=copy(s,1,k-1);
            end;
        until s='';
        listbox1.Items.Add('<*Fname:*>'+fname);
        {}listbox1.Items.Add('<*sz='+inttostr(sz)+'*>');
        ms:=TMemoryStream.Create;
        AThread.Connection.ReadStream(ms,sz);
        ms.Position:=0;
        {setlength(s,sz);ms.Read(s[1],sz);listbox1.Items.Add('<*MSG'+s+'*>');}
        ms.SaveToFile('C:\Users\user\Desktop\EP_EXProject\FileServer\FileFolder\'+fname);
        ms.Free;
    end;

    if (msg='')or(msg='/') then begin
    {---GetFolder&ShowToBowser---}
    s:='';
    FLB.Update;
    s:='<html><center><table border=1 width=40%>';
    for i:=0 to FLB.Count-1 do
    begin
        s:=s+'<tr><th><a href="http://134.208.62.211:7000/'+FLB.Items[i]+'">'+FLB.Items[i]+'</a></th></tr>';
    end;
    s:=s+'</center></table></html>';
    AThread.Connection.WriteLn('HTTP 200 OK');
       //s:='<html><form method="POST" action="http://127.0.0.1:7000" enctype="multipart/form-data">File:<input type="file" id="f001" name="f001"></input><br><input type="submit"></input></form></html>';
       //AThread.Connection.WriteLn( 'HTTP/1.1 200 OK' );
    AThread.Connection.WriteLn( 'Content-Length: '+ inttostr(length(s)+2) );
    AThread.Connection.WriteLn( '' );
    AThread.Connection.WriteLn( s );

    AThread.Connection.Disconnect;
    AThread.Terminate;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     path:='C:\Users\user\Desktop\EP_EXProject\FileServer\FileFolder\';
     FLB.Directory:=path;
end;

end.
