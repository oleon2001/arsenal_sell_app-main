-- Script para configurar Row Level Security (RLS) en Arsenal Sell App
-- Ejecutar este script en el SQL Editor de Supabase

-- 1. Habilitar RLS en las tablas principales
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE customers ENABLE ROW LEVEL SECURITY;

-- 2. Políticas para la tabla profiles
-- Los usuarios pueden ver su propio perfil
CREATE POLICY "Users can view own profile" ON profiles
  FOR SELECT USING (auth.uid() = id);

-- Los usuarios pueden actualizar su propio perfil
CREATE POLICY "Users can update own profile" ON profiles
  FOR UPDATE USING (auth.uid() = id);

-- Los administradores pueden ver todos los perfiles
CREATE POLICY "Admins can view all profiles" ON profiles
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE id = auth.uid() AND role = 'ADMIN'
    )
  );

-- 3. Políticas para la tabla companies
-- Los usuarios pueden ver su propia empresa
CREATE POLICY "Users can view own company" ON companies
  FOR SELECT USING (id IN (
    SELECT company_id FROM profiles WHERE id = auth.uid()
  ));

-- Los administradores pueden ver todas las empresas
CREATE POLICY "Admins can view all companies" ON companies
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM profiles 
      WHERE id = auth.uid() AND role = 'ADMIN'
    )
  );

-- 4. Políticas para la tabla customers
-- Los usuarios pueden ver clientes de su empresa
CREATE POLICY "Users can view company customers" ON customers
  FOR SELECT USING (company_id IN (
    SELECT company_id FROM profiles WHERE id = auth.uid()
  ));

-- Los usuarios pueden crear clientes en su empresa
CREATE POLICY "Users can create company customers" ON customers
  FOR INSERT WITH CHECK (company_id IN (
    SELECT company_id FROM profiles WHERE id = auth.uid()
  ));

-- Los usuarios pueden actualizar clientes de su empresa
CREATE POLICY "Users can update company customers" ON customers
  FOR UPDATE USING (company_id IN (
    SELECT company_id FROM profiles WHERE id = auth.uid()
  ));

-- 5. Verificar las políticas creadas
SELECT 
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd,
  qual
FROM pg_policies 
WHERE tablename IN ('profiles', 'companies', 'customers')
ORDER BY tablename, policyname;
