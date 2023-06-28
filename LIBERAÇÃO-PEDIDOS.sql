SELECT C5_OK,
       '  ' STATUS,
       C5_XBLOQ,
       C5_FILIAL FILIAL,
       C5_NUM PEDIDO,
       C5_EMISSAO EMISSAO,
       C5_CLIENTE CLIENTE,
       C5_LOJACLI LOJA,
       A1_NOME NOME,
       PAN_CODMOT COD_BLOQ,
       PAN_DESCR DESCR_BLOQ,
       C5_VEND1 VEND,
       C5_XPDESC PDESC,
       C5_XFORMA FORMA,
       PAN_LIBER LIBERADO,
       (SELECT SUM(C6_VALOR)
          FROM TMPROD.SC6010 SC6
         WHERE SC6.C6_FILIAL = SC5.C5_FILIAL
           AND SC6.C6_NUM = SC5.C5_NUM
           AND SC6.D_E_L_E_T_ = ' ') VALOR_SOMA
  FROM TMPROD.SC5010 SC5
 INNER JOIN TMPROD.PAN010 PAN
    ON PAN.PAN_FILIAL = SC5.C5_FILIAL
   AND PAN.PAN_NUMPED = SC5.C5_NUM
   AND PAN.PAN_LIBER <> 'S'
   AND PAN.D_E_L_E_T_ = ' '
 INNER JOIN TMPROD.SA1010 A
    ON A.A1_COD = SC5.C5_CLIENTE
   AND A.A1_LOJA = SC5.C5_LOJACLI
   AND A.D_E_L_E_T_ = ' '
 WHERE C5_FILIAL IN ('01001',
                     '01002',
                     '01004',
                     '01009',
                     '01016',
                     '01020',
                     '01026',
                     '01027',
                     '01029',
                     '01038',
                     '01040',
                     '01049',
                     '01051',
                     '01052',
                     '01076',
                     '')
   AND C5_CLIENTE BETWEEN '      ' AND 'zzzzzz'
   AND C5_LOJACLI BETWEEN '  ' AND 'zz'
   AND C5_EMISSAO BETWEEN '20230101' AND '20501231'
   AND C5_XBLOQ <> ' '
   AND SC5.D_E_L_E_T_ = ' '
   
 ORDER BY C5_FILIAL, C5_NUM, PAN_CODMOT
