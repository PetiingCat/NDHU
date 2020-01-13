object Form1: TForm1
  Left = 228
  Top = 138
  Width = 1305
  Height = 674
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 11
  object Button1: TButton
    Left = 47
    Top = 54
    Width = 123
    Height = 103
    Caption = 'Send'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 190
    Top = 88
    Width = 332
    Height = 19
    TabOrder = 1
  end
  object ListBox1: TListBox
    Left = 68
    Top = 176
    Width = 468
    Height = 339
    ItemHeight = 11
    TabOrder = 2
  end
  object Edit2: TEdit
    Left = 54
    Top = 14
    Width = 576
    Height = 19
    TabOrder = 3
  end
  object UDPS: TIdUDPServer
    Active = True
    Bindings = <>
    DefaultPort = 3333
    OnUDPRead = UDPSUDPRead
    Left = 704
    Top = 120
  end
  object UDPC: TIdUDPClient
    Active = True
    Host = '134.208.62.211'
    Port = 3333
    Left = 656
    Top = 120
  end
  object IdIPWatch1: TIdIPWatch
    Active = False
    HistoryEnabled = False
    HistoryFilename = 'iphist.dat'
    Left = 744
    Top = 120
  end
end
