// ================================================================
// LOAD CSV — Neo4j AuraDB
// Proyecto: GPS Sistema de Gestión de Pacientes
// BDs: Security + Inversions
//
// INSTRUCCIONES:
//   1. Sube todos los CSV a tu repositorio GitHub
//   2. Reemplaza BASE_URL con tu URL raw de GitHub:
//      https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main
//   3. Ejecuta los bloques EN EL ORDEN en que aparecen
// ================================================================

// ----------------------------------------------------------------
// 0. DEFINE TU BASE URL (edita esta línea antes de correr)
// ----------------------------------------------------------------
// :param BASE_URL => 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main'


// ================================================================
// SECURITY — CONSTRAINTS E ÍNDICES
// ================================================================

CREATE CONSTRAINT user_id     IF NOT EXISTS FOR (n:User)        REQUIRE n.userId      IS UNIQUE;
CREATE CONSTRAINT role_id     IF NOT EXISTS FOR (n:Role)        REQUIRE n.roleId      IS UNIQUE;
CREATE CONSTRAINT app_id      IF NOT EXISTS FOR (n:Application) REQUIRE n.appId       IS UNIQUE;
CREATE CONSTRAINT priv_id     IF NOT EXISTS FOR (n:Privilege)   REQUIRE n.privilegeId IS UNIQUE;
CREATE CONSTRAINT proc_id     IF NOT EXISTS FOR (n:Process)     REQUIRE n.processId   IS UNIQUE;

// ================================================================
// INVERSIONS — CONSTRAINTS E ÍNDICES
// ================================================================

CREATE CONSTRAINT share_id    IF NOT EXISTS FOR (n:Share)        REQUIRE n.shareId    IS UNIQUE;
CREATE CONSTRAINT record_id   IF NOT EXISTS FOR (n:SalesRecord)  REQUIRE n.id         IS UNIQUE;
CREATE CONSTRAINT strategy_id IF NOT EXISTS FOR (n:Strategy)     REQUIRE n.strategyId IS UNIQUE;


// ================================================================
// SECURITY — CARGA DE NODOS
// ================================================================

// ── 1. Nodos :User ──────────────────────────────────────────────
// Archivo: ztusers.csv
// Columnas: userId,username,email,companyId,cediId,
//           regUser,regDate,regTime,modUser,modDate,modTime,active,delete

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/ztusers.csv' AS row
MERGE (u:User { userId: row.userId })
SET
  u.username  = row.username,
  u.email     = row.email,
  u.companyId = toInteger(row.companyId),
  u.cediId    = row.cediId,
  u.regUser   = row.regUser,
  u.regDate   = row.regDate,
  u.regTime   = row.regTime,
  u.modUser   = row.modUser,
  u.modDate   = row.modDate,
  u.modTime   = row.modTime,
  u.active    = (row.active = 'true'),
  u.delete    = (row.delete = 'true');


// ── 2. Nodos :Role ──────────────────────────────────────────────
// Archivo: ztroles.csv
// Columnas: roleId,roleName,description,
//           regUser,regDate,regTime,modUser,modDate,modTime,active,delete

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/ztroles.csv' AS row
MERGE (r:Role { roleId: row.roleId })
SET
  r.roleName    = row.roleName,
  r.description = row.description,
  r.regUser     = row.regUser,
  r.regDate     = row.regDate,
  r.regTime     = row.regTime,
  r.modUser     = row.modUser,
  r.modDate     = row.modDate,
  r.modTime     = row.modTime,
  r.active      = (row.active = 'true'),
  r.delete      = (row.delete = 'true');


// ── 3. Nodos :Application ───────────────────────────────────────
// Archivo: ztapplications.csv
// Columnas: appId,appName,
//           regUser,regDate,regTime,modUser,modDate,modTime,active,delete

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/ztapplications.csv' AS row
MERGE (a:Application { appId: row.appId })
SET
  a.appName = row.appName,
  a.regUser = row.regUser,
  a.regDate = row.regDate,
  a.regTime = row.regTime,
  a.modUser = row.modUser,
  a.modDate = row.modDate,
  a.modTime = row.modTime,
  a.active  = (row.active = 'true'),
  a.delete  = (row.delete = 'true');


// ── 4. Nodos :Privilege ─────────────────────────────────────────
// Archivo: ztprivileges.csv
// Columnas: privilegeId,privilegeName,
//           regUser,regDate,regTime,modUser,modDate,modTime,active,delete

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/ztprivileges.csv' AS row
MERGE (p:Privilege { privilegeId: row.privilegeId })
SET
  p.privilegeName = row.privilegeName,
  p.regUser       = row.regUser,
  p.regDate       = row.regDate,
  p.regTime       = row.regTime,
  p.modUser       = row.modUser,
  p.modDate       = row.modDate,
  p.modTime       = row.modTime,
  p.active        = (row.active = 'true'),
  p.delete        = (row.delete = 'true');


// ── 5. Nodos :Process ───────────────────────────────────────────
// Archivo: ztprocess.csv
// Columnas: processId,processName,
//           regUser,regDate,regTime,modUser,modDate,modTime,active,delete

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/ztprocess.csv' AS row
MERGE (p:Process { processId: row.processId })
SET
  p.processName = row.processName,
  p.regUser     = row.regUser,
  p.regDate     = row.regDate,
  p.regTime     = row.regTime,
  p.modUser     = row.modUser,
  p.modDate     = row.modDate,
  p.modTime     = row.modTime,
  p.active      = (row.active = 'true'),
  p.delete      = (row.delete = 'true');


// ================================================================
// SECURITY — CARGA DE RELACIONES
// ================================================================

// ── 6. (:User)-[:HAS_ROLE]->(:Role) ────────────────────────────
// Archivo: rel_user_has_role.csv
// Columnas: userId,roleId

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/rel_user_has_role.csv' AS row
MATCH (u:User    { userId: row.userId })
MATCH (r:Role    { roleId: row.roleId })
MERGE (u)-[:HAS_ROLE]->(r);


// ── 7. (:Role)-[:HAS_ACCESS_TO]->(:Application) ────────────────
// Archivo: rel_role_has_access_to.csv
// Columnas: roleId,appId

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/rel_role_has_access_to.csv' AS row
MATCH (r:Role        { roleId: row.roleId })
MATCH (a:Application { appId:  row.appId  })
MERGE (r)-[:HAS_ACCESS_TO]->(a);


// ── 8. (:Role)-[:CAN_USE]->(:Privilege) ────────────────────────
// Archivo: rel_role_can_use.csv
// Columnas: roleId,privilegeId

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/rel_role_can_use.csv' AS row
MATCH (r:Role      { roleId:      row.roleId      })
MATCH (p:Privilege { privilegeId: row.privilegeId })
MERGE (r)-[:CAN_USE]->(p);


// ── 9. (:Role)-[:EXECUTES]->(:Process) ─────────────────────────
// Archivo: rel_role_executes.csv
// Columnas: roleId,processId

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/rel_role_executes.csv' AS row
MATCH (r:Role    { roleId:    row.roleId    })
MATCH (p:Process { processId: row.processId })
MERGE (r)-[:EXECUTES]->(p);


// ================================================================
// INVERSIONS — CARGA DE NODOS
// ================================================================

// ── 10. Nodos :Share ────────────────────────────────────────────
// Archivo: shares.csv
// Columnas: shareId,symbol,companyName,sector,exchange,
//           regUser,regDate,regTime,modUser,modDate,modTime,active,delete

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/shares.csv' AS row
MERGE (s:Share { shareId: row.shareId })
SET
  s.symbol      = row.symbol,
  s.companyName = row.companyName,
  s.sector      = row.sector,
  s.exchange    = row.exchange,
  s.regUser     = row.regUser,
  s.regDate     = row.regDate,
  s.regTime     = row.regTime,
  s.modUser     = row.modUser,
  s.modDate     = row.modDate,
  s.modTime     = row.modTime,
  s.active      = (row.active = 'true'),
  s.delete      = (row.delete = 'true');


// ── 11. Nodos :SalesRecord ──────────────────────────────────────
// Archivo: sales_historical.csv
// Columnas: id,shareId,symbol,date,open,high,low,close,volume,
//           regUser,regDate,regTime,modUser,modDate,modTime,active,delete

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/sales_historical.csv' AS row
MERGE (r:SalesRecord { id: toInteger(row.id) })
SET
  r.shareId = row.shareId,
  r.symbol  = row.symbol,
  r.date    = row.date,
  r.open    = toFloat(row.open),
  r.high    = toFloat(row.high),
  r.low     = toFloat(row.low),
  r.close   = toFloat(row.close),
  r.volume  = toFloat(row.volume),
  r.regUser = row.regUser,
  r.regDate = row.regDate,
  r.regTime = row.regTime,
  r.modUser = row.modUser,
  r.modDate = row.modDate,
  r.modTime = row.modTime,
  r.active  = (row.active = 'true'),
  r.delete  = (row.delete = 'true');


// ── 12. Nodos :Strategy ─────────────────────────────────────────
// Archivo: strategies.csv
// Columnas: strategyId,shareId,symbol,name,type,description,
//           regUser,regDate,regTime,modUser,modDate,modTime,active,delete

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/strategies.csv' AS row
MERGE (s:Strategy { strategyId: row.strategyId })
SET
  s.shareId     = row.shareId,
  s.symbol      = row.symbol,
  s.name        = row.name,
  s.type        = row.type,
  s.description = row.description,
  s.regUser     = row.regUser,
  s.regDate     = row.regDate,
  s.regTime     = row.regTime,
  s.modUser     = row.modUser,
  s.modDate     = row.modDate,
  s.modTime     = row.modTime,
  s.active      = (row.active = 'true'),
  s.delete      = (row.delete = 'true');


// ================================================================
// INVERSIONS — CARGA DE RELACIONES
// ================================================================

// ── 13. (:Share)-[:HAS_RECORD]->(:SalesRecord) ─────────────────
// Archivo: rel_share_has_record.csv
// Columnas: shareId,recordId

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/rel_share_has_record.csv' AS row
MATCH (s:Share       { shareId: row.shareId             })
MATCH (r:SalesRecord { id:      toInteger(row.recordId) })
MERGE (s)-[:HAS_RECORD]->(r);


// ── 14. (:Share)-[:HAS_STRATEGY]->(:Strategy) ──────────────────
// Archivo: rel_share_has_strategy.csv
// Columnas: shareId,strategyId

LOAD CSV WITH HEADERS
FROM 'https://raw.githubusercontent.com/TU_USUARIO/TU_REPO/main/rel_share_has_strategy.csv' AS row
MATCH (s:Share    { shareId:    row.shareId    })
MATCH (t:Strategy { strategyId: row.strategyId })
MERGE (s)-[:HAS_STRATEGY]->(t);


// ================================================================
// VERIFICACIÓN — corre esto al final para confirmar la carga
// ================================================================

MATCH (n) RETURN labels(n)[0] AS Nodo, count(n) AS Total ORDER BY Nodo;
MATCH ()-[r]->() RETURN type(r) AS Relacion, count(r) AS Total ORDER BY Relacion;
