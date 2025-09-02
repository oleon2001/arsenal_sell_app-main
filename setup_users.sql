-- Script para configurar usuarios de prueba en Arsenal Sell App
-- Ejecutar este script en el SQL Editor de Supabase

-- IMPORTANTE: Reemplazar los IDs de usuario con los reales de Supabase Auth
-- Los IDs se ven así: 12345678-1234-1234-1234-123456789abc

-- 1. Insertar empresa de prueba
INSERT INTO companies (id, name, code, email, phone, address, is_active)
VALUES (
  '705abd4b-c5a7-4a6b-be9c-e2da93df3987',
  'Arsenal Sell App',
  'ARSENAL',
  'admin@arsenal.com',
  '+58-412-1234567',
  'Valencia, Venezuela',
  true
);

-- 2. Insertar usuarios de prueba
-- REEMPLAZAR LOS IDs CON LOS REALES DE SUPABASE AUTH

-- Usuario Oswaldo (Vendedor)
-- ID real: ded361c8-79d3-4c74-97df-5daf3e2bd7c7
INSERT INTO profiles (id, company_id, full_name, phone, email, role, is_active)
VALUES (
  'ded361c8-79d3-4c74-97df-5daf3e2bd7c7',
  '705abd4b-c5a7-4a6b-be9c-e2da93df3987',
  'Oswaldo León',
  '+58-412-1234567',
  'oswaldoleon72@gmail.com',
  'VENDEDOR',
  true
);

-- Usuario Admin
-- ID real: 377afcbe-9845-4d36-b787-333f02898a0f
INSERT INTO profiles (id, company_id, full_name, phone, email, role, is_active)
VALUES (
  '377afcbe-9845-4d36-b787-333f02898a0f',
  '705abd4b-c5a7-4a6b-be9c-e2da93df3987',
  'Administrador',
  '+58-412-1234568',
  'admin@arsenal.com',
  'ADMIN',
  true
);

-- Usuario Supervisor
-- ID real: [REEMPLAZAR_CON_ID_REAL_DE_SUPERVISOR]
INSERT INTO profiles (id, company_id, full_name, phone, email, role, is_active)
VALUES (
  'REEMPLAZAR_CON_ID_REAL_DE_SUPERVISOR', -- Ejemplo: '11111111-2222-3333-4444-555555555555'
  '705abd4b-c5a7-4a6b-be9c-e2da93df3987',
  'Supervisor',
  '+58-412-1234569',
  'supervisor@arsenal.com',
  'SUPERVISOR',
  true
);

-- Usuario Repartidor
-- ID real: [REEMPLAZAR_CON_ID_REAL_DE_REPARTIDOR]
INSERT INTO profiles (id, company_id, full_name, phone, email, role, is_active)
VALUES (
  'REEMPLAZAR_CON_ID_REAL_DE_REPARTIDOR', -- Ejemplo: 'aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee'
  '705abd4b-c5a7-4a6b-be9c-e2da93df3987',
  'Repartidor',
  '+58-412-1234570',
  'repartidor@arsenal.com',
  'REPARTIDOR',
  true
);

-- 3. Verificar la inserción
SELECT 
  p.id,
  p.full_name,
  p.email,
  p.role,
  p.is_active,
  c.name as company_name
FROM profiles p
JOIN companies c ON p.company_id = c.id
ORDER BY p.role, p.full_name;
