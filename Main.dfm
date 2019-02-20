object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 
    #1057#1083#1086#1078#1077#1085#1080#1077' '#1086#1075#1088#1086#1084#1085#1099#1093' '#1095#1080#1089#1077#1083' ('#1080#1083#1080' '#1087#1088#1086#1089#1090#1086', '#1091#1095#1080#1084' '#1082#1086#1084#1087' '#1089#1095#1080#1090#1072#1090#1100' '#1089#1090#1086#1083#1073#1080#1082#1086#1084 +
    ')'
  ClientHeight = 323
  ClientWidth = 535
  Color = clBtnFace
  Constraints.MinHeight = 234
  Constraints.MinWidth = 302
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  ShowHint = True
  DesignSize = (
    535
    323)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 5
    Top = 24
    Width = 14
    Height = 13
    Caption = '+'
  end
  object Memo3: TMemo
    Left = 8
    Top = 136
    Width = 519
    Height = 180
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object ButtonSum: TButton
    Left = 291
    Top = 72
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '='
    TabOrder = 1
    OnClick = ButtonSumClick
    ExplicitLeft = 269
  end
  object Edit1: TEdit
    Left = 16
    Top = 8
    Width = 511
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    Text = '432143121156'
    OnChange = Edit1Change
    ExplicitWidth = 489
  end
  object Edit2: TEdit
    Left = 16
    Top = 35
    Width = 511
    Height = 22
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    Text = '1132148917'
    OnChange = Edit1Change
    ExplicitWidth = 489
  end
  object ButtonCheckAlg: TButton
    Left = 452
    Top = 72
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '1000 i'
    TabOrder = 4
    OnClick = ButtonCheckAlgClick
    ExplicitLeft = 430
  end
  object ButtongetRandomNums: TButton
    Left = 372
    Top = 72
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Random'
    TabOrder = 5
    OnClick = ButtongetRandomNumsClick
    ExplicitLeft = 350
  end
  object ButtonAboutMe: TButton
    Left = 9
    Top = 105
    Width = 25
    Height = 25
    Caption = '?'
    TabOrder = 6
    OnClick = ButtonAboutMeClick
  end
  object ButtonAlg: TButton
    Left = 452
    Top = 105
    Width = 75
    Height = 25
    Caption = #1040#1083#1075#1086#1088#1080#1090#1084
    TabOrder = 7
    OnClick = ButtonAlgClick
  end
  object EditRndSz: TEdit
    Left = 290
    Top = 104
    Width = 158
    Height = 27
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    Text = '10000'
  end
end
