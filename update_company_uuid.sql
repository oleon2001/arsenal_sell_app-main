-- Script para actualizar el UUID de la empresa en Arsenal Sell App
-- Ejecutar este script en el SQL Editor de Supabase

-- 1. Actualizar la empresa existente con el UUID correcto
UPDATE companies 
SET id = '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID
WHERE id = '00000000-0000-0000-0000-000000000001'::UUID;

-- 2. Actualizar todos los perfiles de usuario para usar el nuevo UUID de empresa
UPDATE profiles 
SET company_id = '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID
WHERE company_id = '00000000-0000-0000-0000-000000000001'::UUID;

-- 3. Actualizar todos los clientes para usar el nuevo UUID de empresa
UPDATE customers 
SET company_id = '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID
WHERE company_id = '00000000-0000-0000-0000-000000000001'::UUID;

-- 4. Actualizar todos los productos para usar el nuevo UUID de empresa
UPDATE products 
SET company_id = '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID
WHERE company_id = '00000000-0000-0000-0000-000000000001'::UUID;

-- 5. Actualizar todas las visitas para usar el nuevo UUID de empresa
UPDATE visits 
SET company_id = '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID
WHERE company_id = '00000000-0000-0000-0000-000000000001'::UUID;

-- 6. Actualizar todos los pedidos para usar el nuevo UUID de empresa
UPDATE orders 
SET company_id = '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID
WHERE company_id = '00000000-0000-0000-0000-000000000001'::UUID;

-- 7. Actualizar todas las ubicaciones de tracking para usar el nuevo UUID de empresa
UPDATE tracking_locations 
SET company_id = '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID
WHERE company_id = '00000000-0000-0000-0000-000000000001'::UUID;

-- 8. Verificar que los cambios se aplicaron correctamente
SELECT 
  'companies' as table_name,
  COUNT(*) as record_count
FROM companies 
WHERE id = '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID

UNION ALL

SELECT 
  'profiles' as table_name,
  COUNT(*) as record_count
FROM profiles 
WHERE company_id = '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID

UNION ALL

SELECT 
  'customers' as table_name,
  COUNT(*) as record_count
FROM customers 
WHERE company_id = '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID

UNION ALL

SELECT 
  'visits' as table_name,
  COUNT(*) as record_count
FROM visits 
WHERE company_id = '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID

UNION ALL

SELECT 
  'orders' as table_name,
  COUNT(*) as record_count
FROM orders 
WHERE company_id = '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID

UNION ALL

SELECT 
  'tracking_locations' as table_name,
  COUNT(*) as record_count
FROM tracking_locations 
WHERE company_id = '705abd4b-c5a7-4a6b-be9c-e2da93df3987'::UUID;
