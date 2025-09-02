-- Arsenal Sell App - Supabase Database Schema
-- Generated from Flutter Drift tables and data models

-- Create extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- ============================================================================
-- CORE TABLES
-- ============================================================================

-- Companies table (multi-tenant support)
CREATE TABLE companies (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    code VARCHAR(50) UNIQUE,
    email VARCHAR(255),
    phone VARCHAR(50),
    address TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    is_active BOOLEAN DEFAULT TRUE
);

-- User profiles table (extends Supabase auth.users)
CREATE TABLE profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    company_id UUID REFERENCES companies(id) ON DELETE CASCADE,
    full_name VARCHAR(255),
    phone VARCHAR(50),
    email VARCHAR(255),
    role VARCHAR(50) NOT NULL DEFAULT 'VENDEDOR',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    CONSTRAINT valid_role CHECK (role IN ('ADMIN', 'SUPERVISOR', 'VENDEDOR', 'REPARTIDOR'))
);

-- ============================================================================
-- BUSINESS TABLES
-- ============================================================================

-- Customers table
CREATE TABLE customers (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    code VARCHAR(50),
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(50),
    address TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    geo_accuracy_m DOUBLE PRECISION,
    created_by UUID REFERENCES profiles(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Create geographic point if coordinates exist
    geo_point GEOGRAPHY(POINT, 4326) GENERATED ALWAYS AS (
        CASE 
            WHEN latitude IS NOT NULL AND longitude IS NOT NULL 
            THEN ST_SetSRID(ST_MakePoint(longitude, latitude), 4326)::geography
            ELSE NULL 
        END
    ) STORED
);

-- Products table
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    sku VARCHAR(100),
    name VARCHAR(255) NOT NULL,
    unit VARCHAR(50),
    tax DOUBLE PRECISION DEFAULT 0.0,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Price lists table
CREATE TABLE price_lists (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    active BOOLEAN DEFAULT TRUE,
    valid_from TIMESTAMP WITH TIME ZONE,
    valid_to TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Product prices table
CREATE TABLE product_prices (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    price_list_id UUID NOT NULL REFERENCES price_lists(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    price DOUBLE PRECISION NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    UNIQUE(price_list_id, product_id)
);

-- Visits table
CREATE TABLE visits (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    user_id UUID REFERENCES profiles(id),
    purpose VARCHAR(50) NOT NULL,
    started_at TIMESTAMP WITH TIME ZONE,
    finished_at TIMESTAMP WITH TIME ZONE,
    checkin_latitude DOUBLE PRECISION,
    checkin_longitude DOUBLE PRECISION,
    checkout_latitude DOUBLE PRECISION,
    checkout_longitude DOUBLE PRECISION,
    checkin_accuracy_m DOUBLE PRECISION,
    checkout_accuracy_m DOUBLE PRECISION,
    distance_m DOUBLE PRECISION,
    notes TEXT,
    is_synced BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Geographic points for check-in/out
    checkin_point GEOGRAPHY(POINT, 4326) GENERATED ALWAYS AS (
        CASE 
            WHEN checkin_latitude IS NOT NULL AND checkin_longitude IS NOT NULL 
            THEN ST_SetSRID(ST_MakePoint(checkin_longitude, checkin_latitude), 4326)::geography
            ELSE NULL 
        END
    ) STORED,
    
    checkout_point GEOGRAPHY(POINT, 4326) GENERATED ALWAYS AS (
        CASE 
            WHEN checkout_latitude IS NOT NULL AND checkout_longitude IS NOT NULL 
            THEN ST_SetSRID(ST_MakePoint(checkout_longitude, checkout_latitude), 4326)::geography
            ELSE NULL 
        END
    ) STORED,
    
    CONSTRAINT valid_purpose CHECK (purpose IN ('VENTA', 'COBRO', 'ENTREGA', 'VISITA', 'AUDITORIA', 'DEVOLUCION', 'OTRO'))
);

-- Visit photos table
CREATE TABLE visit_photos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    visit_id UUID NOT NULL REFERENCES visits(id) ON DELETE CASCADE,
    storage_path VARCHAR(500) NOT NULL,
    local_path VARCHAR(500),
    public_url VARCHAR(500),
    description TEXT,
    photo_type VARCHAR(50) DEFAULT 'GENERAL',
    status VARCHAR(50) DEFAULT 'PENDING_UPLOAD',
    file_size INTEGER DEFAULT 0,
    mime_type VARCHAR(100),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    is_required BOOLEAN DEFAULT FALSE,
    is_synced BOOLEAN DEFAULT FALSE,
    taken_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    uploaded_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    CONSTRAINT valid_photo_type CHECK (photo_type IN ('GENERAL', 'PRODUCT', 'RECEIPT', 'DAMAGE', 'INVENTORY', 'STOREFRONT', 'EVIDENCE')),
    CONSTRAINT valid_photo_status CHECK (status IN ('PENDING_UPLOAD', 'UPLOADING', 'UPLOADED', 'FAILED'))
);

-- Visit signatures table
CREATE TABLE visit_signatures (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    visit_id UUID NOT NULL REFERENCES visits(id) ON DELETE CASCADE,
    storage_path VARCHAR(500) NOT NULL,
    local_path VARCHAR(500),
    public_url VARCHAR(500),
    signed_by VARCHAR(255),
    status VARCHAR(50) DEFAULT 'PENDING_UPLOAD',
    file_size INTEGER DEFAULT 0,
    is_synced BOOLEAN DEFAULT FALSE,
    signed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    uploaded_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    CONSTRAINT valid_signature_status CHECK (status IN ('PENDING_UPLOAD', 'UPLOADING', 'UPLOADED', 'FAILED'))
);

-- Orders table
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    customer_id UUID REFERENCES customers(id),
    user_id UUID REFERENCES profiles(id),
    price_list_id UUID REFERENCES price_lists(id),
    visit_id UUID REFERENCES visits(id),
    status VARCHAR(50) DEFAULT 'DRAFT',
    subtotal DOUBLE PRECISION DEFAULT 0.0,
    tax_total DOUBLE PRECISION DEFAULT 0.0,
    discount_total DOUBLE PRECISION DEFAULT 0.0,
    grand_total DOUBLE PRECISION DEFAULT 0.0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    needs_sync BOOLEAN DEFAULT FALSE,
    
    CONSTRAINT valid_status CHECK (status IN ('DRAFT', 'SENT', 'APPROVED', 'REJECTED', 'DELIVERED', 'CANCELLED'))
);

-- Order items table
CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    qty DOUBLE PRECISION NOT NULL,
    price DOUBLE PRECISION NOT NULL,
    discount DOUBLE PRECISION DEFAULT 0.0,
    total DOUBLE PRECISION NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tracking locations table
CREATE TABLE tracking_locations (
    id SERIAL PRIMARY KEY,
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    at TIMESTAMP WITH TIME ZONE NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    speed_ms DOUBLE PRECISION,
    accuracy_m DOUBLE PRECISION,
    needs_sync BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Geographic point for location
    geo_point GEOGRAPHY(POINT, 4326) GENERATED ALWAYS AS (
        ST_SetSRID(ST_MakePoint(longitude, latitude), 4326)::geography
    ) STORED
);

-- Route plans table
CREATE TABLE route_plans (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    date DATE NOT NULL,
    status VARCHAR(50) DEFAULT 'PLANNED',
    total_distance_km DOUBLE PRECISION,
    estimated_duration_hours DOUBLE PRECISION,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    CONSTRAINT valid_route_status CHECK (status IN ('PLANNED', 'IN_PROGRESS', 'COMPLETED', 'CANCELLED'))
);

-- Route stops table
CREATE TABLE route_stops (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    route_plan_id UUID NOT NULL REFERENCES route_plans(id) ON DELETE CASCADE,
    customer_id UUID NOT NULL REFERENCES customers(id) ON DELETE CASCADE,
    sequence_number INTEGER NOT NULL,
    estimated_arrival TIMESTAMP WITH TIME ZONE,
    actual_arrival TIMESTAMP WITH TIME ZONE,
    estimated_duration_minutes INTEGER,
    actual_duration_minutes INTEGER,
    status VARCHAR(50) DEFAULT 'PENDING',
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    CONSTRAINT valid_stop_status CHECK (status IN ('PENDING', 'IN_PROGRESS', 'COMPLETED', 'SKIPPED')),
    UNIQUE(route_plan_id, sequence_number)
);

-- Inventory table
CREATE TABLE inventory (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    warehouse_id VARCHAR(100) NOT NULL,
    quantity DOUBLE PRECISION NOT NULL DEFAULT 0,
    reserved_quantity DOUBLE PRECISION NOT NULL DEFAULT 0,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    UNIQUE(product_id, warehouse_id)
);

-- Payments table
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    customer_id UUID REFERENCES customers(id),
    order_id UUID REFERENCES orders(id),
    visit_id UUID REFERENCES visits(id),
    user_id UUID REFERENCES profiles(id),
    amount DOUBLE PRECISION NOT NULL,
    method VARCHAR(50) NOT NULL,
    reference VARCHAR(255),
    status VARCHAR(50) DEFAULT 'PENDING',
    notes TEXT,
    paid_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    CONSTRAINT valid_payment_method CHECK (method IN ('CASH', 'CREDIT_CARD', 'DEBIT_CARD', 'BANK_TRANSFER', 'CHECK', 'OTHER')),
    CONSTRAINT valid_payment_status CHECK (status IN ('PENDING', 'COMPLETED', 'FAILED', 'CANCELLED', 'REFUNDED'))
);

-- Deliveries table
CREATE TABLE deliveries (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    customer_id UUID REFERENCES customers(id),
    driver_id UUID REFERENCES profiles(id),
    status VARCHAR(50) DEFAULT 'PENDING',
    scheduled_at TIMESTAMP WITH TIME ZONE,
    delivered_at TIMESTAMP WITH TIME ZONE,
    delivery_address TEXT,
    delivery_latitude DOUBLE PRECISION,
    delivery_longitude DOUBLE PRECISION,
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Geographic point for delivery location
    delivery_point GEOGRAPHY(POINT, 4326) GENERATED ALWAYS AS (
        CASE 
            WHEN delivery_latitude IS NOT NULL AND delivery_longitude IS NOT NULL 
            THEN ST_SetSRID(ST_MakePoint(delivery_longitude, delivery_latitude), 4326)::geography
            ELSE NULL 
        END
    ) STORED,
    
    CONSTRAINT valid_delivery_status CHECK (status IN ('PENDING', 'IN_TRANSIT', 'DELIVERED', 'FAILED', 'CANCELLED'))
);

-- Forms table (for custom forms)
CREATE TABLE forms (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    company_id UUID NOT NULL REFERENCES companies(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    form_schema JSONB NOT NULL,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Form submissions table
CREATE TABLE form_submissions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    form_id UUID NOT NULL REFERENCES forms(id) ON DELETE CASCADE,
    visit_id UUID REFERENCES visits(id),
    user_id UUID REFERENCES profiles(id),
    customer_id UUID REFERENCES customers(id),
    data JSONB NOT NULL,
    submitted_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================================
-- INDEXES
-- ============================================================================

-- Performance indexes
CREATE INDEX idx_customers_company_id ON customers(company_id);
CREATE INDEX idx_customers_created_by ON customers(created_by);
CREATE INDEX idx_customers_geo ON customers USING GIST(geo_point);

CREATE INDEX idx_visits_customer_id ON visits(customer_id, started_at DESC);
CREATE INDEX idx_visits_user_id ON visits(user_id, started_at DESC);
CREATE INDEX idx_visits_company_id ON visits(company_id);
CREATE INDEX idx_visits_checkin_geo ON visits USING GIST(checkin_point);
CREATE INDEX idx_visits_checkout_geo ON visits USING GIST(checkout_point);

CREATE INDEX idx_tracking_user_time ON tracking_locations(user_id, at DESC);
CREATE INDEX idx_tracking_company_time ON tracking_locations(company_id, at DESC);
CREATE INDEX idx_tracking_geo ON tracking_locations USING GIST(geo_point);

CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_company_id ON orders(company_id);
CREATE INDEX idx_orders_status ON orders(status);

CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

CREATE INDEX idx_products_company_id ON products(company_id);
CREATE INDEX idx_products_sku ON products(sku);

CREATE INDEX idx_profiles_company_id ON profiles(company_id);
CREATE INDEX idx_profiles_role ON profiles(role);

-- ============================================================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE companies ENABLE ROW LEVEL SECURITY;
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE customers ENABLE ROW LEVEL SECURITY;
ALTER TABLE products ENABLE ROW LEVEL SECURITY;
ALTER TABLE price_lists ENABLE ROW LEVEL SECURITY;
ALTER TABLE product_prices ENABLE ROW LEVEL SECURITY;
ALTER TABLE visits ENABLE ROW LEVEL SECURITY;
ALTER TABLE visit_photos ENABLE ROW LEVEL SECURITY;
ALTER TABLE visit_signatures ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE tracking_locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE route_plans ENABLE ROW LEVEL SECURITY;
ALTER TABLE route_stops ENABLE ROW LEVEL SECURITY;
ALTER TABLE inventory ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE deliveries ENABLE ROW LEVEL SECURITY;
ALTER TABLE forms ENABLE ROW LEVEL SECURITY;
ALTER TABLE form_submissions ENABLE ROW LEVEL SECURITY;

-- Basic RLS policies (you should customize these based on your business rules)

-- Profiles: Users can read their own profile and others in same company
CREATE POLICY "Users can view own profile" ON profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON profiles FOR UPDATE USING (auth.uid() = id);

-- Company-based policies for most tables
CREATE POLICY "Company members can view customers" ON customers FOR SELECT 
    USING (company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid()));

CREATE POLICY "Company members can view visits" ON visits FOR SELECT 
    USING (company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid()));

CREATE POLICY "Users can view own tracking" ON tracking_locations FOR SELECT 
    USING (user_id = auth.uid());

-- Company members can manage customers
CREATE POLICY "Company members can insert customers" ON customers FOR INSERT 
    WITH CHECK (company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid()));

CREATE POLICY "Company members can update customers" ON customers FOR UPDATE 
    USING (company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid()));

-- Company members can manage visits
CREATE POLICY "Company members can insert visits" ON visits FOR INSERT 
    WITH CHECK (company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid()));

CREATE POLICY "Company members can update visits" ON visits FOR UPDATE 
    USING (company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid()));

-- Users can manage their own visit photos
CREATE POLICY "Users can view visit photos" ON visit_photos FOR SELECT 
    USING (visit_id IN (SELECT id FROM visits WHERE company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid())));

CREATE POLICY "Users can insert visit photos" ON visit_photos FOR INSERT 
    WITH CHECK (visit_id IN (SELECT id FROM visits WHERE company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid())));

-- Users can manage their own visit signatures
CREATE POLICY "Users can view visit signatures" ON visit_signatures FOR SELECT 
    USING (visit_id IN (SELECT id FROM visits WHERE company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid())));

CREATE POLICY "Users can insert visit signatures" ON visit_signatures FOR INSERT 
    WITH CHECK (visit_id IN (SELECT id FROM visits WHERE company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid())));

-- Company members can manage orders
CREATE POLICY "Company members can view orders" ON orders FOR SELECT 
    USING (company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid()));

CREATE POLICY "Company members can insert orders" ON orders FOR INSERT 
    WITH CHECK (company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid()));

CREATE POLICY "Company members can update orders" ON orders FOR UPDATE 
    USING (company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid()));

-- Company members can manage order items
CREATE POLICY "Company members can view order items" ON order_items FOR SELECT 
    USING (order_id IN (SELECT id FROM orders WHERE company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid())));

CREATE POLICY "Company members can insert order items" ON order_items FOR INSERT 
    WITH CHECK (order_id IN (SELECT id FROM orders WHERE company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid())));

-- Company members can view products
CREATE POLICY "Company members can view products" ON products FOR SELECT 
    USING (company_id IN (SELECT company_id FROM profiles WHERE id = auth.uid()));

-- Add more policies as needed...

-- ============================================================================
-- FUNCTIONS AND TRIGGERS
-- ============================================================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Add updated_at triggers to relevant tables
CREATE TRIGGER update_companies_updated_at BEFORE UPDATE ON companies
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON profiles
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_customers_updated_at BEFORE UPDATE ON customers
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_products_updated_at BEFORE UPDATE ON products
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_visits_updated_at BEFORE UPDATE ON visits
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_orders_updated_at BEFORE UPDATE ON orders
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to calculate order totals
CREATE OR REPLACE FUNCTION calculate_order_totals()
RETURNS TRIGGER AS $$
DECLARE
    order_subtotal DECIMAL;
    order_tax_total DECIMAL;
    order_discount_total DECIMAL;
    order_grand_total DECIMAL;
BEGIN
    -- Calculate totals from order items
    SELECT 
        COALESCE(SUM(qty * price), 0),
        COALESCE(SUM(qty * price * (SELECT tax/100 FROM products WHERE id = NEW.product_id)), 0),
        COALESCE(SUM(discount), 0)
    INTO order_subtotal, order_tax_total, order_discount_total
    FROM order_items 
    WHERE order_id = COALESCE(NEW.order_id, OLD.order_id);
    
    order_grand_total := order_subtotal + order_tax_total - order_discount_total;
    
    -- Update the order
    UPDATE orders SET 
        subtotal = order_subtotal,
        tax_total = order_tax_total,
        discount_total = order_discount_total,
        grand_total = order_grand_total,
        updated_at = NOW()
    WHERE id = COALESCE(NEW.order_id, OLD.order_id);
    
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Trigger to recalculate order totals when items change
CREATE TRIGGER calculate_order_totals_trigger
    AFTER INSERT OR UPDATE OR DELETE ON order_items
    FOR EACH ROW EXECUTE FUNCTION calculate_order_totals();

-- ============================================================================
-- INITIAL DATA
-- ============================================================================

-- Insert default company (you can modify this)
INSERT INTO companies (id, name, code, email) 
VALUES (
    '00000000-0000-0000-0000-000000000001'::UUID,
    'Arsenal Sell Demo Company',
    'DEMO',
    'demo@arsenal.com'
) ON CONFLICT (id) DO NOTHING;

-- Comments for documentation
COMMENT ON TABLE companies IS 'Company information for multi-tenant support';
COMMENT ON TABLE profiles IS 'User profiles extending Supabase auth.users';
COMMENT ON TABLE customers IS 'Customer information with geographic coordinates';
COMMENT ON TABLE visits IS 'Customer visits with check-in/out locations and purposes';
COMMENT ON TABLE orders IS 'Sales orders with items and totals';
COMMENT ON TABLE tracking_locations IS 'GPS tracking data for users';
COMMENT ON COLUMN customers.geo_point IS 'Automatically generated geographic point from lat/lng';
COMMENT ON COLUMN visits.checkin_point IS 'Geographic point for visit check-in location';
COMMENT ON COLUMN visits.checkout_point IS 'Geographic point for visit checkout location';
