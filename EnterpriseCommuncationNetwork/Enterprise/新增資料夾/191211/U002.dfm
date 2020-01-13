object Form1: TForm1
  Left = 178
  Top = 117
  Width = 367
  Height = 592
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
  object FLB: TFileListBox
    Left = 0
    Top = 0
    Width = 351
    Height = 43
    Align = alTop
    ItemHeight = 13
    TabOrder = 0
  end
  object ListBox1: TListBox
    Left = 0
    Top = 43
    Width = 351
    Height = 510
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Century'
    Font.Style = []
    ItemHeight = 20
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
    Left = 8
    Top = 8
  end
end
