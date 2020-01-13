object Form1: TForm1
  Left = 353
  Top = 151
  Width = 935
  Height = 599
  Caption = 'ChattingRoom Maker:41053A041'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 919
    Height = 48
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 27
      Height = 31
      Caption = 'IP:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 160
      Top = 8
      Width = 99
      Height = 31
      Caption = 'PaintTool:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 38
      Top = 7
      Width = 115
      Height = 28
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '127.0.0.1'
    end
    object Panel4: TPanel
      Left = 267
      Top = 7
      Width = 35
      Height = 34
      Color = clBlack
      TabOrder = 1
      OnClick = Panel4Click
    end
    object tb1: TTrackBar
      Left = 308
      Top = 15
      Width = 163
      Height = 28
      Max = 20
      Min = 1
      Position = 1
      TabOrder = 2
      OnChange = tb1Change
    end
    object BitBtn1: TBitBtn
      Left = 800
      Top = 8
      Width = 81
      Height = 33
      Caption = 'Save'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = BitBtn1Click
      OnMouseMove = BitBtn1MouseMove
    end
    object BitBtn2: TBitBtn
      Left = 480
      Top = 8
      Width = 57
      Height = 33
      Caption = 'Clean'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = BitBtn2Click
      OnMouseMove = BitBtn2MouseMove
    end
    object BitBtn3: TBitBtn
      Left = 544
      Top = 8
      Width = 57
      Height = 33
      Caption = 'Fill'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = BitBtn3Click
      OnMouseMove = BitBtn3MouseMove
    end
    object BitBtn5: TBitBtn
      Left = 608
      Top = 8
      Width = 57
      Height = 33
      Caption = '#(Game)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnClick = BitBtn5Click
      OnMouseMove = BitBtn5MouseMove
    end
    object BitBtn6: TBitBtn
      Left = 672
      Top = 8
      Width = 57
      Height = 33
      Caption = 'O'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnClick = BitBtn6Click
      OnMouseMove = BitBtn6MouseMove
    end
    object BitBtn7: TBitBtn
      Left = 736
      Top = 8
      Width = 57
      Height = 33
      Caption = 'X'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = BitBtn7Click
      OnMouseMove = BitBtn7MouseMove
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 48
    Width = 670
    Height = 512
    Align = alClient
    TabOrder = 1
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 668
      Height = 510
      Align = alClient
      OnMouseDown = Image1MouseDown
      OnMouseMove = Image1MouseMove
    end
  end
  object Panel3: TPanel
    Left = 670
    Top = 48
    Width = 249
    Height = 512
    Align = alRight
    Caption = 'Panel3'
    TabOrder = 2
    object Panel5: TPanel
      Left = 1
      Top = 462
      Width = 247
      Height = 49
      Align = alBottom
      TabOrder = 0
      object Edit2: TEdit
        Left = 8
        Top = 8
        Width = 177
        Height = 24
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial Narrow'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'Hello :)'
      end
      object BitBtn4: TBitBtn
        Left = 192
        Top = 8
        Width = 49
        Height = 33
        Caption = 'Chat'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Arial Narrow'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = BitBtn4Click
        OnMouseMove = BitBtn4MouseMove
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 1
      Width = 247
      Height = 461
      Align = alClient
      Caption = 'Panel6'
      TabOrder = 1
      object ListBox1: TListBox
        Left = 1
        Top = 1
        Width = 245
        Height = 459
        Align = alClient
        ItemHeight = 11
        TabOrder = 0
      end
    end
  end
  object UDPC: TIdUDPClient
    Active = True
    Host = '127.0.0.1'
    Port = 5000
    Left = 632
    Top = 56
  end
  object UDPS: TIdUDPServer
    Active = True
    Bindings = <>
    DefaultPort = 5000
    OnUDPRead = UDPSUDPRead
    Left = 632
    Top = 88
  end
  object IdIPWatch1: TIdIPWatch
    Active = False
    HistoryEnabled = False
    HistoryFilename = 'iphist.dat'
    Left = 632
    Top = 120
  end
  object cd1: TColorDialog
    Left = 632
    Top = 152
  end
  object SaveDialog1: TSaveDialog
    Left = 632
    Top = 184
  end
end
