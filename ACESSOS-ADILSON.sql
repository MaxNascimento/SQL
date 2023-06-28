--ACESSOS----------------


SELECT *
  FROM (SELECT DISTINCT '1' AS TIPO,
                        'USUARIO COM GRUPO E PRIVILEGIO' AS DESCCONS,
                        U.USR_ID AS "CODUSUAR",
                        U.USR_CODIGO AS "LOGIN",
                        GRP.ROTINA AS "MODULO",
                        GRP.CODGRUP AS "GRUPO",
                        GD.GR__CODIGO AS "DESCGRUP",
                        GRP.CODPRIV,
                        GRP.DESCPRIV,
                        GRP.ACESSO AS "PRIVACES",
                        TO_CHAR(GRP.ITEM) AS "PRIVITEM",
                        GRP.ACESITEM AS "PRITACES"
          FROM TMPROD.SYS_USR U
         INNER JOIN TMPROD.SYS_USR_GROUPS GR
            ON U.USR_ID = GR.USR_ID
           AND GR.D_E_L_E_T_ = ' '
         INNER JOIN TMPROD.SYS_GRP_GROUP GD
            ON GD.GR__ID = GR.USR_GRUPO
         INNER JOIN (SELECT GR.GROUP_ID AS "CODGRUP",
                           PV.CODPRIV,
                           PV.DESCPRIV,
                           PV.ROTINA,
                           PV.ACESSO,
                           PV.ITEM,
                           PV.ACESITEM
                      FROM TMPROD.SYS_RULES_GRP_RULES GR
                     INNER JOIN (SELECT DISTINCT RF.RL__ID     AS "CODPRIV",
                                                R.RL__CODIGO  AS "DESCPRIV",
                                                RT.RL__ROTINA AS "ROTINA",
                                                RT.RL__ACESSO AS "ACESSO",
                                                RF.RL__ITEM   AS ITEM,
                                                RF.RL__ACESSO AS "ACESITEM"
                                  FROM TMPROD.SYS_RULES_TRANSACT RT
                                 INNER JOIN TMPROD.SYS_RULES_FEATURES RF
                                    ON RT.RL__ID = RF.RL__ID
                                   AND RT.RL__ROTINA = RF.RL__ROTINA
                                 INNER JOIN TMPROD.SYS_RULES R
                                    ON R.RL__ID = RF.RL__ID
                                   AND R.D_E_L_E_T_ = ' '
                                 WHERE RF.D_E_L_E_T_ = ' ') PV
                        ON GR.GR__RL_ID = PV.CODPRIV
                     WHERE GR.D_E_L_E_T_ = ' ') GRP
            ON GR.USR_GRUPO = GRP.CODGRUP
         WHERE U.D_E_L_E_T_ = ' '
        UNION ALL
        SELECT DISTINCT '2' AS TIPO,
                        'GRUPO SEM PRIVILEGIO' AS DESCCONS,
                        U.USR_ID AS "CODUSUAR",
                        U.USR_CODIGO AS "LOGIN",
                        CASE
                          WHEN SUBSTR(GM.GR__ARQMENU, 9, 4) = 'SIGA' THEN
                           SUBSTR(GM.GR__ARQMENU, 9, 7)
                          ELSE
                           M.M_NAME
                        END AS "MODULO",
                        G.USR_GRUPO AS "GRUPO",
                        GD.GR__CODIGO AS "DESCGRUP",
                        'SEM PRIVILEGIO' AS CODPRIV,
                        'SEM PRIVILEGIO' AS DESCPRIV,
                        'SEM PRIVILEGIO' AS "PRIVACES",
                        'SEM PRIVILEGIO' AS "PRIVITEM",
                        'SEM PRIVILEGIO' AS "PRITACES"
          FROM TMPROD.SYS_USR U
         INNER JOIN TMPROD.SYS_USR_GROUPS G
            ON U.USR_ID = G.USR_ID
           AND G.D_E_L_E_T_ = ' '
         INNER JOIN TMPROD.SYS_GRP_GROUP GD
            ON GD.GR__ID = G.USR_GRUPO
         INNER JOIN TMPROD.SYS_GRP_MODULE GM
            ON G.USR_GRUPO = GM.GR__ID
           AND GM.D_E_L_E_T_ = ' '
          LEFT OUTER JOIN TMPROD.MPMENU_MENU M
            ON GM.GR__ARQMENU = M.M_ID
         WHERE U.D_E_L_E_T_ = ' '
           AND GM.GR__ACESSO = 'T'
           AND U.USR_ID NOT IN ('000002',
                                '000013',
                                '000042',
                                '000990',
                                '001049',
                                '001055',
                                '001087',
                                '001479',
                                '001488',
                                '001641',
                                '001690',
                                '001928',
                                '001942',
                                '001993',
                                '002027',
                                '002093',
                                '002131',
                                '002140')
           AND NOT EXISTS (SELECT 1
                  FROM TMPROD.SYS_RULES_GRP_RULES GR
                 WHERE G.USR_GRUPO = GR.GROUP_ID
                   AND GR.D_E_L_E_T_ = ' ')
           AND G.USR_GRUPO <> '000000'
        UNION ALL
        SELECT DISTINCT '3' AS TIPO,
                        'USUARIO SEM GRUPO/PRIVILEGIO' AS DESCCONS,
                        U.USR_ID AS "CODUSUAR",
                        U.USR_CODIGO AS "LOGIN",
                        UM.USR_CODMOD AS "MODULO",
                        'SEM GRUPO' AS GRUPO,
                        'SEM GRUPO' AS "DESCGRUP",
                        'SEM PRIVILEGIO' AS CODPRIV,
                        'SEM PRIVILEGIO' AS DESCPRIV,
                        'SEM PRIVILEGIO' AS "PRIVACES",
                        'SEM PRIVILEGIO' AS "PRIVITEM",
                        'SEM PRIVILEGIO' AS "PRITACES"
          FROM TMPROD.SYS_USR U
         INNER JOIN TMPROD.SYS_USR_MODULE UM
            ON U.USR_ID = UM.USR_ID
           AND UM.D_E_L_E_T_ = ' '
         WHERE U.D_E_L_E_T_ = ' '
           AND UM.USR_ACESSO = 'T'
           AND NOT EXISTS (SELECT 1
                  FROM TMPROD.SYS_USR_GROUPS UG
                 WHERE U.USR_ID = UG.USR_ID
                   AND UG.D_E_L_E_T_ = ' ')
        UNION ALL
        SELECT DISTINCT '4' AS TIPO,
                        'PRIVILEGIO NO USUARIO' AS DESCCONS,
                        U.USR_ID AS "CODUSUAR",
                        U.USR_CODIGO AS "LOGIN",
                        PV.ROTINA AS "MODULO",
                        'PRIVILEGIO' AS "GRUPO",
                        'NO USUARIO' AS "DESCGRUP",
                        PV.CODPRIV,
                        PV.DESCPRIV,
                        PV.ACESSO AS "PRIVACES",
                        TO_CHAR(PV.ITEM) AS "PRIVITEM",
                        PV.ACESITEM AS "PRITACES"
          FROM TMPROD.SYS_USR U
         INNER JOIN TMPROD.SYS_RULES_USR_RULES UR
            ON U.USR_ID = UR.USER_ID
           AND UR.D_E_L_E_T_ = ' '
         INNER JOIN (SELECT DISTINCT RF.RL__ID     AS "CODPRIV",
                                    R.RL__CODIGO  AS "DESCPRIV",
                                    RT.RL__ROTINA AS "ROTINA",
                                    RT.RL__ACESSO AS "ACESSO",
                                    RF.RL__ITEM   AS ITEM,
                                    RF.RL__ACESSO AS "ACESITEM"
                      FROM TMPROD.SYS_RULES_TRANSACT RT
                     INNER JOIN TMPROD.SYS_RULES_FEATURES RF
                        ON RT.RL__ID = RF.RL__ID
                       AND RT.RL__ROTINA = RF.RL__ROTINA
                     INNER JOIN TMPROD.SYS_RULES R
                        ON R.RL__ID = RF.RL__ID
                       AND R.D_E_L_E_T_ = ' '
                     WHERE RF.D_E_L_E_T_ = ' ') PV
            ON UR.USR_RL_ID = PV.CODPRIV
         WHERE U.D_E_L_E_T_ = ' ') DADOS
 WHERE DADOS.CODUSUAR = '000000'
   --AND DADOS.MODULO = 'MATA080'
 --  AND DADOS.CODPRIV = '000585'
   --AND DADOS.PRIVACES = '1'
  -- AND DADOS.PRIVITEM IN ('3', '4', '5')
   --+AND DADOS.PRITACES = '1'
   --AND DADOS.TIPO = '4'
 ORDER BY DADOS.CODUSUAR,
          DADOS.GRUPO,
          DADOS.MODULO,
          DADOS.CODPRIV,
          DADOS.PRIVITEM;
