object Form1: TForm1
  Left = 480
  Top = 163
  Width = 816
  Height = 540
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 11
  object ListBox1: TListBox
    Left = 401
    Top = 0
    Width = 399
    Height = 501
    Align = alRight
    ItemHeight = 11
    TabOrder = 0
  end
  object FLB: TFileListBox
    Left = 0
    Top = 0
    Width = 401
    Height = 501
    Align = alLeft
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MV Boli'
    Font.Style = []
    ItemHeight = 25
    ParentFont = False
    TabOrder = 1
  end
  object TCPS: TIdTCPServer
    Active = True
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 7002
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnExecute = TCPSExecute
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Left = 72
    Top = 8
  end
end
