object CompareProgressForm: TCompareProgressForm
  Left = 486
  Top = 295
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'Looking for similar images (0% complete)...'
  ClientHeight = 80
  ClientWidth = 330
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
    330
    80)
  PixelsPerInch = 96
  TextHeight = 13
  object Animate1: TAnimate
    Left = 10
    Top = 10
    Width = 80
    Height = 50
    CommonAVI = aviFindFolder
    StopFrame = 29
  end
  object BitBtn1: TBitBtn
    Left = 240
    Top = 40
    Width = 81
    Height = 31
    Anchors = [akRight, akBottom]
    TabOrder = 1
    Kind = bkCancel
  end
  object ProgressBar1: TProgressBar
    Left = 100
    Top = 10
    Width = 221
    Height = 21
    Max = 1000
    Smooth = True
    TabOrder = 2
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 120
    Top = 40
  end
end
