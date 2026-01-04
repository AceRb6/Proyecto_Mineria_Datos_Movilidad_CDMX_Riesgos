/* SCRIPT DE REINICIO TOTAL - MODO LIMPIEZA */

-- 1. Vaciar tablas de hechos y reiniciar contadores (IDs)
-- CASCADE asegura que se limpien dependencias si existen
TRUNCATE TABLE fact_hechos_transito RESTART IDENTITY CASCADE;
TRUNCATE TABLE fact_inviales RESTART IDENTITY CASCADE;
TRUNCATE TABLE fact_afluencia_metro RESTART IDENTITY CASCADE;
TRUNCATE TABLE fact_pluviales RESTART IDENTITY CASCADE;

-- 2. Vaciar vista materializada (quedará en 0 registros)
REFRESH MATERIALIZED VIEW mv_hechos_con_clima;

-- 3. Verificación de limpieza
SELECT 
    (SELECT COUNT(*) FROM fact_hechos_transito) as hechos,
    (SELECT COUNT(*) FROM fact_inviales) as inviales,
    (SELECT COUNT(*) FROM fact_afluencia_metro) as metro,
    (SELECT COUNT(*) FROM fact_pluviales) as pluviales;
