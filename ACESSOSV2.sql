--ACESSOS------------------

SELECT DISTINCT U.USR_ID ID,
                U.USR_CODIGO USR_CODIGO,
                U.USR_NOME USR_NOME ,
                DECODE(U.USR_MSBLQL, '1', 'SIM', '2', 'NÃO') BLOQUEADO,
                UR.USR_RL_ID USR_PRIVILEGIO_ID,
                UR.USR_RL_CODIGO USR_PRIVILEGIO_NOME,
                UG.USR_GRUPO ID_GRUPO,
                G.GR__CODIGO GR_NOME,
                GR.GR__RL_ID GR_PRIVILEGIO_ID,
                GR.GR__RL_CODIGO,
                --UM.USR_ACESSO,
               -- UM.USR_MODULO
              
               /* RF.RL__ROTINA ROTINA,
                RF.RL__ITEM ITEM,
                RF.RL__DESMDEF OPCAO,
                DECODE(RF.RL__ACESSO,
                       '1',
                       'PERMITIDO',
                       '2',
                       'NÃO PERMITIDO',
                       '3',
                       'NEGADO') ACESSO */

  FROM TMPROD.SYS_USR U
  LEFT JOIN TMPROD.SYS_USR_GROUPS UG
    ON U.USR_ID = UG.USR_ID
  LEFT JOIN TMPROD.SYS_GRP_GROUP G
    ON UG.USR_GRUPO = G.GR__ID
  LEFT JOIN TMPROD.SYS_RULES_USR_RULES UR
    ON U.USR_ID = UR.USER_ID
  LEFT JOIN TMPROD.SYS_RULES_GRP_RULES GR
    ON UG.USR_GRUPO = GR.GROUP_ID
    
 LEFT JOIN  TMPROD.SYS_USR_MODULE UM
 ON UM.USR_ID = U.USR_ID
/*  LEFT JOIN TMPROD.SYS_RULES_FEATURES RF
    ON RF.RL__ID = GR.GR__RL_ID
    OR RF.RL__ID = UR.USR_RL_ID
  LEFT JOIN TMPROD.SYS_RULES_TRANSACT RT
    ON RT.RL__ID = GR.GR__RL_ID
    OR RT.RL__ID = UR.USR_RL_ID*/

 WHERE 
 G.GR__ID IS NULL AND
UM.USR_ACESSO = 'T' 
--UM.USR_MODULO =  '99' OR UM.USR_MODULO = '98'
--U.USR_ID =  '001349'  OR
--U.USR_CODIGO = 'rogerio.junior'
--UR.USR_RL_ID  = '001318' OR GR.GR__RL_ID = '001318'
