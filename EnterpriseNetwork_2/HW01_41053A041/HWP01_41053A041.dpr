program HWP01_41053A041;

uses
  Forms,
  U001 in 'U001.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
