object SearchProgressForm: TSearchProgressForm
  Left = 549
  Top = 481
  BorderIcons = [biMinimize, biMaximize]
  BorderStyle = bsDialog
  Caption = 'Looking for images...'
  ClientHeight = 120
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  DesignSize = (
    400
    120)
  PixelsPerInch = 96
  TextHeight = 13
  object Animate1: TAnimate
    Left = 10
    Top = 10
    Width = 80
    Height = 50
    Active = True
    CommonAVI = aviFindFolder
    StopFrame = 29
  end
  object BitBtn1: TBitBtn
    Left = 310
    Top = 80
    Width = 81
    Height = 31
    Anchors = [akRight, akBottom]
    TabOrder = 1
    Kind = bkCancel
  end
  object StaticText1: TStaticText
    Left = 100
    Top = 10
    Width = 291
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    BevelKind = bkFlat
    Caption = 'Found 0 files'
    TabOrder = 2
  end
  object StaticText2: TStaticText
    Left = 100
    Top = 30
    Width = 291
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    BevelKind = bkFlat
    Caption = 'Looked into 0 folders'
    TabOrder = 3
  end
  object StaticText3: TStaticText
    Left = 100
    Top = 50
    Width = 291
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    BevelKind = bkFlat
    Caption = 'Looking in ./'
    TabOrder = 4
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 10
    Top = 70
  end
end
