-- 1. Habilitar extensión espacial (OBLIGATORIO)
CREATE EXTENSION IF NOT EXISTS postgis;

-- ==========================================
-- DIMENSIONES (Tablas Compartidas)
-- ==========================================

-- Dimensión Tiempo (Para filtrar por año, hora, mes, dia, festivos)
CREATE TABLE dim_tiempo (
    fecha_id DATE PRIMARY KEY,
    anio INT,
    mes INT,
    dia_semana INT, -- 0 Domingo - 6 Sabado
    es_fin_semana BOOLEAN,
    trimestre INT
);

-- Dimensión Estaciones Metro (Catálogo con ubicación fija)
CREATE TABLE dim_estacion_metro (
    estacion_id SERIAL PRIMARY KEY,
    nombre_estacion VARCHAR(100),
    linea VARCHAR(50),
    geometria GEOMETRY(POINT, 4326) -- Columna espacial
);

-- ==========================================
-- TABLAS DE HECHOS (Datos Enriquecidos)
-- ==========================================

-- Hechos Tránsito (Accidentes reportados)
CREATE TABLE fact_hechos_transito (
    id SERIAL PRIMARY KEY,
    fecha_evento TIMESTAMP,
    hora_evento TIME,
    tipo_evento VARCHAR(100),
    alcaldia VARCHAR(50),
    colonia VARCHAR(150),
    latitud FLOAT,
    longitud FLOAT,
    geometria GEOMETRY(POINT, 4326), -- Para mapa
    -- Columnas del Enriquecimiento
    score_atlas INT,
    flag_historico INT,
    nivel_riesgo_estatico INT,
    -- FKs simuladas
    fk_tiempo DATE
);

-- Inviales (Incidentes Viales - VOLUMEN ALTO)
CREATE TABLE fact_inviales (
    id SERIAL PRIMARY KEY,
    folio VARCHAR(50),
    fecha_creacion TIMESTAMP,
    hora_creacion TIME,
    tipo_incidente VARCHAR(100),
    latitud FLOAT,
    longitud FLOAT,
    geometria GEOMETRY(POINT, 4326),
    alcaldia VARCHAR(50),
    -- Columnas del Enriquecimiento
    score_atlas INT,
    flag_historico INT,
    nivel_riesgo_estatico INT,
    fk_tiempo DATE
);

-- Afluencia Metro (Uso del sistema)
CREATE TABLE fact_afluencia_metro (
    id SERIAL PRIMARY KEY,
    fecha DATE,
    nombre_estacion VARCHAR(100),
    linea VARCHAR(50),
    afluencia INT,
    latitud FLOAT,
    longitud FLOAT,
    geometria GEOMETRY(POINT, 4326),
    -- Columnas del Enriquecimiento
    score_atlas INT,
    flag_historico INT,
    nivel_riesgo_estatico INT,
    fk_tiempo DATE
);

-- ==========================================
-- ÍNDICES (Para velocidad en Power BI)
-- ==========================================
-- Índices Espaciales (GIST) para cruces de mapas rápidos
CREATE INDEX idx_hechos_geom ON fact_hechos_transito USING GIST (geometria);
CREATE INDEX idx_inviales_geom ON fact_inviales USING GIST (geometria);
CREATE INDEX idx_metro_geom ON fact_afluencia_metro USING GIST (geometria);

-- Índices B-Tree para filtros de tiempo y riesgo
CREATE INDEX idx_hechos_riesgo ON fact_hechos_transito (nivel_riesgo_estatico);
CREATE INDEX idx_inviales_riesgo ON fact_inviales (nivel_riesgo_estatico);
CREATE INDEX idx_metro_riesgo ON fact_afluencia_metro (nivel_riesgo_estatico);
