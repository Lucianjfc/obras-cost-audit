CREATE TABLE dbo.OBRIGATORIEDADE_ARQUIVO (
    ID_OBRIGATORIEDADE_ARQUIVO bigint IDENTITY(58,1) NOT NULL,
    OBJETO varchar(255) NOT NULL,
    OBRIGATORIO bit NOT NULL,
    ARQUIVO varchar(255) NOT NULL,
    EXIBIR_PORTAL bit NULL,
    EXIBIR_PRIMEIRA_FASE bit NULL,
    OBRIGATORIO_ANTIGO bit DEFAULT 0 NOT NULL,
    ARQUIVO_ENUM varchar(255) NULL,
    CONSTRAINT PK_OBRIGATORIEDADE_ARQUIVO PRIMARY KEY (ID_OBRIGATORIEDADE_ARQUIVO)
);

CREATE TABLE DBO.CONFIGURACAO_ARQUIVO
(
    ID_CONFIGURACAO_ARQUIVO    BIGINT IDENTITY (1,1) NOT NULL,
    TIPO_PROCESSO              VARCHAR(255)          NOT NULL,
    OBRIGATORIEDADE            BIT                   NOT NULL DEFAULT 0,
    ID_OBRIGATORIEDADE_ARQUIVO BIGINT,
    CONSTRAINT PK_CONFIGURACAO_ARQUIVO PRIMARY KEY (ID_CONFIGURACAO_ARQUIVO),
    CONSTRAINT FK_OBRIGATORIEDADE_ARQUIVO FOREIGN KEY (ID_OBRIGATORIEDADE_ARQUIVO) REFERENCES DBO.OBRIGATORIEDADE_ARQUIVO (ID_OBRIGATORIEDADE_ARQUIVO)
);

CREATE TABLE DBO.FILTRO_ARQUIVO
(
    ID_FILTRO_ARQUIVO       BIGINT IDENTITY (1,1) NOT NULL,
    FILTRO                  VARCHAR(255)          NOT NULL,
    ID_CONFIGURACAO_ARQUIVO BIGINT                NOT NULL,
    CONSTRAINT PK_FILTRO_ARQUIVO PRIMARY KEY (ID_FILTRO_ARQUIVO),
    CONSTRAINT FK_CONFIGURACAO_ARQUIVO FOREIGN KEY (ID_CONFIGURACAO_ARQUIVO) REFERENCES DBO.CONFIGURACAO_ARQUIVO (ID_CONFIGURACAO_ARQUIVO)
);

INSERT INTO DBO.OBRIGATORIEDADE_ARQUIVO
(OBJETO, OBRIGATORIO, ARQUIVO, EXIBIR_PORTAL, EXIBIR_PRIMEIRA_FASE, OBRIGATORIO_ANTIGO, ARQUIVO_ENUM)
VALUES('RELATORIO_OBRA', 1, 'Planilha Orcamentaria', 0, 0, 0, 'PLANILHA_ORCAMENTARIA');

BEGIN

    INSERT INTO DBO.CONFIGURACAO_ARQUIVO
    (TIPO_PROCESSO, OBRIGATORIEDADE, ID_OBRIGATORIEDADE_ARQUIVO)
    VALUES('RELATORIO_OBRA', 1, (SELECT ID_OBRIGATORIEDADE_ARQUIVO FROM DBO.OBRIGATORIEDADE_ARQUIVO WHERE ARQUIVO_ENUM = 'PLANILHA_ORCAMENTARIA' AND OBJETO = 'RELATORIO_OBRA'))

    INSERT INTO DBO.FILTRO_ARQUIVO
    (FILTRO, ID_CONFIGURACAO_ARQUIVO)
    VALUES('RELATORIO_OBRA', (SELECT IDENT_CURRENT('DBO.CONFIGURACAO_ARQUIVO')))
END
GO