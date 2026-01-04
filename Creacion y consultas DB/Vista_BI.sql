-- 3. CREAR VISTAS OPTIMIZADAS PARA POWER BI
-- Power BI a veces prefiere Lat/Lon explícitos en lugar de objetos geometría binarios.

-- Vista de Riesgo Vial (Inviales + Hechos) para Mapa de Calor
CREATE OR REPLACE VIEW v_pbi_riesgo_mapa AS
SELECT 
    'Accidente' as origen,
    tipo_evento as tipo,
    nivel_riesgo_estatico,
    latitud,
    longitud,
    fk_tiempo
FROM fact_hechos_transito
UNION ALL
SELECT 
    'Incidente Vial' as origen,
    tipo_incidente as tipo,
    nivel_riesgo_estatico,
    latitud,
    longitud,
    fk_tiempo
FROM fact_inviales
WHERE nivel_riesgo_estatico >= 2;