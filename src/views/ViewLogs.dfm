object View_Logs: TView_Logs
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'View_Logs'
  ClientHeight = 674
  ClientWidth = 1240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  TextHeight = 15
  object pnlLinhaFundo: TPanel
    Left = 0
    Top = 35
    Width = 1240
    Height = 631
    Align = alClient
    BevelOuter = bvNone
    Color = 8750469
    ParentBackground = False
    TabOrder = 0
    object CardPanel_Listas: TCardPanel
      AlignWithMargins = True
      Left = 1
      Top = 0
      Width = 1238
      Height = 631
      Margins.Left = 1
      Margins.Top = 0
      Margins.Right = 1
      Margins.Bottom = 0
      Align = alClient
      ActiveCard = card_pesquisa
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object card_pesquisa: TCard
        Left = 0
        Top = 0
        Width = 1238
        Height = 631
        Caption = 'Card1'
        CardIndex = 0
        TabOrder = 0
        object pnlTituloPesquisa: TPanel
          Left = 0
          Top = 0
          Width = 1238
          Height = 100
          Align = alTop
          BevelOuter = bvNone
          Color = 13224649
          ParentBackground = False
          TabOrder = 0
          object lblTituloPesquisa: TLabel
            Left = 29
            Top = 14
            Width = 80
            Height = 30
            Caption = 'Pesquisa'
            Color = 10000022
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Segoe UI Semilight'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object lblFiltro: TLabel
            Left = 867
            Top = 54
            Width = 61
            Height = 17
            Caption = 'Filtrar por:'
            Color = 13355722
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentColor = False
            ParentFont = False
          end
          object edtPesquisa: TSearchBox
            Left = 29
            Top = 50
            Width = 812
            Height = 29
            BevelInner = bvNone
            BevelOuter = bvNone
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI Semilight'
            Font.Style = []
            ParentFont = False
            CanUndoSelText = True
            TabOrder = 0
            TextHint = 'Digite aqui a sua pesquisa'
            OnKeyDown = edtPesquisaKeyDown
          end
          object cbxFiltro: TComboBox
            Left = 942
            Top = 54
            Width = 106
            Height = 23
            TabOrder = 1
            Text = 'ID'
            Items.Strings = (
              'ID'
              'ID_USUARIO')
          end
        end
        object DBG_dados: TDBGrid
          AlignWithMargins = True
          Left = 5
          Top = 105
          Width = 1228
          Height = 521
          Cursor = crHandPoint
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 5
          Align = alClient
          BorderStyle = bsNone
          DataSource = dsDados
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 1
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'ID'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ID_USUARIO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DATA_HORA_LOGIN'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'SUCESSO'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'REGISTRO_MAC_PC'
              Visible = True
            end>
        end
      end
    end
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 666
    Width = 1240
    Height = 8
    Align = alBottom
    BevelOuter = bvNone
    Color = 8750469
    ParentBackground = False
    TabOrder = 1
  end
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 1240
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    Color = 5395026
    ParentBackground = False
    TabOrder = 2
    object lblTitulo: TLabel
      AlignWithMargins = True
      Left = 38
      Top = 3
      Width = 1118
      Height = 29
      Cursor = crHandPoint
      Align = alClient
      Caption = 'Clientes'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 68
      ExplicitHeight = 25
    end
    object pnlIcone: TPanel
      Left = 0
      Top = 0
      Width = 35
      Height = 35
      Align = alLeft
      BevelOuter = bvNone
      Color = 33023
      TabOrder = 0
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 35
        Height = 35
        Cursor = crHandPoint
        Align = alClient
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
          00200806000000737A7AF40000000467414D410000B18F0BFC61050000035649
          44415478DACD575D481541143EB37B7FF46A5EBDA899A6BD08064926F520A5F4
          8329A50FF952514404111A3D49508686A4A441484F2911444451BDD883169A50
          A1850F85190609BEE44F99CAF527BD797F76A76F2EEB75FD09D734B6031F3373
          383BE79B3367CECC3232599811237E8724CD96B373A46A3A31963413157AFE27
          DB3511E00D644353066C073E03D75931CD427F10FDB39AD95DE85E421786FE15
          601BF009A881DEB75602E1685E007B817758673E2BA169E84B30BEAD999D87A3
          7A5E4F9198B105E3DDC01BE010F4BFFE8A4061E3118B42526C9ADF1D7571F2FD
          7D1B29593E923F3444659C6A74A44E3E1E6D3EB35199A916B63FE488F2E37105
          F78A3C7DCEE2A9EE07B0DD09DBCE9BCE5DA7BF585D531652C79A8A9E050C1380
          F3442DEC79300877AADE781B57EC7E26792724FB884A4C75F0C08648D5E712F6
          D392CDED61969F1271291AB656AEDA7D4CF64EC216892122D00AD482C4D08A04
          E05C46730BB810DA8690290F7DC0177CBE9C9E2F9EBC41CC0912CA4A0436A179
          05A4AD941FAB945E603F087C5F964030DB7DC44A13F66DE9B346B76125C9EBE9
          1D8E0652FD13B975C3AFBFC2139F3B1D4102C1B3AB5205BAB94372A4E5B22B27
          735CB2DB0D15090322B62546F57A6BDDED5D49CAB448C63678AC1275628E800C
          028FD03D3A2A3BE8524C368DC81160C7174E1430E6905916136014AFCCD08DF1
          0E8A533C42F514044E8080A28F4025BA79220265AEEC74B714168A8070ECF9C8
          C93F442B570E70B626113976B01011B10C973AEBAD7177F468116885C7CA5004
          8246A28AF949AE88DF93D26D8B6D01EBE4B9CDF30F134D3671E25E8311B01339
          0B19591368EE5888680E64F8C6F2AB46DEF693152B47350DE5805E700A52D0B4
          032941052ABB7F10049A414031480007D95900029B3198BF0DFA811C9C82FE05
          B6DA163018E6A29BDA638B755D8BCE2A456171313D81E77C5539E03C3C4F4004
          0185CB7D75A2B32EDD37E6C6B00FF3B6890B4C9F840FD13DB62409D785C09224
          7C82794FEA93D07402E66E81E949188C8299C7D05021EA4221FA46C60A512223
          4726192F44FF4B2936EF32D272C0BCEB582FA63D487404CC7D92692470A15239
          70609D1EA522A2D5703EB8CCD62C2FE2591EC0B37CEB1A9FE5BDD6982999F8EA
          9EE57A31EDC74447C0DC5FB32009337F4EFFB5FC06DDA95A3FE1D7AEE3000000
          0049454E44AE426082}
        ExplicitLeft = 8
        ExplicitTop = 8
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
    end
    object pnlFechar: TPanel
      Left = 1159
      Top = 0
      Width = 81
      Height = 35
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object btnSair: TSpeedButton
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 75
        Height = 29
        Cursor = crHandPoint
        Align = alClient
        Caption = '[ SAIR ]'
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 6711039
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        OnClick = btnSairClick
        ExplicitLeft = 64
        ExplicitTop = 4
        ExplicitWidth = 117
        ExplicitHeight = 27
      end
    end
  end
  object dsDados: TDataSource
    DataSet = Service_Conexao.qryLogLogin
    Left = 297
    Top = 35
  end
end
