-- 1. POBLAR DIMENSIÓN TIEMPO (Generador Automático)
-- Genera fechas desde el año 2014 hasta 2026 (para cubrir proyecciones)
INSERT INTO dim_tiempo (fecha_id, anio, mes, dia_semana, es_fin_semana, trimestre)
SELECT 
    d::DATE as fecha_id,
    EXTRACT(YEAR FROM d) as anio,
    EXTRACT(MONTH FROM d) as mes,
    EXTRACT(DOW FROM d) as dia_semana
    CASE WHEN EXTRACT(DOW FROM d) IN (0, 6) THEN TRUE ELSE FALSE END as es_fin_semana,
    EXTRACT(QUARTER FROM d) as trimestre
FROM generate_series('2014-01-01'::DATE, '2026-12-31'::DATE, '1 day'::INTERVAL) d
ON CONFLICT (fecha_id) DO NOTHING;