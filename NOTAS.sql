--NOTAS-------------------------


SELECT d2_total, d2_pedido FROM TMPROD.SD2010 D WHERE D.D2_DOC = '000057337' AND D.D2_FILIAL = '01001';
SELECT * FROM TMPROD.SF2010 SF2 WHERE SF2.F2_DOC = '473098' AND SF2.F2_FILIAL = '01096';

SELECT *  FROM TMPROD.SE1010 S WHERE S.E1_FILIAL = '01087' AND S.E1_PARCELA = '1 ' AND S.E1_TIPO = 'NF ' AND S.E1_PREFIXO = '3';

SELECT FT_OBSERV,FT_DTCANC FROM TMPROD.SFT010 SFT WHERE SFT.FT_NFISCAL = '473098        ' AND SFT.FT_FILIAL = '01096';
SELECT F3_OBSERV,F3_DTCANC FROM TMPROD.SF3010 SF3 WHERE SF3.F3_NFISCAL = '000256146         ' AND SF3.F3_FILIAL = '01002';

SELECT * FROM TMPROD.CKOCOL CKO WHERE CKO.CKO_IDERP = '0020002561460101002';
SELECT * FROM TMPROD.CKQ010 CKQ WHERE CKQ.CKQ_IDERP = '0020002561460101002';

----------------------------------------------------------------------------------------------------------------------------


SELECT * FROM TMPROD.SD1010 D WHERE D.D1_DOC = '000016524' AND D.D1_FILIAL = '01096';
SELECT * FROM TMPROD.SF1010 SF1 WHERE SF1.F1_DOC = '000016524' AND SF1.F1_FILIAL = '01096';

SELECT * FROM TMPROD.SE2010 S WHERE S.E2_NUM = '00014231' AND S.E2_FILIAL = '01027 ';

SELECT * FROM TMPROD.SFT010 SFT WHERE SFT.FT_NFISCAL = '000016524' AND SFT.FT_FILIAL = '01096';
SELECT F3_OBSERV,F3_DTCANC FROM TMPROD.SF3010 SF3 WHERE SF3.F3_NFISCAL = '00005577          ' AND SF3.F3_FILIAL = '01020';

SELECT * FROM TMPROD.CKOCOL CKO WHERE CKO.CKO_IDERP = '0020003128050101034';
SELECT * FROM TMPROD.CKQ010 CKQ WHERE CKQ.CKQ_IDERP = '0020003128050101034';

SELECT C5_FILIAL ,C5_NUM ,C.C5_TPFRETE,C.C5_TPCARGA,C.C5_EMISSAO  FROM TMPROD.SC5010 C 
WHERE (C.C5_TPFRETE = ' ' AND C.C5_TPCARGA = ' ' AND C.C5_EMISSAO >= '20230424' AND C.D_E_L_E_T_ = ' ' )
OR (C.C5_TPFRETE = 'C' AND C.C5_TPCARGA = ' ' AND C.C5_EMISSAO >= '20230424' AND C.D_E_L_E_T_ = ' ')
OR (C.C5_TPFRETE = 'F' AND C.C5_TPCARGA = ' ' AND C.C5_EMISSAO >= '20230424' AND C.D_E_L_E_T_ = ' ')
OR (C.C5_TPFRETE = ' ' AND C.C5_TPCARGA = '1' AND C.C5_EMISSAO >= '20230424' AND C.D_E_L_E_T_ = ' ')
OR (C.C5_TPFRETE = ' ' AND C.C5_TPCARGA = '2' AND C.C5_EMISSAO >= '20230424' AND C.D_E_L_E_T_ = ' ');


SELECT C.C5_NOTA , C5_FILIAL ,C5_NUM ,C.C5_TPFRETE,C.C5_TPCARGA,C.C5_EMISSAO ,usr.usr_id,usr.usr_codigo as usr_inclusao 
FROM TMPROD.SC5010 C 
LEFT JOIN tmprod.sys_usr usr
      ON ( usr.usr_id = trim(
                         (substr(C.c5_userlgi,11,1)
                      || substr(C.c5_userlgi,15,1)
                      || substr(C.c5_userlgi,19,1)
                      || substr(C.c5_userlgi,02,1)
                      || substr(C.c5_userlgi,06,1)
                      || substr(C.c5_userlgi,10,1)
                      || substr(C.c5_userlgi,14,1)
                      || substr(C.c5_userlgi,01,1)
                      || substr(C.c5_userlgi,18,1)
                      || substr(C.c5_userlgi,05,1)
                      || substr(C.c5_userlgi,09,1)
                      || substr(C.c5_userlgi,13,1)
                      || substr(C.c5_userlgi,17,1)
                      || substr(C.c5_userlgi,04,1)
                      || substr(C.c5_userlgi,08,1)
                      )
                       )
)
WHERE  C.C5_EMISSAO >= '20230424'
 AND C.D_E_L_E_T_ = ' ' 
--AND USR.USR_CODIGO = 'joao.grosso '             
                                 

AND ((C.C5_TPFRETE = ' ' AND C.C5_TPCARGA = ' ' ) 
OR (C.C5_TPFRETE = 'C' AND C.C5_TPCARGA = ' ') 
OR (C.C5_TPFRETE = 'F' AND C.C5_TPCARGA = ' ')
OR (C.C5_TPFRETE = ' ' AND C.C5_TPCARGA = '1') 
OR (C.C5_TPFRETE = ' ' AND C.C5_TPCARGA = '2'))

ORDER BY C.C5_FILIAL, C.C5_NUM;


