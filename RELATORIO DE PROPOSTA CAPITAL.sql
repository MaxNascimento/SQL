SELECT PB7_FILIAL AS "FILIAL",
       PB7_CODPC AS "CODIGO",
       PB7_TITULO AS "TITULO",
       TO_CHAR(TO_DATE(TRIM(PB7_DTSOLT), 'YYYYMMDD'), 'DD/MM/YYYY') AS "DT_ABERTURA",
       PB7_VALOR AS "VALOR_CAPT",
       PB7_CODREQ AS "ID_SOLICIT",
       UPPER(SOL.ZZ0_NOME) AS "SOLICITANTE",
       PB7_CODGE AS "ID_GESTOR",
       UPPER(GES.ZZ0_NOME) AS "GESTOR",
       PB7_CC AS "C_CUSTO",
       PB7_ITEMCT AS "ITEM_CONTAB",
       PB7_CLASSI AS "CLASSIFICACAO",
       TO_CHAR(TO_DATE(TRIM(PB8_DTFIM), 'YYYYMMDD'), 'DD/MM/YYYY') AS "DT_PREVISAO_FIM",
       TO_CHAR(TO_DATE(TRIM(PB8_DTENC), 'YYYYMMDD'), 'DD/MM/YYYY') AS "DT_ENCERR",
       UPPER(DECODE(PB7_STATUS,
                    '1',
                    'em aberto',
                    '2',
                    'em aprovação',
                    '3',
                    'aprovado',
                    '4',
                    'reprovado',
                    '5',
                    '-',
                    '6',
                    'encerrado')) AS "STATUS",
       PB8_CLASSE AS "CLASSE_VALOR"

  FROM TMPROD.PB7010
 INNER JOIN TMPROD.PB8010
    ON PB7_CODPC = PB8_CODPC
   AND PB7_FILIAL = PB8_FILIAL
 INNER JOIN TMPROD.ZZ0010 SOL
    ON PB7_CODREQ = SOL.ZZ0_IDUSUA
 INNER JOIN TMPROD.ZZ0010 GES
    ON PB7_CODGE = GES.ZZ0_IDUSUA
    
    ORDER BY PB7_FILIAL,PB7_CODPC
