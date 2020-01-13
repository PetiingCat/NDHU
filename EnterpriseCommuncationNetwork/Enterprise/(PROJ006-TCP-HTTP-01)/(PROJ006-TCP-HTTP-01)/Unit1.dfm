object Form1: TForm1
  Left = 162
  Top = 126
  Width = 365
  Height = 415
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
    Left = -8
    Top = 16
    Width = 89
    Height = 105
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 80
    Top = 0
    Width = 265
    Height = 369
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 24
    ParentFont = False
    ScrollWidth = 200
    TabOrder = 1
  end
  object TCPC: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 0
    Host = '127.0.0.1'
    Port = 90
    Left = 80
    Top = 56
  end
end
