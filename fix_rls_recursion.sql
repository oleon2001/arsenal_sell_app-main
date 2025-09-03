-- ========================================
-- SOLUCIÓN COMPLETA A RECURSIÓN INFINITA - ARSENAL SELL APP
-- ========================================
-- 
-- Este archivo ELIMINA las políticas RLS problemáticas que causan
-- recursión infinita y crea nuevas políticas seguras.
-- 
-- INSTRUCCIONES:
-- 1. Ejecutar en Supabase SQL Editor
-- 2. Después de ejecutar, probar el registro de usuarios
-- ========================================

-- =========================
-- 1) ELIMINAR TODAS LAS POLÍTICAS PROBLEMÁTICAS
-- =========================

-- Eliminar TODAS las políticas existentes de profiles
DROP POLICY IF EXISTS "users_can_read_own_profile" ON profiles;
DROP POLICY IF EXISTS "users_can_insert_own_profile" ON profiles;
DROP POLICY IF EXISTS "users_can_update_own_profile" ON profiles;
DROP POLICY IF EXISTS "users_can_delete_own_profile" ON profiles;
DROP POLICY IF EXISTS "users_can_read_company_profiles" ON profiles;
DROP POLICY IF EXISTS "admins_can_manage_company_profiles" ON profiles;
DROP POLICY IF EXISTS "admin_can_manage_all_profiles" ON profiles;
DROP POLICY IF EXISTS "company_read" ON profiles;
DROP POLICY IF EXISTS "company_rw_customers" ON profiles;
DROP POLICY IF EXISTS "company_rw_orders" ON profiles;
DROP POLICY IF EXISTS "company_rw_visits" ON profiles;
DROP POLICY IF EXISTS "company_rw_tracking" ON profiles;
DROP POLICY IF EXISTS "company_rw_inventories" ON profiles;
DROP POLICY IF EXISTS "company_rw_inventory_movements" ON profiles;

-- Eliminar políticas de companies si existen
DROP POLICY IF EXISTS "users_can_create_companies" ON companies;
DROP POLICY IF EXISTS "users_can_read_own_company" ON companies;
DROP POLICY IF EXISTS "admins_can_update_company" ON companies;
DROP POLICY IF EXISTS "admin_can_delete_company" ON companies;

-- Eliminar políticas de otras tablas si existen
DROP POLICY IF EXISTS "users_can_manage_company_customers" ON customers;
DROP POLICY IF EXISTS "users_can_manage_company_orders" ON orders;
DROP POLICY IF EXISTS "users_can_manage_company_visits" ON visits;

-- =========================
-- 2) CREAR POLÍTICAS RLS SEGURAS PARA PROFILES
-- =========================

-- Política para permitir a los usuarios leer su propio perfil
CREATE POLICY "profiles_own_profile_select" ON profiles
FOR SELECT USING (id = auth.uid());

-- Política para permitir a los usuarios insertar su propio perfil
CREATE POLICY "profiles_own_profile_insert" ON profiles
FOR INSERT WITH CHECK (id = auth.uid());

-- Política para permitir a los usuarios actualizar su propio perfil
CREATE POLICY "profiles_own_profile_update" ON profiles
FOR UPDATE USING (id = auth.uid())
WITH CHECK (id = auth.uid());

-- Política para permitir a los usuarios eliminar su propio perfil
CREATE POLICY "profiles_own_profile_delete" ON profiles
FOR DELETE USING (id = auth.uid());

-- =========================
-- 3) CREAR POLÍTICAS RLS SEGURAS PARA COMPANIES
-- =========================

-- Política para permitir a los usuarios crear compañías
CREATE POLICY "companies_allow_insert" ON companies
FOR INSERT WITH CHECK (true);

-- Política para permitir a los usuarios leer compañías de las que son miembros
CREATE POLICY "companies_own_company_select" ON companies
FOR SELECT USING (
  id IN (
    SELECT company_id FROM profiles 
    WHERE id = auth.uid() 
    AND company_id IS NOT NULL
  )
);

-- Política para permitir a ADMIN/SUPERVISOR actualizar su compañía
CREATE POLICY "companies_admin_update" ON companies
FOR UPDATE USING (
  id IN (
    SELECT company_id FROM profiles 
    WHERE id = auth.uid() 
    AND role IN ('ADMIN', 'SUPERVISOR')
    AND company_id IS NOT NULL
  )
)
WITH CHECK (
  id IN (
    SELECT company_id FROM profiles 
    WHERE id = auth.uid() 
    AND role IN ('ADMIN', 'SUPERVISOR')
    AND company_id IS NOT NULL
  )
);

-- Política para permitir a ADMIN eliminar compañías
CREATE POLICY "companies_admin_delete" ON companies
FOR DELETE USING (
  (SELECT role FROM profiles WHERE id = auth.uid()) = 'ADMIN'
);

-- =========================
-- 4) CREAR POLÍTICAS RLS SEGURAS PARA OTRAS TABLAS
-- =========================

-- Política para customers (clientes)
CREATE POLICY "customers_company_access" ON customers
FOR ALL USING (
  company_id IN (
    SELECT company_id FROM profiles 
    WHERE id = auth.uid() 
    AND company_id IS NOT NULL
  )
)
WITH CHECK (
  company_id IN (
    SELECT company_id FROM profiles 
    WHERE id = auth.uid() 
    AND company_id IS NOT NULL
  )
);

-- Política para orders (pedidos)
CREATE POLICY "orders_company_access" ON orders
FOR ALL USING (
  company_id IN (
    SELECT company_id FROM profiles 
    WHERE id = auth.uid() 
    AND company_id IS NOT NULL
  )
)
WITH CHECK (
  company_id IN (
    SELECT company_id FROM profiles 
    WHERE id = auth.uid() 
    AND company_id IS NOT NULL
  )
);

-- Política para visits (visitas)
CREATE POLICY "visits_company_access" ON visits
FOR ALL USING (
  company_id IN (
    SELECT company_id FROM profiles 
    WHERE id = auth.uid() 
    AND company_id IS NOT NULL
  )
)
WITH CHECK (
  company_id IN (
    SELECT company_id FROM profiles 
    WHERE id = auth.uid() 
    AND company_id IS NOT NULL
  )
);

-- =========================
-- 5) VERIFICAR QUE LAS POLÍTICAS SE CREARON CORRECTAMENTE
-- =========================

-- Verificar políticas de profiles
SELECT 
  'profiles' as table_name,
  policyname,
  cmd,
  qual
FROM pg_policies 
WHERE tablename = 'profiles'
ORDER BY policyname;

-- Verificar políticas de companies
SELECT 
  'companies' as table_name,
  policyname,
  cmd,
  qual
FROM pg_policies 
WHERE tablename = 'companies'
ORDER BY policyname;

-- Verificar políticas de otras tablas
SELECT 
  tablename,
  policyname,
  cmd,
  qual
FROM pg_policies 
WHERE tablename IN ('customers', 'orders', 'visits')
ORDER BY tablename, policyname;

-- =========================
-- 6) FUNCIÓN PARA VERIFICAR POLÍTICAS
-- =========================

-- Función para verificar que las políticas están funcionando
CREATE OR REPLACE FUNCTION check_rls_policies()
RETURNS TABLE (
  table_name TEXT,
  policy_count INTEGER,
  policies TEXT[]
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    t.table_name::TEXT,
    COUNT(p.policyname)::INTEGER,
    ARRAY_AGG(p.policyname)::TEXT[]
  FROM information_schema.tables t
  LEFT JOIN pg_policies p ON p.tablename = t.table_name
  WHERE t.table_name IN ('profiles', 'companies', 'customers', 'orders', 'visits')
    AND t.table_schema = 'public'
  GROUP BY t.table_name
  ORDER BY t.table_name;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =========================
-- 7) MENSAJE DE ÉXITO
-- =========================

DO $$
BEGIN
  RAISE NOTICE '========================================';
  RAISE NOTICE 'RECURSIÓN INFINITA ELIMINADA EXITOSAMENTE';
  RAISE NOTICE '========================================';
  RAISE NOTICE 'Políticas problemáticas: ELIMINADAS';
  RAISE NOTICE 'Nuevas políticas seguras: CREADAS';
  RAISE NOTICE 'Tablas protegidas: profiles, companies, customers, orders, visits';
  RAISE NOTICE 'Operaciones permitidas: SELECT, INSERT, UPDATE, DELETE';
  RAISE NOTICE 'Recursión: ELIMINADA COMPLETAMENTE';
  RAISE NOTICE '========================================';
  RAISE NOTICE 'Próximos pasos:';
  RAISE NOTICE '1. Verificar que las políticas se crearon correctamente';
  RAISE NOTICE '2. Probar el registro de usuarios';
  RAISE NOTICE '3. Verificar que se crean compañías automáticamente';
  RAISE NOTICE '========================================';
END $$;
