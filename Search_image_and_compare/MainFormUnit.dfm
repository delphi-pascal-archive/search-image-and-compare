object MainForm: TMainForm
  Left = 213
  Top = 121
  Width = 738
  Height = 576
  Caption = 'Search image and compare'
  Color = clBtnFace
  Constraints.MinHeight = 500
  Constraints.MinWidth = 600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    722
    538)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 7
    Top = 7
    Width = 709
    Height = 85
    Anchors = [akLeft, akTop, akRight]
    Caption = ' Folder to inspect '
    TabOrder = 0
    DesignSize = (
      709
      85)
    object SpeedButton1: TSpeedButton
      Left = 519
      Top = 20
      Width = 40
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '...'
      Transparent = False
      OnClick = SpeedButton1Click
    end
    object Edit1: TEdit
      Left = 10
      Top = 20
      Width = 510
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      BevelKind = bkFlat
      BorderStyle = bsNone
      ParentColor = True
      ReadOnly = True
      TabOrder = 0
    end
    object CheckBox1: TCheckBox
      Left = 10
      Top = 50
      Width = 121
      Height = 17
      Caption = 'Include sub-folders'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object BitBtn1: TBitBtn
      Left = 569
      Top = 20
      Width = 61
      Height = 51
      Anchors = [akTop, akRight]
      Caption = 'Search'
      TabOrder = 2
      OnClick = BitBtn1Click
      Kind = bkRetry
      Layout = blGlyphBottom
    end
    object BitBtn2: TBitBtn
      Left = 639
      Top = 20
      Width = 61
      Height = 51
      Anchors = [akTop, akRight]
      Caption = 'Compare'
      Enabled = False
      TabOrder = 3
      OnClick = BitBtn2Click
      Kind = bkAll
      Layout = blGlyphBottom
    end
    object Panel1: TPanel
      Left = 140
      Top = 50
      Width = 420
      Height = 21
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvLowered
      Caption = '  Max similarity value: 90%'
      TabOrder = 4
      object TrackBar1: TTrackBar
        Left = 137
        Top = 1
        Width = 282
        Height = 19
        Align = alRight
        Anchors = [akLeft, akTop, akRight, akBottom]
        Max = 1000
        Position = 900
        TabOrder = 0
        ThumbLength = 15
        TickMarks = tmBoth
        TickStyle = tsNone
        OnChange = TrackBar1Change
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 7
    Top = 98
    Width = 709
    Height = 434
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = ' 0 graphic files '
    TabOrder = 1
    object ListView1: TListView
      Left = 2
      Top = 41
      Width = 705
      Height = 391
      Align = alClient
      BevelKind = bkFlat
      BorderStyle = bsNone
      Columns = <
        item
          AutoSize = True
          Caption = 'Name'
        end
        item
          Caption = 'Dimensions'
          Width = 90
        end
        item
          Caption = 'File size'
          Width = 100
        end
        item
          Caption = 'Date'
          Width = 150
        end>
      GridLines = True
      LargeImages = ImageList2
      ReadOnly = True
      RowSelect = True
      ShowWorkAreas = True
      SmallImages = ImageList1
      TabOrder = 0
      ViewStyle = vsReport
      OnColumnClick = ListView1ColumnClick
      OnCompare = ListView1Compare
    end
    object ToolBar1: TToolBar
      Left = 2
      Top = 15
      Width = 705
      Height = 26
      AutoSize = True
      BorderWidth = 1
      ButtonWidth = 46
      Caption = 'ToolBar1'
      EdgeBorders = []
      Flat = True
      Images = ImageList3
      List = True
      ShowCaptions = True
      TabOrder = 1
      DesignSize = (
        701
        22)
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        AutoSize = True
        DropdownMenu = PopupMenu1
        ImageIndex = 0
        Style = tbsDropDown
      end
      object ToolButton2: TToolButton
        Left = 49
        Top = 0
        AutoSize = True
        Caption = 'Sort'
        DropdownMenu = PopupMenu2
        Style = tbsDropDown
      end
      object ToolButton3: TToolButton
        Left = 94
        Top = 0
        Width = 20
        Caption = 'ToolButton3'
        ImageIndex = 0
        Style = tbsSeparator
      end
      object Panel2: TPanel
        Left = 114
        Top = 0
        Width = 110
        Height = 22
        BevelOuter = bvNone
        Caption = 'On file deletion:'
        TabOrder = 1
      end
      object ComboBox1: TComboBox
        Left = 224
        Top = 0
        Width = 169
        Height = 23
        BevelKind = bkFlat
        Style = csOwnerDrawFixed
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 17
        ItemIndex = 0
        TabOrder = 0
        Text = 'Move to recycle bin'
        OnDrawItem = ComboBox1DrawItem
        Items.Strings = (
          'Move to recycle bin'
          'Permanent delete')
      end
      object ToolButton4: TToolButton
        Left = 393
        Top = 0
        Width = 20
        Caption = 'ToolButton4'
        ImageIndex = 1
        Style = tbsSeparator
      end
      object Panel3: TPanel
        Left = 413
        Top = 0
        Width = 155
        Height = 22
        BevelOuter = bvNone
        Caption = 'Comparison accuracy'
        TabOrder = 2
      end
      object ComboBox2: TComboBox
        Left = 568
        Top = 0
        Width = 124
        Height = 21
        BevelKind = bkFlat
        Style = csDropDownList
        ItemHeight = 13
        ItemIndex = 1
        TabOrder = 3
        Text = 'Average'
        OnChange = ComboBox2Change
        Items.Strings = (
          'Low'
          'Average'
          'Good'
          'Very good (& very slow)')
      end
    end
  end
  object ImageList1: TImageList
    Left = 178
    Top = 198
  end
  object ImageList2: TImageList
    Height = 32
    Width = 32
    Left = 216
    Top = 198
  end
  object PopupMenu1: TPopupMenu
    Left = 26
    Top = 198
    object Details1: TMenuItem
      AutoCheck = True
      Caption = 'Icons'
      GroupIndex = 1
      RadioItem = True
      OnClick = Smallicons1Click
    end
    object Smallicons1: TMenuItem
      AutoCheck = True
      Caption = 'Small icons'
      GroupIndex = 1
      RadioItem = True
      OnClick = Smallicons1Click
    end
    object List1: TMenuItem
      AutoCheck = True
      Caption = 'List'
      GroupIndex = 1
      RadioItem = True
      OnClick = Smallicons1Click
    end
    object Details2: TMenuItem
      AutoCheck = True
      Caption = 'Details'
      Checked = True
      GroupIndex = 1
      RadioItem = True
      OnClick = Smallicons1Click
    end
  end
  object ImageList3: TImageList
    Left = 102
    Top = 198
    Bitmap = {
      494C010101000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC670100CC670100CC67
      0100CC670100CC670100CC670100CC670100CC670100CC670100CC670100CC67
      0100CC670100CC670100CC670100CC6701000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC670100FFFFFF00FFFC
      F800FFF8F000FFF3E700FFF1E300FFECD900FFE9D300FFE5CA00FFE2C500FFDD
      BB00FFDBB500FFD5AB00FFD3A700CC6701000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC670100FFFFFF00FFFF
      FF00B3B1AF00B3B1AF00FFF3E700FFF3E700B3ADA800B3ADA800FFE5CA00FFE2
      C500B3AAA000B3AAA000FFD4A900CC6701000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC670100FFFFFF00FFFF
      FF004C7AFF004C7AFF00FFF8F000FFF8F0009934010099340100FFE9D300FFE5
      CA000199CC000199CC00FFDAB300CC6701000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC670100FFFFFF00FFFF
      FF004C7AFF004C7AFF00FFFBF600FFF8F0009934010099340100FFECD900FFE9
      D3000199CC000199CC00FFDBB700CC6701000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC670100FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFBF600FFFBF600FFF0E200FFF0E200FFEC
      D900FFECD900FFE2C500FFE1C200CC6701000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC670100FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFBF600FFF0E200FFF5EA00FFF0
      E200FFECD900FFE2C500FFE3C800CC6701000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC670100FFFFFF00FFFF
      FF00B3ADA800B3ADA800FFFFFF00FFFFFF00B3ADA800B3ADA800FFF8F000FFF5
      EB00B3ADA800B3ADA800FFE9D200CC6701000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC670100FFFFFF00FFFF
      FF00CC999900CC999900FFFFFF00FFFFFF00E27F0B00E27F0B00FFFCF900FFF8
      F0000199010001990100FFEAD600CC6701000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC670100FFFFFF00FFFF
      FF00CC999900CC999900FFFFFF00FFFFFF00E27F0B00E27F0B00FFFFFF00FFFC
      F9000199010001990100FFF0E100CC6701000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC670100FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FE00FFF9F300FFF8EF00FFF2E500CC6701000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC670100DF7B0100DF7B
      0100DF7B0100DF7B0100DF7B0100DF7B0100DF7B0100DF7B0100DF7B0100DF7B
      0100DF7B0100DF7B0100DF7B0100CC6701000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE690100CF6A0100CF6A
      0100CF6A0100CF6A0100CF6A0100CF6A0100CF6A0100CF6A0100CF6A0100CF6A
      0100CF6A0100CF6A0100CF6A0100CF700F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DFC9B700D2741400D274
      1400D2741400D2741400D2741400D2741400D2741400D2741400D2741400D274
      1400D2741400D2741400D2741400DEC2A9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF0000000000008000000000000000
      8000000000000000800000000000000080000000000000008000000000000000
      8000000000000000800000000000000080000000000000008000000000000000
      8000000000000000800000000000000080000000000000008000000000000000
      8000000000000000FFFF00000000000000000000000000000000000000000000
      000000000000}
  end
  object PopupMenu2: TPopupMenu
    Left = 64
    Top = 198
    object Byname1: TMenuItem
      AutoCheck = True
      Caption = 'By name'
      Checked = True
      GroupIndex = 1
      RadioItem = True
      OnClick = Bydate1Click
    end
    object Bydimensions1: TMenuItem
      AutoCheck = True
      Caption = 'By dimensions'
      GroupIndex = 1
      RadioItem = True
      OnClick = Bydate1Click
    end
    object Byfilesize1: TMenuItem
      AutoCheck = True
      Caption = 'By file size'
      GroupIndex = 1
      RadioItem = True
      OnClick = Bydate1Click
    end
    object Bydate1: TMenuItem
      AutoCheck = True
      Caption = 'By date'
      GroupIndex = 1
      RadioItem = True
      OnClick = Bydate1Click
    end
    object N1: TMenuItem
      Caption = '-'
      GroupIndex = 1
    end
    object Ascendant1: TMenuItem
      AutoCheck = True
      Caption = 'Ascendant'
      GroupIndex = 2
      RadioItem = True
      OnClick = Descendant1Click
    end
    object Descendant1: TMenuItem
      AutoCheck = True
      Caption = 'Descendant'
      Checked = True
      GroupIndex = 2
      RadioItem = True
      OnClick = Descendant1Click
    end
  end
  object ImageList4: TImageList
    Left = 140
    Top = 198
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C0C0C000C0C0C000808080008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C0C0C000C0C0C000C0C0C000C0C0C000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000008000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080000000
      0000C0C0C000C0C0C00000800000C0C0C000C0C0C000C0C0C000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      8000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000C0C0
      C000C0C0C00000800000008000000080000000800000C0C0C000808080008080
      8000808080000000000000000000000000000000000000000000000080000000
      800000008000FFFFFF0000000000000000000000000000000000000000000000
      000000008000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000080808000C0C0
      C00000800000C0C0C00000800000C0C0C00000800000C0C0C000808080008080
      8000808080008080800000000000000000000000000000000000000080000000
      800000008000FFFFFF0000000000000000000000000000000000000000000000
      8000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000C0C0C000C0C0
      C00000800000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      80000000800000008000FFFFFF00000000000000000000000000000080000000
      8000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000C0C0C0000080
      00000080000000800000C0C0C0000080000000800000C0C0C000808080008080
      8000808080008080800000000000000000000000000000000000000000000000
      0000000080000000800000008000FFFFFF00000000000000800000008000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000C0C0C000C0C0
      C00000800000C0C0C000C0C0C0000080000000800000C0C0C000808080008080
      8000808080008080800080808000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000C0C0C000C0C0
      C000C0C0C0000080000000800000C0C0C000FFFFFF00FFFFFF00FFFFFF008080
      8000808080008080800080808000000000000000000000000000000000000000
      00000000000000000000000080000000800000008000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000FFFFFF00FFFFFF0080808000C0C0C000C0C0C000FFFF
      FF00FFFFFF008080800080808000000000000000000000000000000000000000
      0000000000000000800000008000000080000000800000008000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000C0C0C000C0C0C000C0C0
      C000FFFFFF00FFFFFF008080800080808000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000080000000800000008000FFFFFF000000000000008000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000C0C0C000FFFFFF00FFFF
      FF0080808000000000008080800080808000C0C0C000C0C0C000C0C0C000FFFF
      FF00FFFFFF008080800080808000000000000000000000000000000080000000
      80000000800000008000FFFFFF00000000000000000000000000000080000000
      8000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080808000FFFFFF00808080008080
      8000808080000000000080808000C0C0C000C0C0C000FFFFFF00FFFFFF008080
      8000808080000000000000000000000000000000000000008000000080000000
      800000008000FFFFFF0000000000000000000000000000000000000000000000
      800000008000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000FFFFFF00FFFF
      FF00808080000000000080808000FFFFFF00FFFFFF0080808000808080000000
      000000000000000000000000000000000000000000000000800000008000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000800000008000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000FFFFFF0080808000FFFFFF00808080008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FF0FFFFF00000000FC07FFFF00000000
      F003FFF900000000C003E7FF00000000C003C3F300000000C001C3E700000000
      8001E1C7000000008001F08F000000008000F81F000000008000FC3F00000000
      0000F81F000000000000F09F000000000001C1C700000000000783E300000000
      801F8FF100000000C07FFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
