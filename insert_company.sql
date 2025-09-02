-- Script para insertar la empresa en Arsenal Sell App
-- Ejecutar este script en el SQL Editor de Supabase

-- 1. Insertar empresa si no existe
INSERT INTO companies (id, name, code, email, phone, address, is_active)
VALUES (
  '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID,
  'Arsenal Sell App',
  'ARSENAL',
  'admin@arsenal.com',
  '+58-412-1234567',
  'Valencia, Venezuela',
  true
) ON CONFLICT (id) DO NOTHING;

-- 2. Verificar que la empresa se insertó correctamente
SELECT 
  id,
  name,
  code,
  email,
  is_active,
  created_at
FROM companies 
WHERE id = '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID;

-- 3. Mostrar todas las empresas (para verificar)
SELECT 
  id,
  name,
  code,
  email,
  is_active,
  created_at
FROM companies 
ORDER BY created_at DESC;
