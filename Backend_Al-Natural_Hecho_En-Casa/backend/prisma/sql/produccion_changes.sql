-- Migration: produccion changes
-- Segura para re-ejecución (IF NOT EXISTS / IF EXISTS)

ALTER TABLE produccion
  ADD COLUMN IF NOT EXISTS nombre varchar(191) NOT NULL DEFAULT '';

ALTER TABLE produccion
  DROP COLUMN IF EXISTS ml_producidos;

ALTER TABLE produccion_resultado
  DROP COLUMN IF EXISTS ml_totales_generados;

ALTER TABLE productos_finales
  ADD COLUMN IF NOT EXISTS produccion_resultado_id varchar(191) NULL;

-- Agregar FK solo si no existe
SET @fk_exists = (
  SELECT COUNT(*) FROM information_schema.TABLE_CONSTRAINTS
  WHERE CONSTRAINT_SCHEMA = DATABASE()
    AND TABLE_NAME = 'productos_finales'
    AND CONSTRAINT_NAME = 'fk_productos_produccion_resultado'
    AND CONSTRAINT_TYPE = 'FOREIGN KEY'
);

SET @sql = IF(@fk_exists = 0,
  'ALTER TABLE productos_finales ADD CONSTRAINT fk_productos_produccion_resultado FOREIGN KEY (produccion_resultado_id) REFERENCES produccion_resultado(id) ON DELETE RESTRICT',
  'SELECT 1'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
