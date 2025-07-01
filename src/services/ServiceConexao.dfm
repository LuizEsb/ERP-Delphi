object Service_Conexao: TService_Conexao
  Height = 480
  Width = 640
  object connUsuario: TFDConnection
    Params.Strings = (
      'Database=C:\DB\BANCOPROJ.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'CharacterSet=WIN1252'
      'Server=localhost'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object qryLogin: TFDQuery
    Connection = connUsuario
    SQL.Strings = (
      'select * from usuarios')
    Left = 24
    Top = 72
  end
  object qryLogLogin: TFDQuery
    Active = True
    Connection = connUsuario
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'INC_USUARIOSID'
    SQL.Strings = (
      'select * from log_login '
      'order by id desc')
    Left = 24
    Top = 128
    object qryLogLoginID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qryLogLoginID_USUARIO: TIntegerField
      FieldName = 'ID_USUARIO'
      Origin = 'ID_USUARIO'
      Required = True
    end
    object qryLogLoginDATA_HORA_LOGIN: TSQLTimeStampField
      FieldName = 'DATA_HORA_LOGIN'
      Origin = 'DATA_HORA_LOGIN'
    end
    object qryLogLoginSUCESSO: TStringField
      FieldName = 'SUCESSO'
      Origin = 'SUCESSO'
      Size = 3
    end
    object qryLogLoginREGISTRO_MAC_PC: TStringField
      FieldName = 'REGISTRO_MAC_PC'
      Origin = 'REGISTRO_MAC_PC'
    end
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 584
    Top = 8
  end
  object FBDriverLink: TFDPhysFBDriverLink
    Left = 584
    Top = 72
  end
  object qryUsuarios: TFDQuery
    Connection = connUsuario
    UpdateOptions.KeyFields = 'ID'
    SQL.Strings = (
      'select * from usuarios'
      '')
    Left = 112
    Top = 72
    object qryUsuariosID: TFDAutoIncField
      AutoGenerateValue = arNone
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ClientAutoIncrement = False
      IdentityInsert = True
    end
    object qryUsuariosLOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Size = 100
    end
    object qryUsuariosSTATUS: TStringField
      FieldName = 'STATUS'
      Origin = 'STATUS'
    end
    object qryUsuariosSENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 64
    end
    object qryUsuariosULTIMO_LOG: TSQLTimeStampField
      Alignment = taRightJustify
      FieldName = 'ULTIMO_LOG'
      Origin = 'ULTIMO_LOG'
    end
  end
end
