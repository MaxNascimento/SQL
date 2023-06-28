SELECT DISTINCT SC5.R_E_C_N_O_ AS C5_RECNO,
                SC9.R_E_C_N_O_ AS C9_RECNO,
                C9_PEDIDO,
                C5_PEDEXP,
                DAK_SEQCAR,
                DAK_COD,
                DAK_pes
  FROM tmprod.SC9010 SC9
 INNER JOIN tmprod.SC5010 SC5
    ON SC5.D_E_L_E_T_ = ' '
   AND C5_FILIAL = C9_FILIAL
   AND C5_NUM = C9_PEDIDO
 INNER JOIN tmprod.DAI010 DAI
    ON (DAI.D_E_L_E_T_ = ' ' AND C5_FILIAL = DAI_FILIAL AND
       C5_NUM = DAI_PEDIDO)
 INNER JOIN tmprod.DAK010 DAK
    ON (DAK.D_E_L_E_T_ = ' ' AND DAI_FILIAL = DAK_FILIAL AND
       DAI_COD = DAK_COD AND DAI_SEQCAR = DAK_SEQCAR)
 WHERE SC9.D_E_L_E_T_ = ' '
   AND C9_FILIAL = '01001'
   AND C9_OK = '2Ipx'
   AND DAK_FILIAL = '01001'
   AND DAK_FEZNF <> '1'
   AND DAK_DATA >= '20010101'
   AND DAK_DATA <= '20250517'
   AND EXISTS (SELECT 1
          FROM tmprod.DAI010 DAI
         INNER JOIN tmprod.SC9010 SC9
            ON SC9.C9_FILIAL = '01001'
           AND SC9.C9_CARGA = DAI.DAI_COD
           AND SC9.C9_SEQCAR = DAI.DAI_SEQCAR
           AND SC9.C9_PEDIDO = DAI.DAI_PEDIDO
           AND SC9.D_E_L_E_T_ = ' '
         WHERE DAI.DAI_FILIAL = '01001'
           AND DAI.DAI_COD = DAK_COD
           AND DAI.DAI_SEQCAR = DAK_SEQCAR
           AND DAI.D_E_L_E_T_ = ' '
           AND SC9.C9_DATALIB >= '20010101'
           AND SC9.C9_DATALIB <= '20250517')
           ORDER BY C9_PEDIDO
