-- ========================================
-- ARSENAL SELL ADMIN - ESQUEMA COMPLETO
-- ========================================

-- Habilitar PostGIS para funcionalidades geoespaciales
CREATE EXTENSION IF NOT EXISTS "postgis";

-- Habilitar pgcrypto para funciones criptográficas
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- =========================
-- 2) ENUMS DEL SISTEMA
-- =========================

-- Roles de usuario
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'user_role') THEN
    CREATE TYPE user_role AS ENUM (
      'ADMIN',
      'SUPERVISOR', 
      'VENDEDOR',
      'REPARTIDOR'
    );
  END IF;
END $$;

-- Propósitos de visita
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'visit_purpose') THEN
    CREATE TYPE visit_purpose AS ENUM (
      'VENTA',
      'COBRO',
      'ENTREGA',
      'VISITA',
      'AUDITORIA',
      'DEVOLUCION',
      'OTRO'
    );
  END IF;
END $$;

-- Estados de pedido
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'order_status') THEN
    CREATE TYPE order_status AS ENUM (
      'DRAFT',
      'SENT',
      'APPROVED',
      'REJECTED',
      'DELIVERED',
      'CANCELLED'
    );
  END IF;
END $$;

-- Estados de entrega
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'delivery_status') THEN
    CREATE TYPE delivery_status AS ENUM (
      'PENDING',
      'PARTIAL',
      'DELIVERED',
      'REJECTED'
    );
  END IF;
END $$;

-- Tipos de movimiento de inventario
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'inventory_movement_type') THEN
    CREATE TYPE inventory_movement_type AS ENUM (
      'PURCHASE',      -- Compra
      'SALE',          -- Venta
      'ADJUSTMENT',    -- Ajuste manual
      'TRANSFER_IN',   -- Transferencia entrada
      'TRANSFER_OUT',  -- Transferencia salida
      'RETURN',        -- Devolución
      'DAMAGED',       -- Dañado
      'EXPIRED',       -- Vencido
      'LOSS',          -- Pérdida
      'INITIAL'        -- Stock inicial
    );
  END IF;
END $$;

-- Estados de transferencia
DO $$ 
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'transfer_status') THEN
    CREATE TYPE transfer_status AS ENUM (
      'PENDING',
      'IN_TRANSIT',
      'COMPLETED',
      'CANCELLED'
    );
  END IF;
END $$;

-- =========================
-- 3) TABLAS DE ORGANIZACIÓN
-- =========================

-- Compañías
CREATE TABLE IF NOT EXISTS companies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Almacenes
CREATE TABLE IF NOT EXISTS warehouses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  address TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Perfiles de usuario (vinculados a auth.users)
CREATE TABLE IF NOT EXISTS profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  company_id UUID REFERENCES companies(id) ON DELETE SET NULL,
  full_name TEXT,
  phone TEXT,
  role user_role NOT NULL DEFAULT 'VENDEDOR',
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =========================
-- 4) TABLAS DE CLIENTES Y GEOGRAFÍA
-- =========================

-- Clientes
CREATE TABLE IF NOT EXISTS customers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  code TEXT UNIQUE,
  name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  address TEXT,
  -- Punto geográfico: WGS84
  location GEOGRAPHY(POINT, 4326),
  geo_accuracy_m NUMERIC,
  created_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Geocercas por vendedor
CREATE TABLE IF NOT EXISTS geofences (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  owner_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  radius_m INTEGER NOT NULL DEFAULT 10,
  center GEOGRAPHY(POINT, 4326) NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =========================
-- 5) TABLAS DE PLANIFICACIÓN
-- =========================

-- Rutas
CREATE TABLE IF NOT EXISTS routes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  date DATE NOT NULL,
  owner_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Paradas de ruta
CREATE TABLE IF NOT EXISTS route_stops (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  route_id UUID REFERENCES routes(id) ON DELETE CASCADE,
  customer_id UUID REFERENCES customers(id) ON DELETE CASCADE,
  planned_time TIMESTAMPTZ,
  sequence INTEGER,
  notes TEXT
);

-- =========================
-- 6) TABLAS DE VISITAS Y EVIDENCIAS
-- =========================

-- Visitas
CREATE TABLE IF NOT EXISTS visits (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  customer_id UUID REFERENCES customers(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  purpose visit_purpose NOT NULL,
  started_at TIMESTAMPTZ DEFAULT NOW(),
  finished_at TIMESTAMPTZ,
  -- Puntos reales de check-in/out
  checkin GEOGRAPHY(POINT, 4326),
  checkout GEOGRAPHY(POINT, 4326),
  checkin_accuracy_m NUMERIC,
  checkout_accuracy_m NUMERIC,
  distance_m NUMERIC,
  notes TEXT,
  is_synced BOOLEAN DEFAULT FALSE
);

-- Fotos de visita
CREATE TABLE IF NOT EXISTS visit_photos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  visit_id UUID REFERENCES visits(id) ON DELETE CASCADE,
  storage_path TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Firmas de visita
CREATE TABLE IF NOT EXISTS visit_signatures (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  visit_id UUID REFERENCES visits(id) ON DELETE CASCADE,
  storage_path TEXT NOT NULL,
  signed_by TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =========================
-- 7) TABLAS DE PRODUCTOS Y PRECIOS
-- =========================

-- Productos
CREATE TABLE IF NOT EXISTS products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  sku TEXT UNIQUE,
  name TEXT NOT NULL,
  unit TEXT,
  tax NUMERIC DEFAULT 0,
  active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Listas de precios
CREATE TABLE IF NOT EXISTS price_lists (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  currency TEXT DEFAULT 'USD',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Precios por producto
CREATE TABLE IF NOT EXISTS prices (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  price_list_id UUID REFERENCES price_lists(id) ON DELETE CASCADE,
  product_id UUID REFERENCES products(id) ON DELETE CASCADE,
  price NUMERIC NOT NULL,
  UNIQUE(price_list_id, product_id)
);

-- Promociones
CREATE TABLE IF NOT EXISTS promotions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  starts_at DATE,
  ends_at DATE,
  json_rules JSONB NOT NULL, -- Reglas Bx1y, descuentos, etc.
  active BOOLEAN DEFAULT TRUE
);

-- =========================
-- 8) TABLAS DE VENTAS Y ENTREGAS
-- =========================

-- Pedidos
CREATE TABLE IF NOT EXISTS orders (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  customer_id UUID REFERENCES customers(id) ON DELETE SET NULL,
  user_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  price_list_id UUID REFERENCES price_lists(id) ON DELETE SET NULL,
  status order_status NOT NULL DEFAULT 'DRAFT',
  subtotal NUMERIC DEFAULT 0,
  tax_total NUMERIC DEFAULT 0,
  discount_total NUMERIC DEFAULT 0,
  grand_total NUMERIC DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Items de pedido
CREATE TABLE IF NOT EXISTS order_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
  product_id UUID REFERENCES products(id) ON DELETE RESTRICT,
  qty NUMERIC NOT NULL,
  price NUMERIC NOT NULL,
  discount NUMERIC DEFAULT 0,
  total NUMERIC NOT NULL
);

-- Entregas
CREATE TABLE IF NOT EXISTS deliveries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
  status delivery_status NOT NULL DEFAULT 'PENDING',
  delivered_at TIMESTAMPTZ,
  notes TEXT
);

-- Pagos
CREATE TABLE IF NOT EXISTS payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id UUID REFERENCES orders(id) ON DELETE SET NULL,
  customer_id UUID REFERENCES customers(id) ON DELETE SET NULL,
  user_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  amount NUMERIC NOT NULL,
  method TEXT,
  paid_at TIMESTAMPTZ DEFAULT NOW(),
  notes TEXT
);

-- Devoluciones
CREATE TABLE IF NOT EXISTS returns (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id UUID REFERENCES orders(id) ON DELETE SET NULL,
  product_id UUID REFERENCES products(id) ON DELETE SET NULL,
  qty NUMERIC NOT NULL,
  reason TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =========================
-- 9) TABLAS DE FORMULARIOS DINÁMICOS
-- =========================

-- Plantillas de formulario
CREATE TABLE IF NOT EXISTS form_templates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  schema JSONB NOT NULL, -- JSON Schema o definición propia
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Respuestas de formulario
CREATE TABLE IF NOT EXISTS form_responses (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  template_id UUID REFERENCES form_templates(id) ON DELETE SET NULL,
  customer_id UUID REFERENCES customers(id) ON DELETE SET NULL,
  visit_id UUID REFERENCES visits(id) ON DELETE SET NULL,
  user_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  answers JSONB NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =========================
-- 10) TABLAS DE SEGUIMIENTO EN TIEMPO REAL
-- =========================

-- Ubicaciones de seguimiento
CREATE TABLE IF NOT EXISTS tracking_locations (
  id BIGSERIAL PRIMARY KEY,
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  point GEOGRAPHY(POINT, 4326) NOT NULL,
  speed_m_s NUMERIC,
  accuracy_m NUMERIC
);

-- =========================
-- 11) TABLAS DE AUDITORÍA
-- =========================

-- Bitácora de auditoría
CREATE TABLE IF NOT EXISTS audit_logs (
  id BIGSERIAL PRIMARY KEY,
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  actor_id UUID REFERENCES profiles(id),
  action TEXT NOT NULL,
  entity TEXT,
  entity_id TEXT,
  details JSONB,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =========================
-- 12) TABLAS DE INVENTARIO
-- =========================

-- Inventario por almacén
CREATE TABLE IF NOT EXISTS inventories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  warehouse_id UUID REFERENCES warehouses(id) ON DELETE CASCADE,
  product_id UUID REFERENCES products(id) ON DELETE CASCADE,
  current_stock NUMERIC NOT NULL DEFAULT 0,
  reserved_stock NUMERIC NOT NULL DEFAULT 0,
  available_stock NUMERIC GENERATED ALWAYS AS (current_stock - reserved_stock) STORED,
  min_stock NUMERIC DEFAULT 0,
  max_stock NUMERIC,
  reorder_point NUMERIC,
  unit_cost NUMERIC DEFAULT 0,
  last_updated TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(warehouse_id, product_id)
);

-- Movimientos de inventario
CREATE TABLE IF NOT EXISTS inventory_movements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  warehouse_id UUID REFERENCES warehouses(id) ON DELETE CASCADE,
  product_id UUID REFERENCES products(id) ON DELETE CASCADE,
  movement_type inventory_movement_type NOT NULL,
  quantity NUMERIC NOT NULL,
  unit_cost NUMERIC DEFAULT 0,
  total_cost NUMERIC GENERATED ALWAYS AS (quantity * unit_cost) STORED,
  reference_id UUID, -- ID de pedido, transferencia, etc.
  reference_type TEXT, -- 'order', 'transfer', 'adjustment', etc.
  notes TEXT,
  created_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Transferencias entre almacenes
CREATE TABLE IF NOT EXISTS inventory_transfers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  from_warehouse_id UUID REFERENCES warehouses(id) ON DELETE CASCADE,
  to_warehouse_id UUID REFERENCES warehouses(id) ON DELETE CASCADE,
  status transfer_status DEFAULT 'PENDING',
  requested_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
  approved_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
  shipped_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
  received_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
  requested_at TIMESTAMPTZ DEFAULT NOW(),
  approved_at TIMESTAMPTZ,
  shipped_at TIMESTAMPTZ,
  received_at TIMESTAMPTZ,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Items de transferencia
CREATE TABLE IF NOT EXISTS transfer_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  transfer_id UUID REFERENCES inventory_transfers(id) ON DELETE CASCADE,
  product_id UUID REFERENCES products(id) ON DELETE CASCADE,
  quantity NUMERIC NOT NULL,
  transferred_quantity NUMERIC DEFAULT 0,
  unit_cost NUMERIC DEFAULT 0,
  notes TEXT
);

-- Alertas de inventario
CREATE TABLE IF NOT EXISTS inventory_alerts (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  warehouse_id UUID REFERENCES warehouses(id) ON DELETE CASCADE,
  product_id UUID REFERENCES products(id) ON DELETE CASCADE,
  alert_type TEXT NOT NULL CHECK (alert_type IN ('LOW_STOCK', 'OUT_OF_STOCK', 'OVERSTOCK', 'EXPIRING_SOON')),
  threshold NUMERIC,
  current_value NUMERIC,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  resolved_at TIMESTAMPTZ,
  resolved_by UUID REFERENCES profiles(id) ON DELETE SET NULL
);

-- Configuración de alertas por producto
CREATE TABLE IF NOT EXISTS product_alert_config (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
  product_id UUID REFERENCES products(id) ON DELETE CASCADE,
  low_stock_threshold NUMERIC DEFAULT 10,
  out_of_stock_threshold NUMERIC DEFAULT 0,
  overstock_threshold NUMERIC,
  expiring_days_threshold INTEGER DEFAULT 30,
  enable_low_stock_alert BOOLEAN DEFAULT TRUE,
  enable_out_of_stock_alert BOOLEAN DEFAULT TRUE,
  enable_overstock_alert BOOLEAN DEFAULT FALSE,
  enable_expiring_alert BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(product_id)
);

-- =========================
-- 13) TABLAS DE EMAIL Y NOTIFICACIONES
-- =========================

-- Cola de emails
CREATE TABLE IF NOT EXISTS email_queue (
  id BIGSERIAL PRIMARY KEY,
  to_email TEXT NOT NULL,
  subject TEXT NOT NULL,
  body TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  sent_at TIMESTAMPTZ
);

-- =========================
-- 14) ÍNDICES PARA OPTIMIZACIÓN
-- =========================

-- Índices de clientes
CREATE INDEX IF NOT EXISTS customers_company_idx ON customers(company_id);
CREATE INDEX IF NOT EXISTS customers_loc_idx ON customers USING GIST (location);

-- Índices de visitas
CREATE INDEX IF NOT EXISTS visits_company_idx ON visits(company_id);
CREATE INDEX IF NOT EXISTS visits_customer_idx ON visits(customer_id);
CREATE INDEX IF NOT EXISTS visits_user_idx ON visits(user_id);
CREATE INDEX IF NOT EXISTS visits_date_idx ON visits(started_at);

-- Índices de pedidos
CREATE INDEX IF NOT EXISTS orders_company_idx ON orders(company_id);
CREATE INDEX IF NOT EXISTS orders_customer_idx ON orders(customer_id);
CREATE INDEX IF NOT EXISTS orders_user_idx ON orders(user_id);
CREATE INDEX IF NOT EXISTS orders_status_idx ON orders(status);
CREATE INDEX IF NOT EXISTS orders_date_idx ON orders(created_at);

-- Índices de inventario
CREATE INDEX IF NOT EXISTS inventories_warehouse_idx ON inventories(warehouse_id);
CREATE INDEX IF NOT EXISTS inventories_product_idx ON inventories(product_id);
CREATE INDEX IF NOT EXISTS inventories_company_idx ON inventories(company_id);
CREATE INDEX IF NOT EXISTS inventories_stock_idx ON inventories(available_stock);

CREATE INDEX IF NOT EXISTS inventory_movements_warehouse_idx ON inventory_movements(warehouse_id);
CREATE INDEX IF NOT EXISTS inventory_movements_product_idx ON inventory_movements(product_id);
CREATE INDEX IF NOT EXISTS inventory_movements_type_idx ON inventory_movements(movement_type);
CREATE INDEX IF NOT EXISTS inventory_movements_date_idx ON inventory_movements(created_at);
CREATE INDEX IF NOT EXISTS inventory_movements_reference_idx ON inventory_movements(reference_type, reference_id);

CREATE INDEX IF NOT EXISTS inventory_transfers_from_idx ON inventory_transfers(from_warehouse_id);
CREATE INDEX IF NOT EXISTS inventory_transfers_to_idx ON inventory_transfers(to_warehouse_id);
CREATE INDEX IF NOT EXISTS inventory_transfers_status_idx ON inventory_transfers(status);
CREATE INDEX IF NOT EXISTS inventory_transfers_date_idx ON inventory_transfers(created_at);

CREATE INDEX IF NOT EXISTS inventory_alerts_active_idx ON inventory_alerts(is_active);
CREATE INDEX IF NOT EXISTS inventory_alerts_type_idx ON inventory_alerts(alert_type);
CREATE INDEX IF NOT EXISTS inventory_alerts_date_idx ON inventory_alerts(created_at);

-- Índices de seguimiento
CREATE INDEX IF NOT EXISTS tracking_user_time_idx ON tracking_locations(user_id, at DESC);
CREATE INDEX IF NOT EXISTS tracking_point_idx ON tracking_locations USING GIST(point);

-- =========================
-- 15) ROW LEVEL SECURITY (RLS)
-- =========================

-- Habilitar RLS en todas las tablas
ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE warehouses ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE geofences ENABLE ROW LEVEL SECURITY;
ALTER TABLE routes ENABLE ROW LEVEL SECURITY;
ALTER TABLE route_stops ENABLE ROW LEVEL SECURITY;
ALTER TABLE visits ENABLE ROW LEVEL SECURITY;
ALTER TABLE visit_photos ENABLE ROW LEVEL SECURITY;
ALTER TABLE visit_signatures ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE price_lists ENABLE ROW LEVEL SECURITY;
ALTER TABLE prices ENABLE ROW LEVEL SECURITY;
ALTER TABLE promotions ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE deliveries ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE returns ENABLE ROW LEVEL SECURITY;
ALTER TABLE form_templates ENABLE ROW LEVEL SECURITY;
ALTER TABLE form_responses ENABLE ROW LEVEL SECURITY;
ALTER TABLE tracking_locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE audit_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventories ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_movements ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_transfers ENABLE ROW LEVEL SECURITY;
ALTER TABLE transfer_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory_alerts ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_alert_config ENABLE ROW LEVEL SECURITY;
ALTER TABLE email_queue ENABLE ROW LEVEL SECURITY;

-- =========================
-- 16) VISTA AUXILIAR PARA RLS
-- =========================

-- Vista helper para obtener información del usuario actual
CREATE OR REPLACE VIEW me AS
SELECT p.*, au.email
FROM profiles p
JOIN auth.users au ON au.id = p.id
WHERE p.id = auth.uid();

-- =========================
-- 17) POLÍTICAS RLS BÁSICAS
-- =========================

-- Política genérica: ver solo registros de mi compañía
CREATE POLICY "company_read" ON customers
FOR SELECT USING (company_id = (SELECT company_id FROM me));

CREATE POLICY "company_rw_customers" ON customers
FOR ALL USING (company_id = (SELECT company_id FROM me))
WITH CHECK (company_id = (SELECT company_id FROM me));

CREATE POLICY "company_rw_orders" ON orders
FOR ALL USING (company_id = (SELECT company_id FROM me))
WITH CHECK (company_id = (SELECT company_id FROM me));

CREATE POLICY "company_rw_visits" ON visits
FOR ALL USING (company_id = (SELECT company_id FROM me))
WITH CHECK (company_id = (SELECT company_id FROM me));

CREATE POLICY "company_rw_tracking" ON tracking_locations
FOR ALL USING (company_id = (SELECT company_id FROM me))
WITH CHECK (company_id = (SELECT company_id FROM me));

CREATE POLICY "company_rw_inventories" ON inventories
FOR ALL USING (company_id = (SELECT company_id FROM me))
WITH CHECK (company_id = (SELECT company_id FROM me));

CREATE POLICY "company_rw_inventory_movements" ON inventory_movements
FOR ALL USING (company_id = (SELECT company_id FROM me))
WITH CHECK (company_id = (SELECT company_id FROM me));

-- Solo ADMIN/SUPERVISOR pueden escribir plantillas y promociones
CREATE POLICY "forms_admin_write" ON form_templates
FOR INSERT WITH CHECK ((SELECT role FROM me) IN ('ADMIN','SUPERVISOR'));

CREATE POLICY "forms_admin_update" ON form_templates
FOR UPDATE USING ((SELECT role FROM me) IN ('ADMIN','SUPERVISOR'))
WITH CHECK ((SELECT role FROM me) IN ('ADMIN','SUPERVISOR'));

-- =========================
-- 18) FUNCIONES Y TRIGGERS
-- =========================

-- Función para auto-asignar company_id
CREATE OR REPLACE FUNCTION set_company_id()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.company_id IS NULL THEN
    NEW.company_id := (SELECT company_id FROM profiles WHERE id = auth.uid());
  END IF;
  RETURN NEW;
END $$ LANGUAGE plpgsql;

-- Triggers para auto-asignar company_id
CREATE TRIGGER trg_set_company_customers
  BEFORE INSERT ON customers
  FOR EACH ROW EXECUTE FUNCTION set_company_id();

CREATE TRIGGER trg_set_company_orders
  BEFORE INSERT ON orders
  FOR EACH ROW EXECUTE FUNCTION set_company_id();

CREATE TRIGGER trg_set_company_visits
  BEFORE INSERT ON visits
  FOR EACH ROW EXECUTE FUNCTION set_company_id();

CREATE TRIGGER trg_set_company_tracking
  BEFORE INSERT ON tracking_locations
  FOR EACH ROW EXECUTE FUNCTION set_company_id();

CREATE TRIGGER trg_set_company_inventory_movements
  BEFORE INSERT ON inventory_movements
  FOR EACH ROW EXECUTE FUNCTION set_company_id();

-- Función para validar geocerca de visitas
CREATE OR REPLACE FUNCTION validate_visit_geofence()
RETURNS TRIGGER AS $$
DECLARE
  cust_point GEOGRAPHY(POINT, 4326);
  radius_m INTEGER := 10;
BEGIN
  SELECT location INTO cust_point FROM customers WHERE id = NEW.customer_id;
  IF cust_point IS NULL THEN
    RETURN NEW;
  END IF;

  -- Si existe geofence personalizada para el usuario, sobrescribir radio/centro
  SELECT radius_m, center INTO radius_m, cust_point
  FROM geofences
  WHERE owner_id = NEW.user_id
  ORDER BY created_at DESC
  LIMIT 1;

  IF NEW.checkin IS NOT NULL AND cust_point IS NOT NULL THEN
    IF ST_Distance(NEW.checkin, cust_point) > radius_m THEN
      RAISE EXCEPTION 'Check-in fuera de geocerca (%.2f m > % m)', ST_Distance(NEW.checkin, cust_point), radius_m;
    END IF;
  END IF;
  RETURN NEW;
END $$ LANGUAGE plpgsql;

-- Trigger para validar geocerca
CREATE TRIGGER trg_validate_visit_geofence
  BEFORE INSERT ON visits
  FOR EACH ROW EXECUTE FUNCTION validate_visit_geofence();

-- Función para recalcular totales de pedido
CREATE OR REPLACE FUNCTION recalc_order_totals(p_order UUID)
RETURNS VOID AS $$
UPDATE orders o SET
  subtotal = COALESCE(x.subtotal, 0),
  tax_total = COALESCE(x.tax_total, 0),
  discount_total = COALESCE(x.discount_total, 0),
  grand_total = COALESCE(x.subtotal, 0) + COALESCE(x.tax_total, 0) - COALESCE(x.discount_total, 0)
FROM (
  SELECT
    oi.order_id,
    SUM(oi.price * oi.qty) AS subtotal,
    SUM(oi.discount) AS discount_total,
    SUM((oi.price * oi.qty - oi.discount) * (COALESCE(p.tax, 0) / 100.0)) AS tax_total
  FROM order_items oi
  LEFT JOIN products p ON p.id = oi.product_id
  WHERE oi.order_id = p_order
  GROUP BY oi.order_id
) x
WHERE o.id = x.order_id;
$$ LANGUAGE sql;

-- Trigger para recalcular totales
CREATE OR REPLACE FUNCTION trg_recalc_order_totals()
RETURNS TRIGGER AS $$
BEGIN
  PERFORM recalc_order_totals(NEW.order_id);
  RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE TRIGGER order_items_after_iud
  AFTER INSERT OR UPDATE OR DELETE ON order_items
  FOR EACH ROW EXECUTE FUNCTION trg_recalc_order_totals();

-- Función para actualizar stock automáticamente
CREATE OR REPLACE FUNCTION update_inventory_stock()
RETURNS TRIGGER AS $$
BEGIN
  -- Actualizar inventario
  INSERT INTO inventories (company_id, warehouse_id, product_id, current_stock, unit_cost)
  VALUES (NEW.company_id, NEW.warehouse_id, NEW.product_id, NEW.quantity, NEW.unit_cost)
  ON CONFLICT (warehouse_id, product_id)
  DO UPDATE SET
    current_stock = inventories.current_stock + NEW.quantity,
    unit_cost = CASE 
      WHEN NEW.quantity > 0 THEN 
        (inventories.current_stock * inventories.unit_cost + NEW.quantity * NEW.unit_cost) / 
        (inventories.current_stock + NEW.quantity)
      ELSE inventories.unit_cost
    END,
    last_updated = NOW();
  
  RETURN NEW;
END $$ LANGUAGE plpgsql;

-- Trigger para actualizar inventario al crear movimientos
CREATE TRIGGER trg_update_inventory_stock
  AFTER INSERT ON inventory_movements
  FOR EACH ROW EXECUTE FUNCTION update_inventory_stock();

-- Función para verificar alertas de inventario
CREATE OR REPLACE FUNCTION check_inventory_alerts()
RETURNS TRIGGER AS $$
DECLARE
  alert_config RECORD;
  current_stock NUMERIC;
BEGIN
  -- Obtener configuración de alertas
  SELECT * INTO alert_config 
  FROM product_alert_config 
  WHERE product_id = NEW.product_id;
  
  IF NOT FOUND THEN
    -- Usar configuración por defecto
    alert_config.low_stock_threshold := 10;
    alert_config.out_of_stock_threshold := 0;
    alert_config.enable_low_stock_alert := TRUE;
    alert_config.enable_out_of_stock_alert := TRUE;
  END IF;
  
  current_stock := NEW.available_stock;
  
  -- Verificar stock bajo
  IF alert_config.enable_low_stock_alert AND current_stock <= alert_config.low_stock_threshold AND current_stock > 0 THEN
    INSERT INTO inventory_alerts (company_id, warehouse_id, product_id, alert_type, threshold, current_value)
    VALUES (NEW.company_id, NEW.warehouse_id, NEW.product_id, 'LOW_STOCK', alert_config.low_stock_threshold, current_stock)
    ON CONFLICT DO NOTHING;
  END IF;
  
  -- Verificar sin stock
  IF alert_config.enable_out_of_stock_alert AND current_stock <= alert_config.out_of_stock_threshold THEN
    INSERT INTO inventory_alerts (company_id, warehouse_id, product_id, alert_type, threshold, current_value)
    VALUES (NEW.company_id, NEW.warehouse_id, NEW.product_id, 'OUT_OF_STOCK', alert_config.out_of_stock_threshold, current_stock)
    ON CONFLICT DO NOTHING;
  END IF;
  
  RETURN NEW;
END $$ LANGUAGE plpgsql;

-- Trigger para verificar alertas al actualizar inventario
CREATE TRIGGER trg_check_inventory_alerts
  AFTER UPDATE ON inventories
  FOR EACH ROW EXECUTE FUNCTION check_inventory_alerts();

-- Función para reservar stock
CREATE OR REPLACE FUNCTION reserve_stock(
  p_warehouse_id UUID,
  p_product_id UUID,
  p_quantity NUMERIC
)
RETURNS BOOLEAN AS $$
DECLARE
  available NUMERIC;
BEGIN
  -- Verificar stock disponible
  SELECT available_stock INTO available
  FROM inventories
  WHERE warehouse_id = p_warehouse_id AND product_id = p_product_id;
  
  IF NOT FOUND OR available < p_quantity THEN
    RETURN FALSE;
  END IF;
  
  -- Reservar stock
  UPDATE inventories
  SET reserved_stock = reserved_stock + p_quantity
  WHERE warehouse_id = p_warehouse_id AND product_id = p_product_id;
  
  RETURN TRUE;
END $$ LANGUAGE plpgsql;

-- Función para liberar stock reservado
CREATE OR REPLACE FUNCTION release_stock(
  p_warehouse_id UUID,
  p_product_id UUID,
  p_quantity NUMERIC
)
RETURNS BOOLEAN AS $$
BEGIN
  UPDATE inventories
  SET reserved_stock = GREATEST(0, reserved_stock - p_quantity)
  WHERE warehouse_id = p_warehouse_id AND product_id = p_product_id;
  
  RETURN FOUND;
END $$ LANGUAGE plpgsql;

-- Función para consumir stock (venta)
CREATE OR REPLACE FUNCTION consume_stock(
  p_warehouse_id UUID,
  p_product_id UUID,
  p_quantity NUMERIC
)
RETURNS BOOLEAN AS $$
BEGIN
  UPDATE inventories
  SET 
    current_stock = current_stock - p_quantity,
    reserved_stock = GREATEST(0, reserved_stock - p_quantity)
  WHERE warehouse_id = p_warehouse_id 
    AND product_id = p_product_id
    AND available_stock >= p_quantity;
  
  RETURN FOUND;
END $$ LANGUAGE plpgsql;

-- Función para encolar email de visita
CREATE OR REPLACE FUNCTION enqueue_visit_email(p_visit UUID)
RETURNS VOID AS $$
DECLARE
  v_rec RECORD;
BEGIN
  SELECT v.id, c.email, c.name, v.started_at, v.finished_at
  INTO v_rec
  FROM visits v
  JOIN customers c ON c.id = v.customer_id
  WHERE v.id = p_visit;

  IF v_rec.email IS NULL THEN RETURN; END IF;

  INSERT INTO email_queue(to_email, subject, body)
  VALUES (
    v_rec.email,
    'Resumen de visita',
    'Visita #'||v_rec.id||' a '||v_rec.name||' iniciada '||v_rec.started_at||' finalizada '||v_rec.finished_at
  );
END $$ LANGUAGE plpgsql;

-- Función para enviar email al finalizar visita
CREATE OR REPLACE FUNCTION send_email_on_visit_finish()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.finished_at IS NOT NULL AND (OLD.finished_at IS NULL OR OLD.finished_at <> NEW.finished_at) THEN
    PERFORM enqueue_visit_email(NEW.id);
  END IF;
  RETURN NEW;
END $$ LANGUAGE plpgsql;

-- Trigger para enviar email al finalizar visita
CREATE TRIGGER trg_visit_email
  AFTER UPDATE ON visits
  FOR EACH ROW EXECUTE FUNCTION send_email_on_visit_finish();

-- =========================
-- 19) VISTAS PARA REPORTES
-- =========================

-- Vista de inventario con información completa
CREATE OR REPLACE VIEW inventory_summary AS
SELECT 
  i.id,
  i.company_id,
  i.warehouse_id,
  i.product_id,
  w.name AS warehouse_name,
  p.name AS product_name,
  p.sku,
  p.unit,
  i.current_stock,
  i.reserved_stock,
  i.available_stock,
  i.min_stock,
  i.max_stock,
  i.reorder_point,
  i.unit_cost,
  (i.current_stock * i.unit_cost) AS total_value,
  i.last_updated,
  CASE 
    WHEN i.available_stock <= i.min_stock THEN 'LOW_STOCK'
    WHEN i.available_stock = 0 THEN 'OUT_OF_STOCK'
    WHEN i.available_stock >= COALESCE(i.max_stock, 999999) THEN 'OVERSTOCK'
    ELSE 'NORMAL'
  END AS stock_status
FROM inventories i
JOIN warehouses w ON w.id = i.warehouse_id
JOIN products p ON p.id = i.product_id;

-- Vista de movimientos con información detallada
CREATE OR REPLACE VIEW inventory_movements_detail AS
SELECT 
  im.id,
  im.company_id,
  im.warehouse_id,
  im.product_id,
  w.name AS warehouse_name,
  p.name AS product_name,
  p.sku,
  im.movement_type,
  im.quantity,
  im.unit_cost,
  im.total_cost,
  im.reference_type,
  im.reference_id,
  im.notes,
  im.created_by,
  prof.full_name AS created_by_name,
  im.created_at
FROM inventory_movements im
JOIN warehouses w ON w.id = im.warehouse_id
JOIN products p ON p.id = im.product_id
LEFT JOIN profiles prof ON prof.id = im.created_by;

-- Vista de alertas activas
CREATE OR REPLACE VIEW active_inventory_alerts AS
SELECT 
  ia.id,
  ia.company_id,
  ia.warehouse_id,
  ia.product_id,
  w.name AS warehouse_name,
  p.name AS product_name,
  p.sku,
  ia.alert_type,
  ia.threshold,
  ia.current_value,
  ia.created_at,
  CASE 
    WHEN ia.alert_type = 'LOW_STOCK' THEN 'Stock bajo'
    WHEN ia.alert_type = 'OUT_OF_STOCK' THEN 'Sin stock'
    WHEN ia.alert_type = 'OVERSTOCK' THEN 'Sobre stock'
    WHEN ia.alert_type = 'EXPIRING_SOON' THEN 'Próximo a vencer'
    ELSE ia.alert_type
  END AS alert_description
FROM inventory_alerts ia
JOIN warehouses w ON w.id = ia.warehouse_id
JOIN products p ON p.id = ia.product_id
WHERE ia.is_active = TRUE AND ia.resolved_at IS NULL;

-- =========================
-- 20) FUNCIONES DE REPORTE
-- =========================

-- Función para obtener reporte de valor de inventario
CREATE OR REPLACE FUNCTION get_inventory_value_report(
  p_company_id UUID,
  p_warehouse_id UUID DEFAULT NULL,
  p_date_from DATE DEFAULT NULL,
  p_date_to DATE DEFAULT NULL
)
RETURNS TABLE (
  warehouse_name TEXT,
  product_name TEXT,
  sku TEXT,
  current_stock NUMERIC,
  unit_cost NUMERIC,
  total_value NUMERIC,
  last_movement_date TIMESTAMPTZ
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    w.name,
    p.name,
    p.sku,
    i.current_stock,
    i.unit_cost,
    (i.current_stock * i.unit_cost) AS total_value,
    i.last_updated
  FROM inventories i
  JOIN warehouses w ON w.id = i.warehouse_id
  JOIN products p ON p.id = i.product_id
  WHERE i.company_id = p_company_id
    AND (p_warehouse_id IS NULL OR i.warehouse_id = p_warehouse_id)
    AND (p_date_from IS NULL OR i.last_updated >= p_date_from)
    AND (p_date_to IS NULL OR i.last_updated <= p_date_to)
  ORDER BY w.name, p.name;
END $$ LANGUAGE plpgsql;

-- Función para obtener movimientos de inventario
CREATE OR REPLACE FUNCTION get_inventory_movements_report(
  p_company_id UUID,
  p_warehouse_id UUID DEFAULT NULL,
  p_product_id UUID DEFAULT NULL,
  p_date_from DATE DEFAULT NULL,
  p_date_to DATE DEFAULT NULL
)
RETURNS TABLE (
  movement_date TIMESTAMPTZ,
  warehouse_name TEXT,
  product_name TEXT,
  movement_type TEXT,
  quantity NUMERIC,
  unit_cost NUMERIC,
  total_cost NUMERIC,
  created_by_name TEXT
) AS $$
BEGIN
  RETURN QUERY
  SELECT 
    im.created_at,
    w.name,
    p.name,
    im.movement_type::TEXT,
    im.quantity,
    im.unit_cost,
    im.total_cost,
    prof.full_name
  FROM inventory_movements im
  JOIN warehouses w ON w.id = im.warehouse_id
  JOIN products p ON p.id = im.product_id
  LEFT JOIN profiles prof ON prof.id = im.created_by
  WHERE im.company_id = p_company_id
    AND (p_warehouse_id IS NULL OR im.warehouse_id = p_warehouse_id)
    AND (p_product_id IS NULL OR im.product_id = p_product_id)
    AND (p_date_from IS NULL OR im.created_at >= p_date_from)
    AND (p_date_to IS NULL OR im.created_at <= p_date_to)
  ORDER BY im.created_at DESC;
END $$ LANGUAGE plpgsql;

-- =========================
-- 21) STORAGE BUCKETS
-- =========================

-- Bucket para fotos de evidencia
INSERT INTO storage.buckets (id, name, public) VALUES
  ('evidence-photos', 'evidence-photos', FALSE)
  ON CONFLICT (id) DO NOTHING;

-- Bucket para firmas
INSERT INTO storage.buckets (id, name, public) VALUES
  ('signatures', 'signatures', FALSE)
  ON CONFLICT (id) DO NOTHING;

-- Bucket para documentos
INSERT INTO storage.buckets (id, name, public) VALUES
  ('documents', 'documents', FALSE)
  ON CONFLICT (id) DO NOTHING;

-- =========================
-- 22) POLÍTICAS DE STORAGE
-- =========================

-- Política de storage por compañía (ruta: company_id/user_id/...)
CREATE POLICY "evidence_read_own_company" ON storage.objects
FOR SELECT USING (
  bucket_id IN ('evidence-photos', 'signatures', 'documents')
  AND (EXISTS (
    SELECT 1 FROM profiles p
    WHERE p.id = auth.uid()
      AND split_part(storage.objects.name, '/', 1) = p.company_id::TEXT
  ))
);

CREATE POLICY "evidence_write_own_company" ON storage.objects
FOR INSERT WITH CHECK (
  bucket_id IN ('evidence-photos', 'signatures', 'documents')
  AND (EXISTS (
    SELECT 1 FROM profiles p
    WHERE p.id = auth.uid()
      AND split_part(name, '/', 1) = p.company_id::TEXT
  ))
);

-- =========================
-- 23) MENSAJE DE ÉXITO
-- =========================

DO $$
BEGIN
  RAISE NOTICE '========================================';
  RAISE NOTICE 'ESQUEMA ARSENAL SELL ADMIN CREADO EXITOSAMENTE';
  RAISE NOTICE '========================================';
  RAISE NOTICE 'Tablas creadas: 25+';
  RAISE NOTICE 'Funciones creadas: 15+';
  RAISE NOTICE 'Triggers creados: 10+';
  RAISE NOTICE 'Vistas creadas: 3';
  RAISE NOTICE 'Índices creados: 20+';
  RAISE NOTICE 'Políticas RLS: 15+';
  RAISE NOTICE '========================================';
  RAISE NOTICE 'Próximos pasos:';
  RAISE NOTICE '1. Crear datos de prueba con: npm run seed:minimal';
  RAISE NOTICE '2. Verificar conexión con: npm run test:connection';
  RAISE NOTICE '3. Iniciar aplicación con: npm run dev';
  RAISE NOTICE '========================================';
END $$;
