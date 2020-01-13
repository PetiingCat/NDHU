unit p001;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdUDPClient, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPServer,IdSocketHandle, IdIPWatch;

type
  TForm1 = class(TForm)
    UDPS: TIdUDPServer;
    UDPC: TIdUDPClient;
    Button1: TButton;
    Edit1: TEdit;
    ListBox1: TListBox;
    Edit2: TEdit;
    IdIPWatch1: TIdIPWatch;
    procedure Button1Click(Sender: TObject);
    procedure UDPSUDPRead(Sender: TObject; AData: TStream;
      ABinding: TIdSocketHandle);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
    Listbox1.Items.Add(IdIPWatch1.LocalIP+'(Me): '+Edit2.Text);
    UDPC.send(Edit2.Text);
    Edit2.Text :='';
end;

procedure TForm1.UDPSUDPRead(Sender: TObject; AData: TStream;
  ABinding: TIdSocketHandle);

var s:string; k: integer;
begin
    UDPC.Active:=false;
    UDPC.Host := edit1.Text;
    UDPC.Active:=true;

     k:=AData.Size;
     setlength(s,k);
     AData.Read(s[1],k);

     Listbox1.Items.Add('['+ABinding.PeerIP+']: '+s);

end;

end.
