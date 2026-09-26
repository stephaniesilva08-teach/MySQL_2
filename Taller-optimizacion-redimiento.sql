-- ==============================================================================
-- TALLER PRÁCTICO: OPTIMIZACIÓN DE CONSULTAS Y RENDIMIENTO EN MYSQL (BancoDB)
-- ==============================================================================

CREATE DATABASE IF NOT EXISTS BancoDB;
USE BancoDB;

-- ------------------------------------------------------------------------------
-- PARTE 0: ESTRUCTURA DE TABLAS Y POBLAMIENTO DE DATOS MASIVOS
-- ------------------------------------------------------------------------------

DROP TABLE IF EXISTS historial_transferencias;
DROP TABLE IF EXISTS cuentas;

CREATE TABLE cuentas (
    id_cuenta INT PRIMARY KEY AUTO_INCREMENT,
    titular VARCHAR(100) NOT NULL,
    tipo_cuenta VARCHAR(20) NOT NULL DEFAULT 'Ahorros',
    saldo DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    estado VARCHAR(20) NOT NULL DEFAULT 'Activa',
    fecha_apertura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE historial_transferencias (
    id_transferencia INT AUTO_INCREMENT PRIMARY KEY,
    cuenta_origen INT NOT NULL,
    cuenta_destino INT NOT NULL,
    monto DECIMAL(12, 2) NOT NULL,
    estado_transferencia VARCHAR(20) NOT NULL DEFAULT 'Exitosa',
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (cuenta_origen) REFERENCES cuentas(id_cuenta),
    FOREIGN KEY (cuenta_destino) REFERENCES cuentas(id_cuenta)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Procedimiento almacenado
DROP PROCEDURE IF EXISTS CargarDatosPrueba;
DELIMITER //
CREATE PROCEDURE CargarDatosPrueba()
BEGIN
    DECLARE i INT DEFAULT 1;
    
    START TRANSACTION;
    
    WHILE i <= 1000 DO
        INSERT INTO cuentas (titular, tipo_cuenta, saldo, estado, fecha_apertura)
        VALUES (
            CONCAT('Cliente_', i),
            IF(i % 2 = 0, 'Ahorros', 'Corriente'),
            ROUND(RAND() * 10000000, 2),
            IF(i % 10 = 0, 'Bloqueada', 'Activa'),
            DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY)
        );
        SET i = i + 1;
    END WHILE;

    SET i = 1;
    WHILE i <= 10000 DO
        INSERT INTO historial_transferencias (cuenta_origen, cuenta_destino, monto, estado_transferencia, fecha)
        VALUES (
            FLOOR(1 + RAND() * 1000),
            FLOOR(1 + RAND() * 1000),
            ROUND(1000 + RAND() * 500000, 2),
            IF(i % 15 = 0, 'Fallida', 'Exitosa'),
            DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 180) DAY)
        );
        SET i = i + 1;
    END WHILE;

    COMMIT;
END //
DELIMITER ;

CALL CargarDatosPrueba();
DROP PROCEDURE IF EXISTS CargarDatosPrueba;


-- ==============================================================================
-- PARTE 1: DEMOSTRACIÓN GUIADA EN CLASE
-- ==============================================================================

EXPLAIN 
SELECT id_transferencia, cuenta_origen, monto, fecha
FROM historial_transferencias
WHERE estado_transferencia = 'Exitosa'
  AND fecha >= DATE_SUB(NOW(), INTERVAL 30 DAY);

-- (Manejo seguro de índices sin IF EXISTS)
ALTER TABLE historial_transferencias DROP INDEX idx_transf_estado_fecha;
CREATE INDEX idx_transf_estado_fecha ON historial_transferencias(estado_transferencia, fecha);

EXPLAIN 
SELECT id_transferencia, cuenta_origen, monto, fecha
FROM historial_transferencias
WHERE estado_transferencia = 'Exitosa'
  AND fecha >= DATE_SUB(NOW(), INTERVAL 30 DAY);


-- ==============================================================================
-- PARTE 2: EJERCICIOS PRÁCTICOS PARA LOS ESTUDIANTES
-- ==============================================================================

-- EJERCICIO 1: Non-Sargable Query
EXPLAIN 
SELECT * 
FROM historial_transferencias 
WHERE DATE(fecha) = DATE_SUB(CURRENT_DATE, INTERVAL 10 DAY);

ALTER TABLE historial_transferencias DROP INDEX idx_transf_fecha;
CREATE INDEX idx_transf_fecha ON historial_transferencias(fecha);

EXPLAIN 
SELECT * 
FROM historial_transferencias 
WHERE fecha >= DATE_SUB(CURRENT_DATE, INTERVAL 10 DAY)
  AND fecha < DATE_SUB(CURRENT_DATE, INTERVAL 9 DAY);


-- EJERCICIO 2: Covering Index
EXPLAIN 
SELECT titular, saldo, tipo_cuenta
FROM cuentas
WHERE estado = 'Activa';

ALTER TABLE cuentas DROP INDEX idx_cuentas_estado_cubriente;
CREATE INDEX idx_cuentas_estado_cubriente 
ON cuentas(estado, titular, saldo, tipo_cuenta);

EXPLAIN 
SELECT titular, saldo, tipo_cuenta
FROM cuentas
WHERE estado = 'Activa';


-- EJERCICIO 3: Filtros Combinados y JOINs
EXPLAIN 
SELECT c.id_cuenta, c.titular, ht.id_transferencia, ht.monto, ht.fecha
FROM cuentas c
JOIN historial_transferencias ht ON c.id_cuenta = ht.cuenta_origen
WHERE c.estado = 'Activa'
  AND ht.monto > 300000.00
  AND ht.fecha >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);

ALTER TABLE historial_transferencias DROP INDEX idx_transf_cuenta_fecha_monto;
CREATE INDEX idx_transf_cuenta_fecha_monto 
ON historial_transferencias(cuenta_origen, fecha, monto);

EXPLAIN 
SELECT c.id_cuenta, c.titular, ht.id_transferencia, ht.monto, ht.fecha
FROM cuentas c
JOIN historial_transferencias ht ON c.id_cuenta = ht.cuenta_origen
WHERE c.estado = 'Activa'
  AND ht.monto > 300000.00
  AND ht.fecha >= DATE_SUB(CURRENT_DATE, INTERVAL 30Cd DAY);