object Form1: TForm1
  Left = 105
  Top = 134
  Width = 529
  Height = 548
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 16
    Width = 105
    Height = 49
    Caption = 'Connect'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 144
    Top = 16
    Width = 321
    Height = 305
    ItemHeight = 13
    TabOrder = 1
  end
  object Button2: TButton
    Left = 16
    Top = 120
    Width = 105
    Height = 49
    Caption = 'Connect'
    TabOrder = 2
    OnClick = Button2Click
  end
  object TCPC: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 0
    Host = '127.0.0.1'
    Port = 8000
    Left = 32
    Top = 72
  end
end
