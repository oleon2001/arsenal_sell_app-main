Supabase — SQL completo
-- =========================
-- 1) ENUMS Y EXTENSIONES
-- =========================
create extension if not exists postgis;
create extension if not exists pgcrypto;

do $$ begin
  create type user_role as enum ('ADMIN','SUPERVISOR','VENDEDOR','REPARTIDOR');
exception when duplicate_object then null; end $$;

do $$ begin
  create type visit_purpose as enum ('VENTA','COBRO','ENTREGA','VISITA','AUDITORIA','DEVOLUCION','OTRO');
exception when duplicate_object then null; end $$;

do $$ begin
  create type order_status as enum ('DRAFT','SENT','APPROVED','REJECTED','DELIVERED','CANCELLED');
exception when duplicate_object then null; end $$;

do $$ begin
  create type delivery_status as enum ('PENDING','PARTIAL','DELIVERED','REJECTED');
exception when duplicate_object then null; end $$;

-- =========================
-- 2) ORGANIZACIÓN BÁSICA
-- =========================
create table if not exists companies (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  created_at timestamptz default now()
);

create table if not exists warehouses (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  name text not null,
  address text,
  created_at timestamptz default now()
);

-- Perfil vinculado a auth.users
create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  company_id uuid references companies(id) on delete set null,
  full_name text,
  phone text,
  role user_role not null default 'VENDEDOR',
  is_active boolean not null default true,
  created_at timestamptz default now()
);

-- =========================
-- 3) CLIENTES Y GEO
-- =========================
create table if not exists customers (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  code text unique,
  name text not null,
  email text,
  phone text,
  address text,
  -- Geopunto: WGS84
  location geography(Point,4326),
  geo_accuracy_m numeric,
  created_by uuid references profiles(id) on delete set null,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

create index if not exists customers_company_idx on customers(company_id);
create index if not exists customers_loc_idx on customers using gist (location);

-- geocercas opcionales por vendedor
create table if not exists geofences (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  owner_id uuid references profiles(id) on delete cascade,
  radius_m integer not null default 10,
  center geography(Point,4326) not null,
  created_at timestamptz default now()
);

-- =========================
-- 4) PLANIFICACIÓN
-- =========================
create table if not exists routes (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  name text not null,
  date date not null,
  owner_id uuid references profiles(id) on delete set null,
  created_at timestamptz default now()
);

create table if not exists route_stops (
  id uuid primary key default gen_random_uuid(),
  route_id uuid references routes(id) on delete cascade,
  customer_id uuid references customers(id) on delete cascade,
  planned_time timestamptz,
  sequence int,
  notes text
);

create index if not exists route_stops_route_idx on route_stops(route_id);

-- =========================
-- 5) VISITAS, EVIDENCIAS, FIRMAS
-- =========================
create table if not exists visits (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  customer_id uuid references customers(id) on delete cascade,
  user_id uuid references profiles(id) on delete set null,
  purpose visit_purpose not null,
  started_at timestamptz default now(),
  finished_at timestamptz,
  -- punto real de check-in
  checkin geography(Point,4326),
  checkout geography(Point,4326),
  checkin_accuracy_m numeric,
  checkout_accuracy_m numeric,
  distance_m numeric,
  notes text,
  is_synced boolean default false
);

create table if not exists visit_photos (
  id uuid primary key default gen_random_uuid(),
  visit_id uuid references visits(id) on delete cascade,
  storage_path text not null,
  created_at timestamptz default now()
);

create table if not exists visit_signatures (
  id uuid primary key default gen_random_uuid(),
  visit_id uuid references visits(id) on delete cascade,
  storage_path text not null,
  signed_by text,
  created_at timestamptz default now()
);

-- =========================
-- 6) PRODUCTOS, PRECIOS, PROMOS
-- =========================
create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  sku text unique,
  name text not null,
  unit text,
  tax numeric default 0,
  active boolean default true,
  created_at timestamptz default now()
);

create table if not exists price_lists (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  name text not null,
  currency text default 'USD',
  created_at timestamptz default now()
);

create table if not exists prices (
  id uuid primary key default gen_random_uuid(),
  price_list_id uuid references price_lists(id) on delete cascade,
  product_id uuid references products(id) on delete cascade,
  price numeric not null,
  unique(price_list_id, product_id)
);

create table if not exists promotions (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  name text not null,
  starts_at date,
  ends_at date,
  json_rules jsonb not null, -- reglas Bx1y, descuentos, etc.
  active boolean default true
);

-- =========================
-- 7) PEDIDOS, ENTREGAS, COBROS, DEVOLUCIONES
-- =========================
create table if not exists orders (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  customer_id uuid references customers(id) on delete set null,
  user_id uuid references profiles(id) on delete set null,
  price_list_id uuid references price_lists(id) on delete set null,
  status order_status not null default 'DRAFT',
  subtotal numeric default 0,
  tax_total numeric default 0,
  discount_total numeric default 0,
  grand_total numeric default 0,
  created_at timestamptz default now()
);

create table if not exists order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid references orders(id) on delete cascade,
  product_id uuid references products(id) on delete restrict,
  qty numeric not null,
  price numeric not null,
  discount numeric default 0,
  total numeric not null
);

create table if not exists deliveries (
  id uuid primary key default gen_random_uuid(),
  order_id uuid references orders(id) on delete cascade,
  status delivery_status not null default 'PENDING',
  delivered_at timestamptz,
  notes text
);

create table if not exists payments (
  id uuid primary key default gen_random_uuid(),
  order_id uuid references orders(id) on delete set null,
  customer_id uuid references customers(id) on delete set null,
  user_id uuid references profiles(id) on delete set null,
  amount numeric not null,
  method text,
  paid_at timestamptz default now(),
  notes text
);

create table if not exists returns (
  id uuid primary key default gen_random_uuid(),
  order_id uuid references orders(id) on delete set null,
  product_id uuid references products(id) on delete set null,
  qty numeric not null,
  reason text,
  created_at timestamptz default now()
);

-- =========================
-- 8) FORMULARIOS DINÁMICOS / ENCUESTAS
-- =========================
create table if not exists form_templates (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  name text not null,
  schema jsonb not null, -- JSON Schema o definición propia
  created_at timestamptz default now()
);

create table if not exists form_responses (
  id uuid primary key default gen_random_uuid(),
  template_id uuid references form_templates(id) on delete set null,
  customer_id uuid references customers(id) on delete set null,
  visit_id uuid references visits(id) on delete set null,
  user_id uuid references profiles(id) on delete set null,
  answers jsonb not null,
  created_at timestamptz default now()
);

-- =========================
-- 9) TRACKING EN TIEMPO REAL
-- =========================
create table if not exists tracking_locations (
  id bigserial primary key,
  company_id uuid references companies(id) on delete cascade,
  user_id uuid references profiles(id) on delete cascade,
  at timestamptz not null default now(),
  point geography(Point,4326) not null,
  speed_m_s numeric,
  accuracy_m numeric
);

create index if not exists tracking_user_time_idx on tracking_locations(user_id, at desc);
create index if not exists tracking_point_idx on tracking_locations using gist(point);

-- =========================
-- 10) BITÁCORA / AUDITORÍA
-- =========================
create table if not exists audit_logs (
  id bigserial primary key,
  company_id uuid references companies(id) on delete cascade,
  actor_id uuid references profiles(id),
  action text not null,
  entity text,
  entity_id text,
  details jsonb,
  created_at timestamptz default now()
);

-- =========================
-- 11) POLÍTICAS RLS
-- =========================
alter table companies enable row level security;
alter table warehouses enable row level security;
alter table profiles enable row level security;
alter table customers enable row level security;
alter table geofences enable row level security;
alter table routes enable row level security;
alter table route_stops enable row level security;
alter table visits enable row level security;
alter table visit_photos enable row level security;
alter table visit_signatures enable row level security;
alter table products enable row level security;
alter table price_lists enable row level security;
alter table prices enable row level security;
alter table promotions enable row level security;
alter table orders enable row level security;
alter table order_items enable row level security;
alter table deliveries enable row level security;
alter table payments enable row level security;
alter table returns enable row level security;
alter table form_templates enable row level security;
alter table form_responses enable row level security;
alter table tracking_locations enable row level security;
alter table audit_logs enable row level security;

-- helper para compañía del usuario
create or replace view me as
select p.*, au.email
from profiles p
join auth.users au on au.id = p.id
where p.id = auth.uid();

-- política genérica: ver solo registros de mi compañía
create policy "company_read"
on customers for select
using (company_id = (select company_id from me));

-- Repite por tablas clave (ejemplos representativos):
create policy "company_read_profiles" on profiles for select
using (company_id = (select company_id from me));

create policy "company_rw_customers" on customers
for all using (company_id = (select company_id from me))
with check (company_id = (select company_id from me));

create policy "company_rw_orders" on orders
for all using (company_id = (select company_id from me))
with check (company_id = (select company_id from me));

create policy "company_rw_visits" on visits
for all using (company_id = (select company_id from me))
with check (company_id = (select company_id from me));

create policy "company_rw_tracking" on tracking_locations
for all using (company_id = (select company_id from me))
with check (company_id = (select company_id from me));

-- Solo ADMIN/SUPERVISOR pueden escribir plantillas y promociones
create policy "forms_admin_write" on form_templates
for insert with check ((select role from me) in ('ADMIN','SUPERVISOR'));
create policy "forms_admin_update" on form_templates
for update using ((select role from me) in ('ADMIN','SUPERVISOR'))
with check ((select role from me) in ('ADMIN','SUPERVISOR'));

-- =========================
-- 12) FUNCIONES Y TRIGGERS
-- =========================

-- Auto-asignar company_id en tablas donde falte, basado en user
create or replace function set_company_id()
returns trigger as $$
begin
  if new.company_id is null then
    new.company_id := (select company_id from profiles where id = auth.uid());
  end if;
  return new;
end $$ language plpgsql;

create trigger trg_set_company_customers
before insert on customers
for each row execute function set_company_id();

create trigger trg_set_company_orders
before insert on orders
for each row execute function set_company_id();

create trigger trg_set_company_visits
before insert on visits
for each row execute function set_company_id();

create trigger trg_set_company_tracking
before insert on tracking_locations
for each row execute function set_company_id();

-- Validar geocerca de 10m por defecto (se puede ajustar por geofence específica)
create or replace function validate_visit_geofence()
returns trigger as $$
declare
  cust_point geography(Point,4326);
  radius_m int := 10;
begin
  select location into cust_point from customers where id = new.customer_id;
  if cust_point is null then
    return new;
  end if;

  -- si existe geofence personalizada para el usuario, sobrescribir radio/centro
  select radius_m, center into radius_m, cust_point
  from geofences
  where owner_id = new.user_id
  order by created_at desc
  limit 1;

  if new.checkin is not null and cust_point is not null then
    if st_distance(new.checkin, cust_point) > radius_m then
      raise exception 'Check-in fuera de geocerca (%.2f m > % m)', st_distance(new.checkin, cust_point), radius_m;
    end if;
  end if;
  return new;
end $$ language plpgsql;

create trigger trg_validate_visit_geofence
before insert on visits
for each row execute function validate_visit_geofence();

-- Recalcular totales de pedido
create or replace function recalc_order_totals(p_order uuid)
returns void as $$
update orders o set
  subtotal = coalesce(x.subtotal,0),
  tax_total = coalesce(x.tax_total,0),
  discount_total = coalesce(x.discount_total,0),
  grand_total = coalesce(x.subtotal,0) + coalesce(x.tax_total,0) - coalesce(x.discount_total,0)
from (
  select
    oi.order_id,
    sum(oi.price * oi.qty) as subtotal,
    sum(oi.discount) as discount_total,
    sum((oi.price * oi.qty - oi.discount) * (coalesce(p.tax,0)/100.0)) as tax_total
  from order_items oi
  left join products p on p.id = oi.product_id
  where oi.order_id = p_order
  group by oi.order_id
) x
where o.id = x.order_id;
$$ language sql;

create or replace function trg_recalc_order_totals()
returns trigger as $$
begin
  perform recalc_order_totals(new.order_id);
  return new;
end $$ language plpgsql;

create trigger order_items_after_iud
after insert or update or delete on order_items
for each row execute function trg_recalc_order_totals();

-- =========================
-- 13) STORAGE BUCKETS
-- =========================
insert into storage.buckets (id, name, public) values
  ('evidence-photos','evidence-photos', false)
  on conflict (id) do nothing;

insert into storage.buckets (id, name, public) values
  ('signatures','signatures', false)
  on conflict (id) do nothing;

insert into storage.buckets (id, name, public) values
  ('documents','documents', false)
  on conflict (id) do nothing;

-- políticas de storage por compañía (ruta: company_id/user_id/...)
create policy "evidence read own company" on storage.objects
for select using (
  bucket_id in ('evidence-photos','signatures','documents')
  and (exists (
    select 1 from profiles p
    where p.id = auth.uid()
      and split_part(storage.objects.name,'/',1) = p.company_id::text
  ))
);

create policy "evidence write own company" on storage.objects
for insert with check (
  bucket_id in ('evidence-photos','signatures','documents')
  and (exists (
    select 1 from profiles p
    where p.id = auth.uid()
      and split_part(name,'/',1) = p.company_id::text
  ))
);

-- =========================
-- 14) EDGE FUNCTION (RESEND) — disparo de correo al cerrar visita
-- (crea una function de Postgres para encolar, tu Edge Function leerá esta tabla)
-- =========================
create table if not exists email_queue (
  id bigserial primary key,
  to_email text not null,
  subject text not null,
  body text not null,
  created_at timestamptz default now(),
  sent_at timestamptz
);

create or replace function enqueue_visit_email(p_visit uuid)
returns void as $$
declare
  v_rec record;
begin
  select v.id, c.email, c.name, v.started_at, v.finished_at
  into v_rec
  from visits v
  join customers c on c.id = v.customer_id
  where v.id = p_visit;

  if v_rec.email is null then return; end if;

  insert into email_queue(to_email, subject, body)
  values (
    v_rec.email,
    'Resumen de visita',
    'Visita #'||v_rec.id||' a '||v_rec.name||' iniciada '||v_rec.started_at||' finalizada '||v_rec.finished_at
  );
end $$ language plpgsql;

create or replace function send_email_on_visit_finish()
returns trigger as $$
begin
  if new.finished_at is not null and (old.finished_at is null or old.finished_at <> new.finished_at) then
    perform enqueue_visit_email(new.id);
  end if;
  return new;
end $$ language plpgsql;

create trigger trg_visit_email
after update on visits
for each row execute function send_email_on_visit_finish();

-- =========================
-- 15) SISTEMA DE INVENTARIOS
-- =========================

-- Tabla principal de inventarios por almacén
create table if not exists inventories (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  warehouse_id uuid references warehouses(id) on delete cascade,
  product_id uuid references products(id) on delete cascade,
  current_stock numeric not null default 0,
  reserved_stock numeric not null default 0,
  available_stock numeric generated always as (current_stock - reserved_stock) stored,
  min_stock numeric default 0,
  max_stock numeric,
  reorder_point numeric,
  unit_cost numeric default 0,
  last_updated timestamptz default now(),
  created_at timestamptz default now(),
  unique(warehouse_id, product_id)
);

-- Tipos de movimientos de inventario
do $$ begin
  create type inventory_movement_type as enum (
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
exception when duplicate_object then null; end $$;

-- Movimientos de inventario
create table if not exists inventory_movements (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  warehouse_id uuid references warehouses(id) on delete cascade,
  product_id uuid references products(id) on delete cascade,
  movement_type inventory_movement_type not null,
  quantity numeric not null,
  unit_cost numeric default 0,
  total_cost numeric generated always as (quantity * unit_cost) stored,
  reference_id uuid, -- ID de pedido, transferencia, etc.
  reference_type text, -- 'order', 'transfer', 'adjustment', etc.
  notes text,
  created_by uuid references profiles(id) on delete set null,
  created_at timestamptz default now()
);

-- Transferencias entre almacenes
create table if not exists inventory_transfers (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  from_warehouse_id uuid references warehouses(id) on delete cascade,
  to_warehouse_id uuid references warehouses(id) on delete cascade,
  status text default 'PENDING' check (status in ('PENDING', 'IN_TRANSIT', 'COMPLETED', 'CANCELLED')),
  requested_by uuid references profiles(id) on delete set null,
  approved_by uuid references profiles(id) on delete set null,
  shipped_by uuid references profiles(id) on delete set null,
  received_by uuid references profiles(id) on delete set null,
  requested_at timestamptz default now(),
  approved_at timestamptz,
  shipped_at timestamptz,
  received_at timestamptz,
  notes text,
  created_at timestamptz default now()
);

-- Items de transferencia
create table if not exists transfer_items (
  id uuid primary key default gen_random_uuid(),
  transfer_id uuid references inventory_transfers(id) on delete cascade,
  product_id uuid references products(id) on delete cascade,
  quantity numeric not null,
  transferred_quantity numeric default 0,
  unit_cost numeric default 0,
  notes text
);

-- Alertas de inventario
create table if not exists inventory_alerts (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  warehouse_id uuid references warehouses(id) on delete cascade,
  product_id uuid references products(id) on delete cascade,
  alert_type text not null check (alert_type in ('LOW_STOCK', 'OUT_OF_STOCK', 'OVERSTOCK', 'EXPIRING_SOON')),
  threshold numeric,
  current_value numeric,
  is_active boolean default true,
  created_at timestamptz default now(),
  resolved_at timestamptz,
  resolved_by uuid references profiles(id) on delete set null
);

-- Configuración de alertas por producto
create table if not exists product_alert_config (
  id uuid primary key default gen_random_uuid(),
  company_id uuid references companies(id) on delete cascade,
  product_id uuid references products(id) on delete cascade,
  low_stock_threshold numeric default 10,
  out_of_stock_threshold numeric default 0,
  overstock_threshold numeric,
  expiring_days_threshold integer default 30,
  enable_low_stock_alert boolean default true,
  enable_out_of_stock_alert boolean default true,
  enable_overstock_alert boolean default false,
  enable_expiring_alert boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  unique(product_id)
);

-- =========================
-- 16) ÍNDICES PARA INVENTARIOS
-- =========================

create index if not exists inventories_warehouse_idx on inventories(warehouse_id);
create index if not exists inventories_product_idx on inventories(product_id);
create index if not exists inventories_company_idx on inventories(company_id);
create index if not exists inventories_stock_idx on inventories(available_stock);

create index if not exists inventory_movements_warehouse_idx on inventory_movements(warehouse_id);
create index if not exists inventory_movements_product_idx on inventory_movements(product_id);
create index if not exists inventory_movements_type_idx on inventory_movements(movement_type);
create index if not exists inventory_movements_date_idx on inventory_movements(created_at);
create index if not exists inventory_movements_reference_idx on inventory_movements(reference_type, reference_id);

create index if not exists inventory_transfers_from_idx on inventory_transfers(from_warehouse_id);
create index if not exists inventory_transfers_to_idx on inventory_transfers(to_warehouse_id);
create index if not exists inventory_transfers_status_idx on inventory_transfers(status);
create index if not exists inventory_transfers_date_idx on inventory_transfers(created_at);

create index if not exists inventory_alerts_active_idx on inventory_alerts(is_active);
create index if not exists inventory_alerts_type_idx on inventory_alerts(alert_type);
create index if not exists inventory_alerts_date_idx on inventory_alerts(created_at);

-- =========================
-- 17) RLS PARA INVENTARIOS
-- =========================

alter table inventories enable row level security;
alter table inventory_movements enable row level security;
alter table inventory_transfers enable row level security;
alter table transfer_items enable row level security;
alter table inventory_alerts enable row level security;
alter table product_alert_config enable row level security;

-- Políticas para inventarios
create policy "company_rw_inventories" on inventories
for all using (company_id = (select company_id from me))
with check (company_id = (select company_id from me));

create policy "company_rw_inventory_movements" on inventory_movements
for all using (company_id = (select company_id from me))
with check (company_id = (select company_id from me));

create policy "company_rw_inventory_transfers" on inventory_transfers
for all using (company_id = (select company_id from me))
with check (company_id = (select company_id from me));

create policy "company_rw_transfer_items" on transfer_items
for all using (transfer_id in (select id from inventory_transfers where company_id = (select company_id from me)))
with check (transfer_id in (select id from inventory_transfers where company_id = (select company_id from me)));

create policy "company_rw_inventory_alerts" on inventory_alerts
for all using (company_id = (select company_id from me))
with check (company_id = (select company_id from me));

create policy "company_rw_product_alert_config" on product_alert_config
for all using (company_id = (select company_id from me))
with check (company_id = (select company_id from me));

-- =========================
-- 18) FUNCIONES PARA INVENTARIOS
-- =========================

-- Función para actualizar stock automáticamente
create or replace function update_inventory_stock()
returns trigger as $$
begin
  -- Actualizar inventario
  insert into inventories (company_id, warehouse_id, product_id, current_stock, unit_cost)
  values (new.company_id, new.warehouse_id, new.product_id, new.quantity, new.unit_cost)
  on conflict (warehouse_id, product_id)
  do update set
    current_stock = inventories.current_stock + new.quantity,
    unit_cost = case 
      when new.quantity > 0 then 
        (inventories.current_stock * inventories.unit_cost + new.quantity * new.unit_cost) / 
        (inventories.current_stock + new.quantity)
      else inventories.unit_cost
    end,
    last_updated = now();
  
  return new;
end $$ language plpgsql;

-- Trigger para actualizar inventario al crear movimientos
create trigger trg_update_inventory_stock
after insert on inventory_movements
for each row execute function update_inventory_stock();

-- Función para verificar alertas de inventario
create or replace function check_inventory_alerts()
returns trigger as $$
declare
  alert_config record;
  current_stock numeric;
begin
  -- Obtener configuración de alertas
  select * into alert_config 
  from product_alert_config 
  where product_id = new.product_id;
  
  if not found then
    -- Usar configuración por defecto
    alert_config.low_stock_threshold := 10;
    alert_config.out_of_stock_threshold := 0;
    alert_config.enable_low_stock_alert := true;
    alert_config.enable_out_of_stock_alert := true;
  end if;
  
  current_stock := new.available_stock;
  
  -- Verificar stock bajo
  if alert_config.enable_low_stock_alert and current_stock <= alert_config.low_stock_threshold and current_stock > 0 then
    insert into inventory_alerts (company_id, warehouse_id, product_id, alert_type, threshold, current_value)
    values (new.company_id, new.warehouse_id, new.product_id, 'LOW_STOCK', alert_config.low_stock_threshold, current_stock)
    on conflict do nothing;
  end if;
  
  -- Verificar sin stock
  if alert_config.enable_out_of_stock_alert and current_stock <= alert_config.out_of_stock_threshold then
    insert into inventory_alerts (company_id, warehouse_id, product_id, alert_type, threshold, current_value)
    values (new.company_id, new.warehouse_id, new.product_id, 'OUT_OF_STOCK', alert_config.out_of_stock_threshold, current_stock)
    on conflict do nothing;
  end if;
  
  return new;
end $$ language plpgsql;

-- Trigger para verificar alertas al actualizar inventario
create trigger trg_check_inventory_alerts
after update on inventories
for each row execute function check_inventory_alerts();

-- Función para reservar stock
create or replace function reserve_stock(
  p_warehouse_id uuid,
  p_product_id uuid,
  p_quantity numeric
)
returns boolean as $$
declare
  available numeric;
begin
  -- Verificar stock disponible
  select available_stock into available
  from inventories
  where warehouse_id = p_warehouse_id and product_id = p_product_id;
  
  if not found or available < p_quantity then
    return false;
  end if;
  
  -- Reservar stock
  update inventories
  set reserved_stock = reserved_stock + p_quantity
  where warehouse_id = p_warehouse_id and product_id = p_product_id;
  
  return true;
end $$ language plpgsql;

-- Función para liberar stock reservado
create or replace function release_stock(
  p_warehouse_id uuid,
  p_product_id uuid,
  p_quantity numeric
)
returns boolean as $$
begin
  update inventories
  set reserved_stock = greatest(0, reserved_stock - p_quantity)
  where warehouse_id = p_warehouse_id and product_id = p_product_id;
  
  return found;
end $$ language plpgsql;

-- Función para consumir stock (venta)
create or replace function consume_stock(
  p_warehouse_id uuid,
  p_product_id uuid,
  p_quantity numeric
)
returns boolean as $$
begin
  update inventories
  set 
    current_stock = current_stock - p_quantity,
    reserved_stock = greatest(0, reserved_stock - p_quantity)
  where warehouse_id = p_warehouse_id 
    and product_id = p_product_id
    and available_stock >= p_quantity;
  
  return found;
end $$ language plpgsql;

-- =========================
-- 19) VISTAS PARA REPORTES DE INVENTARIO
-- =========================

-- Vista de inventario con información completa
create or replace view inventory_summary as
select 
  i.id,
  i.company_id,
  i.warehouse_id,
  i.product_id,
  w.name as warehouse_name,
  p.name as product_name,
  p.sku,
  p.unit,
  i.current_stock,
  i.reserved_stock,
  i.available_stock,
  i.min_stock,
  i.max_stock,
  i.reorder_point,
  i.unit_cost,
  (i.current_stock * i.unit_cost) as total_value,
  i.last_updated,
  case 
    when i.available_stock <= i.min_stock then 'LOW_STOCK'
    when i.available_stock = 0 then 'OUT_OF_STOCK'
    when i.available_stock >= coalesce(i.max_stock, 999999) then 'OVERSTOCK'
    else 'NORMAL'
  end as stock_status
from inventories i
join warehouses w on w.id = i.warehouse_id
join products p on p.id = i.product_id;

-- Vista de movimientos con información detallada
create or replace view inventory_movements_detail as
select 
  im.id,
  im.company_id,
  im.warehouse_id,
  im.product_id,
  w.name as warehouse_name,
  p.name as product_name,
  p.sku,
  im.movement_type,
  im.quantity,
  im.unit_cost,
  im.total_cost,
  im.reference_type,
  im.reference_id,
  im.notes,
  im.created_by,
  prof.full_name as created_by_name,
  im.created_at
from inventory_movements im
join warehouses w on w.id = im.warehouse_id
join products p on p.id = im.product_id
left join profiles prof on prof.id = im.created_by;

-- Vista de alertas activas
create or replace view active_inventory_alerts as
select 
  ia.id,
  ia.company_id,
  ia.warehouse_id,
  ia.product_id,
  w.name as warehouse_name,
  p.name as product_name,
  p.sku,
  ia.alert_type,
  ia.threshold,
  ia.current_value,
  ia.created_at,
  case 
    when ia.alert_type = 'LOW_STOCK' then 'Stock bajo'
    when ia.alert_type = 'OUT_OF_STOCK' then 'Sin stock'
    when ia.alert_type = 'OVERSTOCK' then 'Sobre stock'
    when ia.alert_type = 'EXPIRING_SOON' then 'Próximo a vencer'
    else ia.alert_type
  end as alert_description
from inventory_alerts ia
join warehouses w on w.id = ia.warehouse_id
join products p on p.id = ia.product_id
where ia.is_active = true and ia.resolved_at is null;

-- =========================
-- 20) FUNCIONES DE REPORTE PARA INVENTARIO
-- =========================

-- Función para obtener reporte de valor de inventario
create or replace function get_inventory_value_report(
  p_company_id uuid,
  p_warehouse_id uuid default null,
  p_date_from date default null,
  p_date_to date default null
)
returns table (
  warehouse_name text,
  product_name text,
  sku text,
  current_stock numeric,
  unit_cost numeric,
  total_value numeric,
  last_movement_date timestamptz
) as $$
begin
  return query
  select 
    w.name,
    p.name,
    p.sku,
    i.current_stock,
    i.unit_cost,
    (i.current_stock * i.unit_cost) as total_value,
    i.last_updated
  from inventories i
  join warehouses w on w.id = i.warehouse_id
  join products p on p.id = i.product_id
  where i.company_id = p_company_id
    and (p_warehouse_id is null or i.warehouse_id = p_warehouse_id)
    and (p_date_from is null or i.last_updated >= p_date_from)
    and (p_date_to is null or i.last_updated <= p_date_to)
  order by w.name, p.name;
end $$ language plpgsql;

-- Función para obtener movimientos de inventario
create or replace function get_inventory_movements_report(
  p_company_id uuid,
  p_warehouse_id uuid default null,
  p_product_id uuid default null,
  p_date_from date default null,
  p_date_to date default null
)
returns table (
  movement_date timestamptz,
  warehouse_name text,
  product_name text,
  movement_type text,
  quantity numeric,
  unit_cost numeric,
  total_cost numeric,
  created_by_name text
) as $$
begin
  return query
  select 
    im.created_at,
    w.name,
    p.name,
    im.movement_type::text,
    im.quantity,
    im.unit_cost,
    im.total_cost,
    prof.full_name
  from inventory_movements im
  join warehouses w on w.id = im.warehouse_id
  join products p on p.id = im.product_id
  left join profiles prof on prof.id = im.created_by
  where im.company_id = p_company_id
    and (p_warehouse_id is null or im.warehouse_id = p_warehouse_id)
    and (p_product_id is null or im.product_id = p_product_id)
    and (p_date_from is null or im.created_at >= p_date_from)
    and (p_date_to is null or im.created_at <= p_date_to)
  order by im.created_at desc;
end $$ language plpgsql;