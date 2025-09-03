-- ========================================
-- SOLUCIÓN ESPECÍFICA PARA INSERT EN PROFILES
-- ========================================
-- 
-- Este script arregla específicamente el problema de INSERT en profiles
-- 
-- INSTRUCCIONES:
-- 1. Ejecutar en Supabase SQL Editor
-- 2. Probar registro de usuarios
-- ========================================

-- =========================
-- 1) VERIFICAR ESTADO ACTUAL
-- =========================

-- Ver qué políticas existen actualmente en profiles
SELECT 
  'profiles' as table_name,
  policyname,
  cmd,
  qual
FROM pg_policies 
WHERE tablename = 'profiles'
ORDER BY policyname;

-- =========================
-- 2) ELIMINAR POLÍTICAS PROBLEMÁTICAS
-- =========================

-- Eliminar TODAS las políticas de profiles
DROP POLICY IF EXISTS "profiles_own_profile_select" ON profiles;
DROP POLICY IF EXISTS "profiles_own_profile_insert" ON profiles;
DROP POLICY IF EXISTS "profiles_own_profile_update" ON profiles;
DROP POLICY IF EXISTS "profiles_own_profile_delete" ON profiles;

-- =========================
-- 3) CREAR POLÍTICAS SIMPLES Y FUNCIONALES
-- =========================

-- Política SIMPLE para SELECT - usuario puede leer su propio perfil
CREATE POLICY "profiles_select_own" ON profiles
FOR SELECT USING (id = auth.uid());

-- Política SIMPLE para INSERT - permitir inserción de perfiles
CREATE POLICY "profiles_allow_insert" ON profiles
FOR INSERT WITH CHECK (true);

-- Política SIMPLE para UPDATE - usuario puede actualizar su propio perfil
CREATE POLICY "profiles_update_own" ON profiles
FOR UPDATE USING (id = auth.uid())
WITH CHECK (id = auth.uid());

-- Política SIMPLE para DELETE - usuario puede eliminar su propio perfil
CREATE POLICY "profiles_delete_own" ON profiles
FOR DELETE USING (id = auth.uid());

-- =========================
-- 4) VERIFICAR QUE SE CREARON
-- =========================

-- Verificar políticas de profiles después de la corrección
SELECT 
  'profiles' as table_name,
  policyname,
  cmd,
  qual
FROM pg_policies 
WHERE tablename = 'profiles'
ORDER BY policyname;

-- =========================
-- 5) MENSAJE DE ÉXITO
-- =========================

DO $$
BEGIN
  RAISE NOTICE '========================================';
  RAISE NOTICE 'POLÍTICAS DE PROFILES CORREGIDAS';
  RAISE NOTICE '========================================';
  RAISE NOTICE 'Políticas anteriores: ELIMINADAS';
  RAISE NOTICE 'Nuevas políticas: CREADAS';
  RAISE NOTICE 'INSERT en profiles: PERMITIDO';
  RAISE NOTICE 'SELECT en profiles: PERMITIDO';
  RAISE NOTICE 'UPDATE en profiles: PERMITIDO';
  RAISE NOTICE 'DELETE en profiles: PERMITIDO';
  RAISE NOTICE '========================================';
  RAISE NOTICE 'Próximo paso: Probar registro de usuarios';
  RAISE NOTICE '========================================';
END $$;
