--CAN��O-----

SELECT * FROM  TITULO T WHERE T.ID_TITULO = '000002022' AND T.CD_EMITE = '6775' AND T.CD_FAZENDA = '10';
SELECT * FROM FAZ_REGISTRO F WHERE F.NR_DOCUMENTO = '000002022' AND F.CD_EMITE_FORNEC = '6775' AND F.CD_FAZENDA = '10';

SELECT DISTINCT
       A.NR_REG,
       A.CD_FAZENDA,
       C.DS_FAZENDA,
       D.NR_SAFRA,
       TO_CHAR(D.DT_INICIO,'DD/MM/RRRR') DT_INICIO,
       TO_CHAR(D.DT_FIM,'DD/MM/RRRR') DT_FIM,
       A.CD_CULTURA,
       E.DS_CULTURA,
       A.NR_DOCUMENTO,
       A.CD_SERIE,
       A.CD_EMITE_FORNEC,
       F.DS_RAZAO_SOCIAL DS_RAZAO_SOCIAL_FORNEC,
       TO_CHAR(A.DT_REG,'DD/MM/RRRR') DT_REGISTRO,
       TO_CHAR(A.DT_ENTRADA,'DD/MM/RRRR') DT_ENTRADA,
       A.CD_SUBGRUPO,
      SUBSTR(H.DS_SUBGRUPO,1,20)  DS_SUBBRUPO,
       B.CD_ITEM,
       G.DS_ITEM,
       TRIM(TO_CHAR(B.QT_ITEM,'FM999G999G999D90','NLS_NUMERIC_CHARACTERS='',.''')) QT_ITEM,
       TRIM(TO_CHAR(B.VL_UNITARIO,'FM999G999G999D90','NLS_NUMERIC_CHARACTERS='',.''')) VL_UNITARIO,
       TRIM(TO_CHAR(B.VL_TOTAL,'FM999G999G999D90','NLS_NUMERIC_CHARACTERS='',.''')) VL_TOTAL,
       TRIM(TO_CHAR(T.VL_DESCONTADO,'FM999G999G999D90','NLS_NUMERIC_CHARACTERS='',.''')) VL_SALDO_ABERTO,
       TRIM(TO_CHAR(P.VL_QUITACAO,'FM999G999G999D90','NLS_NUMERIC_CHARACTERS='',.''')) VL_QUITACAO,
       TRIM(TO_CHAR(P.VL_JURO_QUITACAO,'FM999G999G999D90','NLS_NUMERIC_CHARACTERS='',.''')) VL_JUROS,
       TRIM(TO_CHAR(P.VL_DESCONTO,'FM999G999G999D90','NLS_NUMERIC_CHARACTERS='',.''')) VL_DESCONTO,
       TO_CHAR(P.DT_BAIXA,'DD/MM/RRRR') DT_QUITACAO,
       DECODE(I.TP_OPERACAO,'R','RECEITA','DESPESA') CD_TP_OPER
       /*(SELECT DISTINCT 
               CASE WHEN Z.TP_OPERACAO = 'R' THEN 'RECEITA'
                    WHEN Z.TP_OPERACAO = 'D' THEN 'DESPESAS' END TIPO_OPERACAO
          FROM FAZ_OPERACAO Z 
         WHERE Z.CD_OPERACAO = A.CD_OPERACAO) CD_TP_OPER*/
       
  FROM FAZ_REGISTRO      A,
       FAZ_REGISTRO_ITEM B,
       FAZ_FAZENDA       C,
       FAZ_SAFRA         D,
       FAZ_CULTURA       E,
       EMITENTE          F,
       FAZ_ITEM          G,
       FAZ_SUBGRUPO      H,
       FAZ_OPERACAO      I, 
       TITULO            T,
       PAGTO_TITULO      P
 WHERE A.NR_REG = B.NR_REG
   AND A.CD_FAZENDA = C.CD_FAZENDA(+)
   AND A.CD_SAFRA = D.CD_SAFRA(+)
   AND A.CD_CULTURA = E.CD_CULTURA(+)
   AND A.CD_EMITE_FORNEC = F.CD_EMITE(+)
   AND B.CD_ITEM = G.CD_ITEM(+)
   AND H.CD_SUBGRUPO(+) = A.CD_SUBGRUPO
   AND I.CD_OPERACAO = A.CD_OPERACAO
   AND T.ID_TITULO = A.NR_DOCUMENTO
   AND T.CD_EMITE = A.CD_EMITE_FORNEC
   AND T.CD_FAZENDA = A.CD_FAZENDA
   AND T.SERIE_DOC = A.CD_SERIE
   AND T.CD_PROPRIETARIO = A.CD_PROPRIETARIO
   AND P.NR_LANCAMENTO_TIT = T.NR_LANCAMENTO

  -- #FILTRO#
   
 GROUP BY A.NR_REG,
          A.CD_FAZENDA,
          C.DS_FAZENDA,
          D.NR_SAFRA,
          D.DT_INICIO,
          D.DT_FIM,
          A.CD_CULTURA,
          E.DS_CULTURA,
          A.NR_DOCUMENTO,
          A.CD_SERIE,
          A.CD_EMITE_FORNEC,
          F.DS_RAZAO_SOCIAL,
          A.DT_REG,
          A.DT_ENTRADA,
          A.CD_SUBGRUPO,
          H.DS_SUBGRUPO,
          B.CD_ITEM,
          G.DS_ITEM,
          B.QT_ITEM,
          B.VL_UNITARIO,
          B.VL_TOTAL,
                 T.VL_DESCONTADO,
          P.VL_QUITACAO,
          P.VL_JURO_QUITACAO,
          P.VL_DESCONTO,
          P.DT_BAIXA,
          DECODE(I.TP_OPERACAO,'R','RECEITA','DESPESA')
