SELECT *
  FROM (SELECT DISTINCT E5_FILIAL FILIAL,
                        E5_NUMERO NUMERO,
                        E5_TIPO TIPO,
                        SE2.E2_CTROG CTROG,
                        SE2.E2_MDCONTR NR_CONTRATO,
                        SD1.D1_PEDIDO PEDIDO_COM,
                        SD2.D2_PEDIDO PEDIDO_VEND,
                        CONCAT(E2_EMISSAO, E1_EMISSAO) AS DT_EMISSAO,
                        E5_DATA DATA_MOVIMENTO,
                        E5_MOEDA MOEDA,
                        CONCAT(E2_VALOR,E1_VALOR) VLR_TITULO,
                        E5_VALOR VALOR_MOVIMENTO,
                        E5_NATUREZ NATUREZA,
                        SED.ED_DESCRIC DESCRICAO,
                        E5_BANCO BANCO,
                        E5_AGENCIA AGENCIA,
                        E5_CONTA CONTA,
                        E5_NUMCHEQ NUM_CHEQUE,
                        E5_DOCUMEN DOCUMENTO,
                        E5_VENCTO VENCIMENTO,
                        DECODE(E5_RECPAG,
                               'P',
                               'PAGAMENTO',
                               'R',
                               'RECEBIMENTO') AS REC_PAG,
                        E5_BENEF BENEFICIARIO,
                        E5_HISTOR HISTORICO,
                        E5_TIPODOC TIPO_MOV,
                        E5_LA DEPOSIT_CHEQUE,
                        E5_SITUACA SIUTACAO,
                        E5_LOTE LOTE,
                        E5_PREFIXO PREFIXO,
                        E5_PARCELA PARCELA,
                        E5_CLIFOR CLI_FOR,
                        E5_LOJA LOJA,
                        E5_DTDIGIT DT_DIGIT,
                        E5_MOTBX MOTIVO_BAIXA,
                        E5_RECONC RECONCILIADO,
                        E5_SEQ BAIXA_PARCIAL,
                        E5_DTDISPO DT_DISPO,
                        E5_CCD CCUSTO_DEBITO,
                        E5_CCC CCUSTO_CREDITO,
                        E5_OK IDEN_SELECAO,
                        E5_ARQRAT ARQ_RATEIO,
                        E5_IDENTEE IDENT_COMPENSACAO,
                        E5_FILORIG FILIAL_ORIGEM,
                        E5_ARQCNAB ARQ_CNAB,
                        E5_VLJUROS VLR_JUROS,
                        E5_VLMULTA VLR_MULTA,
                        E5_VLCORRE VLR_CORRECAO,
                        E5_VLDESCO VLR_DESCONTO,
                        E5_CNABOC OCORRENCIA_CNAB,
                        E5_ITEMD ITEM_CONTAB_DEB,
                        E5_ITEMC ITEM_CONTAB_CRED,
                        E5_TXMOEDA TX_MOEDA,
                        E5_FATURA FATURA,
                        E5_CODORCA COD_ORCAMENTO,
                        E5_SITCOB SIT_COBRANCA,
                        E5_FORNADT FORNEC_ADTO,
                        E5_CLIENTE CLIENTE,
                        E5_FORNECE FORNECEDOR,
                        E5_MOVCX MOV_CAIXINHA,
                        E5_KEY CHAVE_TITULO,
                        E5_MULTNAT RATEIO_MULT_NATUREZ,
                        E5_AGLIMP AGLUTI_IMPOSTO,
                        E5_VLACRES VLR_ACRESCIMO,
                        E5_VLDECRE VLR_DECRESCIMO,
                        E5_VRETPIS VLR_RET_PIS,
                        E5_VRETCOF VLR_RET_CONFINS,
                        E5_VRETCSL VLR_RET_CSLL,
                        E5_PRETPIS PEND_RET_PIS,
                        E5_PRETCOF PEND_RET_COFINS,
                        E5_PRETCSL PEND_RET_CSLL,
                        E5_PROCTRA PROCES_TRANSF,
                        E5_IDMOVI ID_MOVIMENTO,
                        E5_ORIGEM ORIGEM,
                        E5_FLDMED STATUS_DMED,
                        E5_TPDESC DESCONTO_F100,
                        E5_PRINSS PROV_INSS,
                        E5_VRETINS VLR_RET_INSS,
                        E5_PRETINS PEND_RET_INSS,
                        E5_DTCANBX DT_CANC_BAIXA,
                        E5_CCUSTO C_CUSTO,
                        E5_SDOCREC SERIE_RECIBO,
                        E5_PRISS PROV_ISS,
                        E5_FORMAPG FORMA_PGTO,
                        E5_MOVFKS REGIS_MIGRACAO,
                        E5_IDORIG ID_ORIGEM,
                        E5_TABORI TABELA_ORIGEM,
                        E5_SEQCON SEQ_CONCILIACAO,
                        E5_CGC ID_CONTRIBUINTE,
                        E5_EC05DB ENT_DEBITO_05,
                        E5_EC05CR ENT_CREDITO_05,
                        E5_EC06DB ENT_DEBITO_06,
                        E5_EC06CR ENT_CREDITO_06,
                        E5_XREQAB REQ_ABASTEC,
                        E5_XREQLA REQ_LAVAGEM,
                        E5_XCTRFRT CTR_FRETE,
                        E5_XENVEL NR_ENVELOPE
        
          FROM TMPROD.SE5010 SE5
          LEFT JOIN TMPROD.SE2010 SE2
            ON SE2.E2_PREFIXO = SE5.E5_PREFIXO
           AND SE2.E2_NUM = SE5.E5_NUMERO
           AND SE2.E2_FORNECE = SE5.E5_CLIFOR
           AND SE2.E2_LOJA = SE5.E5_LOJA
           AND SE2.E2_PARCELA = SE5.E5_PARCELA
        
          LEFT JOIN TMPROD.SE1010 SE1
            ON SE1.E1_PREFIXO = SE5.E5_PREFIXO
           AND SE1.E1_NUM = SE5.E5_NUMERO
           AND SE1.E1_CLIENTE = SE5.E5_CLIFOR
           AND SE1.E1_LOJA = SE5.E5_LOJA
           AND SE1.E1_PARCELA = SE5.E5_PARCELA
        
          LEFT JOIN TMPROD.SD1010 SD1
            ON SD1.D1_DOC = SE5.E5_NUMERO
           AND SD1.D1_SERIE = SE5.E5_PREFIXO
           AND SD1.D1_FORNECE = SE5.E5_CLIFOR
           AND SD1.D1_FILIAL = SE5.E5_FILIAL
           AND SD1.D1_LOJA = SE5.E5_LOJA
        
          LEFT JOIN TMPROD.SD2010 SD2
            ON SD2.D2_DOC = SE5.E5_NUMERO
           AND SD2.D2_SERIE = SE5.E5_PREFIXO
           AND SD2.D2_CLIENTE = SE5.E5_CLIFOR
           AND SD2.D2_FILIAL = SE5.E5_FILIAL
           AND SD2.D2_LOJA = SE5.E5_LOJA
        
          LEFT JOIN TMPROD.SED010 SED
           ON SED.ED_CODIGO = SE5.E5_NATUREZ
           WHERE SE5.D_E_L_E_T_ = ' ')  X

WHERE 1=1
