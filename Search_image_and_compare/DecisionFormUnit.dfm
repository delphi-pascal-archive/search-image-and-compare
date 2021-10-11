object DecisionForm: TDecisionForm
  Left = 385
  Top = 233
  Width = 708
  Height = 547
  BorderIcons = [biSystemMenu]
  Caption = 'Similar images'
  Color = clBtnFace
  Constraints.MinHeight = 400
  Constraints.MinWidth = 500
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    700
    520)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 700
    Height = 371
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 0
    OnResize = Panel1Resize
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 311
      Height = 371
      Align = alLeft
      Caption = 'Image 1'
      TabOrder = 0
      object StaticText1: TStaticText
        Left = 2
        Top = 352
        Width = 307
        Height = 17
        Align = alBottom
        AutoSize = False
        BevelKind = bkFlat
        TabOrder = 0
      end
      object ScrollBox1: TScrollBox
        Left = 2
        Top = 15
        Width = 307
        Height = 337
        HorzScrollBar.Smooth = True
        HorzScrollBar.Tracking = True
        VertScrollBar.Smooth = True
        VertScrollBar.Tracking = True
        Align = alClient
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 1
        object PaintBox1: TPaintBox
          Left = 0
          Top = 0
          Width = 11
          Height = 11
          OnPaint = PaintBox1Paint
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 311
      Top = 0
      Width = 389
      Height = 371
      Align = alClient
      Caption = 'Image 2'
      TabOrder = 1
      object StaticText2: TStaticText
        Left = 2
        Top = 352
        Width = 385
        Height = 17
        Align = alBottom
        AutoSize = False
        BevelKind = bkFlat
        TabOrder = 0
      end
      object ScrollBox2: TScrollBox
        Left = 2
        Top = 15
        Width = 385
        Height = 337
        HorzScrollBar.Smooth = True
        HorzScrollBar.Tracking = True
        VertScrollBar.Smooth = True
        VertScrollBar.Tracking = True
        Align = alClient
        BevelKind = bkFlat
        BorderStyle = bsNone
        TabOrder = 1
        object PaintBox2: TPaintBox
          Left = 0
          Top = 0
          Width = 11
          Height = 11
          OnPaint = PaintBox2Paint
        end
      end
    end
  end
  object RadioGroup1: TRadioGroup
    Left = 10
    Top = 380
    Width = 681
    Height = 91
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'Select action to perform'
    Columns = 2
    Items.Strings = (
      'Delete image 1'
      'Delete smallest image'
      'Delete smallest file'
      'Delete oldest file'
      'Delete image 2'
      'Delete largest image'
      'Delete biggest file'
      'Delete newest file')
    TabOrder = 1
    OnClick = RadioGroup1Click
  end
  object CheckBox1: TCheckBox
    Left = 10
    Top = 480
    Width = 171
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Always do the selected action'
    TabOrder = 2
  end
  object BitBtn1: TBitBtn
    Left = 540
    Top = 480
    Width = 71
    Height = 31
    Anchors = [akRight, akBottom]
    Enabled = False
    TabOrder = 3
    Kind = bkOK
  end
  object BitBtn2: TBitBtn
    Left = 620
    Top = 480
    Width = 71
    Height = 31
    Anchors = [akRight, akBottom]
    TabOrder = 4
    Kind = bkCancel
  end
  object BitBtn3: TBitBtn
    Left = 460
    Top = 480
    Width = 71
    Height = 31
    Anchors = [akRight, akBottom]
    Caption = '&Skip'
    TabOrder = 5
    Kind = bkIgnore
  end
end
