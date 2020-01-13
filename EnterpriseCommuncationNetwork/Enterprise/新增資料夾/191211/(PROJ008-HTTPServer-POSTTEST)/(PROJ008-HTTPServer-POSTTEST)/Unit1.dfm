object Form1: TForm1
  Left = 581
  Top = 123
  Width = 951
  Height = 447
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
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 522
    Height = 344
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 16
    ParentFont = False
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 521
    Top = 0
    Width = 272
    Height = 339
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object TCPS: TIdTCPServer
    Active = True
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 7000
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnExecute = TCPSExecute
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Left = 16
    Top = 16
  end
end
