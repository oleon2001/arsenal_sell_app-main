-- ========================================
-- VERIFICACIÓN Y CORRECCIÓN DE TABLA CUSTOMERS
-- ========================================
-- 
-- Este script verifica que la tabla customers tenga la estructura correcta
-- según el esquema definido en base.sql
-- 
-- INSTRUCCIONES:
-- 1. Ejecutar en Supabase SQL Editor
-- 2. Verificar que no haya errores
-- 3. Si hay errores, ejecutar las correcciones automáticamente
-- ========================================

-- 1. VERIFICAR ESTRUCTURA ACTUAL
DO $$
DECLARE
    column_info RECORD;
    expected_columns TEXT[] := ARRAY[
        'id', 'company_id', 'code', 'name', 'email', 'phone', 'address', 
        'location', 'geo_accuracy_m', 'created_by', 'created_at', 'updated_at'
    ];
    missing_columns TEXT[] := '{}';
    extra_columns TEXT[] := '{}';
BEGIN
    RAISE NOTICE 'Verificando estructura de tabla customers...';
    
    -- Verificar columnas existentes
    FOR column_info IN 
        SELECT column_name, data_type, is_nullable
        FROM information_schema.columns 
        WHERE table_name = 'customers' AND table_schema = 'public'
        ORDER BY ordinal_position
    LOOP
        RAISE NOTICE 'Columna: % - Tipo: % - Nullable: %', 
            column_info.column_name, column_info.data_type, column_info.is_nullable;
    END LOOP;
    
    -- Verificar columnas faltantes
    FOR i IN 1..array_length(expected_columns, 1) LOOP
        IF NOT EXISTS (
            SELECT 1 FROM information_schema.columns 
            WHERE table_name = 'customers' 
            AND column_name = expected_columns[i]
        ) THEN
            missing_columns := array_append(missing_columns, expected_columns[i]);
        END IF;
    END LOOP;
    
    -- Verificar columnas extra
    FOR column_info IN 
        SELECT column_name
        FROM information_schema.columns 
        WHERE table_name = 'customers' AND table_schema = 'public'
    LOOP
        IF NOT (column_info.column_name = ANY(expected_columns)) THEN
            extra_columns := array_append(extra_columns, column_info.column_name);
        END IF;
    END LOOP;
    
    -- Reportar resultados
    IF array_length(missing_columns, 1) > 0 THEN
        RAISE NOTICE '⚠️  COLUMNAS FALTANTES: %', missing_columns;
    ELSE
        RAISE NOTICE '✅ Todas las columnas esperadas están presentes';
    END IF;
    
    IF array_length(extra_columns, 1) > 0 THEN
        RAISE NOTICE 'ℹ️  COLUMNAS EXTRA: %', extra_columns;
    END IF;
END $$;

-- 2. VERIFICAR EXTENSIONES REQUERIDAS
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'postgis') THEN
        RAISE NOTICE '⚠️  EXTENSIÓN POSTGIS NO ENCONTRADA - Creando...';
        CREATE EXTENSION IF NOT EXISTS "postgis";
    ELSE
        RAISE NOTICE '✅ Extensión PostGIS está habilitada';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'pgcrypto') THEN
        RAISE NOTICE '⚠️  EXTENSIÓN PGCRYPTO NO ENCONTRADA - Creando...';
        CREATE EXTENSION IF NOT EXISTS "pgcrypto";
    ELSE
        RAISE NOTICE '✅ Extensión pgcrypto está habilitada';
    END IF;
END $$;

-- 3. VERIFICAR TABLA COMPANIES
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'companies') THEN
        RAISE NOTICE '⚠️  TABLA COMPANIES NO EXISTE - Creando...';
        CREATE TABLE IF NOT EXISTS companies (
            id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
            name TEXT NOT NULL,
            created_at TIMESTAMPTZ DEFAULT NOW()
        );
        
        -- Insertar compañía por defecto
        INSERT INTO companies (id, name) VALUES 
        ('705abd4b-c5a7-4a6b-be9c-e2da93df3987', 'Arsenal Sell Demo Company')
        ON CONFLICT DO NOTHING;
        
        RAISE NOTICE '✅ Tabla companies creada con compañía por defecto';
    ELSE
        RAISE NOTICE '✅ Tabla companies existe';
    END IF;
END $$;

-- 4. VERIFICAR TABLA PROFILES
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'profiles') THEN
        RAISE NOTICE '⚠️  TABLA PROFILES NO EXISTE - Creando...';
        CREATE TABLE IF NOT EXISTS profiles (
            id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
            company_id UUID REFERENCES companies(id) ON DELETE SET NULL,
            full_name TEXT,
            phone TEXT,
            role TEXT NOT NULL DEFAULT 'VENDEDOR',
            is_active BOOLEAN NOT NULL DEFAULT TRUE,
            created_at TIMESTAMPTZ DEFAULT NOW()
        );
        RAISE NOTICE '✅ Tabla profiles creada';
    ELSE
        RAISE NOTICE '✅ Tabla profiles existe';
    END IF;
END $$;

-- 5. VERIFICAR Y CORREGIR TABLA CUSTOMERS
DO $$
BEGIN
    -- Verificar si la tabla existe
    IF NOT EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'customers') THEN
        RAISE NOTICE '⚠️  TABLA CUSTOMERS NO EXISTE - Creando...';
        CREATE TABLE IF NOT EXISTS customers (
            id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
            company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
            code TEXT UNIQUE,
            name TEXT NOT NULL,
            email TEXT,
            phone TEXT,
            address TEXT,
            location GEOGRAPHY(POINT, 4326),
            geo_accuracy_m NUMERIC,
            created_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
            created_at TIMESTAMPTZ DEFAULT NOW(),
            updated_at TIMESTAMPTZ DEFAULT NOW()
        );
        RAISE NOTICE '✅ Tabla customers creada';
    ELSE
        RAISE NOTICE '✅ Tabla customers existe';
        
        -- Verificar y agregar columnas faltantes
        IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'customers' AND column_name = 'location') THEN
            RAISE NOTICE '⚠️  Agregando columna location...';
            ALTER TABLE customers ADD COLUMN location GEOGRAPHY(POINT, 4326);
        END IF;
        
        IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'customers' AND column_name = 'geo_accuracy_m') THEN
            RAISE NOTICE '⚠️  Agregando columna geo_accuracy_m...';
            ALTER TABLE customers ADD COLUMN geo_accuracy_m NUMERIC;
        END IF;
        
        IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'customers' AND column_name = 'created_by') THEN
            RAISE NOTICE '⚠️  Agregando columna created_by...';
            ALTER TABLE customers ADD COLUMN created_by UUID REFERENCES profiles(id) ON DELETE SET NULL;
        END IF;
        
        IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'customers' AND column_name = 'updated_at') THEN
            RAISE NOTICE '⚠️  Agregando columna updated_at...';
            ALTER TABLE customers ADD COLUMN updated_at TIMESTAMPTZ DEFAULT NOW();
        END IF;
    END IF;
END $$;

-- 6. VERIFICAR ÍNDICES
DO $$
BEGIN
    -- Índice de company_id
    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE tablename = 'customers' AND indexname = 'customers_company_idx') THEN
        RAISE NOTICE '⚠️  Creando índice customers_company_idx...';
        CREATE INDEX customers_company_idx ON customers(company_id);
    END IF;
    
    -- Índice espacial para location
    IF NOT EXISTS (SELECT 1 FROM pg_indexes WHERE tablename = 'customers' AND indexname = 'customers_loc_idx') THEN
        RAISE NOTICE '⚠️  Creando índice espacial customers_loc_idx...';
        CREATE INDEX customers_loc_idx ON customers USING GIST (location);
    END IF;
END $$;

-- 7. VERIFICAR RLS
DO $$
BEGIN
    -- Habilitar RLS
    ALTER TABLE customers ENABLE ROW LEVEL SECURITY;
    
    -- Verificar políticas RLS
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'customers' AND policyname = 'company_read') THEN
        RAISE NOTICE '⚠️  Creando política RLS company_read...';
        CREATE POLICY "company_read" ON customers
        FOR SELECT USING (company_id = (SELECT company_id FROM profiles WHERE id = auth.uid()));
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE tablename = 'customers' AND policyname = 'company_rw_customers') THEN
        RAISE NOTICE '⚠️  Creando política RLS company_rw_customers...';
        CREATE POLICY "company_rw_customers" ON customers
        FOR ALL USING (company_id = (SELECT company_id FROM profiles WHERE id = auth.uid()))
        WITH CHECK (company_id = (SELECT company_id FROM profiles WHERE id = auth.uid()));
    END IF;
END $$;

-- 8. VERIFICAR TRIGGERS
DO $$
BEGIN
    -- Función para auto-asignar company_id
    IF NOT EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'set_company_id') THEN
        RAISE NOTICE '⚠️  Creando función set_company_id...';
        CREATE OR REPLACE FUNCTION set_company_id()
        RETURNS TRIGGER AS $$
        BEGIN
            IF NEW.company_id IS NULL THEN
                NEW.company_id := (SELECT company_id FROM profiles WHERE id = auth.uid());
            END IF;
            RETURN NEW;
        END $$ LANGUAGE plpgsql;
    END IF;
    
    -- Trigger para auto-asignar company_id
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'trg_set_company_customers') THEN
        RAISE NOTICE '⚠️  Creando trigger trg_set_company_customers...';
        CREATE TRIGGER trg_set_company_customers
        BEFORE INSERT ON customers
        FOR EACH ROW EXECUTE FUNCTION set_company_id();
    END IF;
END $$;

-- 9. VERIFICAR DATOS DE PRUEBA
DO $$
BEGIN
    -- Verificar si hay clientes de prueba
    IF NOT EXISTS (SELECT 1 FROM customers LIMIT 1) THEN
        RAISE NOTICE '⚠️  No hay clientes de prueba - Insertando...';
        
        -- Insertar cliente de prueba
        INSERT INTO customers (id, company_id, name, email, phone, address, location, geo_accuracy_m) VALUES
        (
            gen_random_uuid(),
            '705abd4b-c5a7-4a6b-be9c-e2da93df3987',
            'Cliente de Prueba',
            'test@example.com',
            '+1234567890',
            'Dirección de Prueba',
            ST_SetSRID(ST_MakePoint(-68.019204, 10.1980202), 4326),
            10.0
        );
        
        RAISE NOTICE '✅ Cliente de prueba insertado';
    ELSE
        RAISE NOTICE '✅ Ya existen clientes en la tabla';
    END IF;
END $$;

-- 10. REPORTE FINAL
DO $$
BEGIN
    RAISE NOTICE '========================================';
    RAISE NOTICE 'VERIFICACIÓN COMPLETADA';
    RAISE NOTICE '========================================';
    RAISE NOTICE 'Tabla customers verificada y corregida';
    RAISE NOTICE 'Índices espaciales creados';
    RAISE NOTICE 'Políticas RLS configuradas';
    RAISE NOTICE 'Triggers configurados';
    RAISE NOTICE '========================================';
    RAISE NOTICE 'Próximo paso: Probar sincronización desde Flutter';
    RAISE NOTICE '========================================';
END $$;
