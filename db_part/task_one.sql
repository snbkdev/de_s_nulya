-- ============================================
-- 1. Таблица region
-- ============================================
CREATE TABLE region (
    r_regionkey INTEGER PRIMARY KEY,
    r_name CHARACTER(25),
    r_comment CHARACTER VARYING(152),
    n_emp CHARACTER(2)
);

INSERT INTO region (r_regionkey, r_name, r_comment, n_emp) VALUES
(1, 'AFRICA', 'Africa region', '02'),
(2, 'AMERICA', 'North and South America', '05'),
(3, 'ASIA', 'Asia region', '07'),
(4, 'EUROPE', 'Europe region', '11'),
(5, 'MIDDLE EAST', 'Middle East region', '03'),
(6, 'AUSTRALIA', 'Australia and Oceania', '04'),
(7, 'ANTARCTICA', 'Antarctica region', '01'),
(8, 'PACIFIC', 'Pacific Islands', '06'),
(9, 'CARIBBEAN', 'Caribbean region', '09'),
(10, 'SCANDINAVIA', 'Scandinavia region', '10');


-- ============================================
-- 2. Таблица nation
-- ============================================
CREATE TABLE nation (
    n_nationkey INTEGER PRIMARY KEY,
    n_name CHARACTER(25),
    n_regionkey INTEGER REFERENCES region(r_regionkey),
    n_comment CHARACTER VARYING(152),
    n_emp CHARACTER(2)
);

INSERT INTO nation (n_nationkey, n_name, n_regionkey, n_comment, n_emp) VALUES
(1, 'ALGERIA', 1, 'North African country', '02'),
(2, 'ARGENTINA', 2, 'South American country', '05'),
(3, 'BRAZIL', 2, 'Largest South American country', '05'),
(4, 'CANADA', 2, 'North American country', '05'),
(5, 'CHINA', 3, 'East Asian country', '07'),
(6, 'EGYPT', 5, 'North African country', '03'),
(7, 'FRANCE', 4, 'Western European country', '11'),
(8, 'GERMANY', 4, 'Central European country', '11'),
(9, 'INDIA', 3, 'South Asian country', '07'),
(10, 'ITALY', 4, 'Southern European country', '11'),
(11, 'JAPAN', 3, 'East Asian island country', '07'),
(12, 'MEXICO', 2, 'North American country', '05'),
(13, 'NIGERIA', 1, 'West African country', '02'),
(14, 'RUSSIA', 4, 'Largest country in the world', '11'),
(15, 'SOUTH AFRICA', 1, 'Southernmost African country', '02'),
(16, 'SOUTH KOREA', 3, 'East Asian country', '07'),
(17, 'SPAIN', 4, 'Southern European country', '11'),
(18, 'SWEDEN', 10, 'Northern European country', '10'),
(19, 'TURKEY', 5, 'Transcontinental country', '03'),
(20, 'UNITED KINGDOM', 4, 'Western European country', '11'),
(21, 'UNITED STATES', 2, 'North American country', '05'),
(22, 'VIETNAM', 3, 'Southeast Asian country', '07'),
(23, 'AUSTRALIA', 6, 'Oceania country', '04'),
(24, 'NEW ZEALAND', 6, 'Oceania country', '04'),
(25, 'SWITZERLAND', 4, 'Central European country', '11');


-- ============================================
-- 3. Таблица customer
-- ============================================
CREATE TABLE customer (
    c_custkey INTEGER PRIMARY KEY,
    c_name CHARACTER VARYING(25),
    c_address CHARACTER VARYING(40),
    c_nationkey INTEGER REFERENCES nation(n_nationkey),
    c_phone CHARACTER(15),
    c_acctbal NUMERIC(15,2),
    c_mktsegment CHARACTER(10),
    c_comment CHARACTER VARYING(117),
    n_emp CHARACTER(2)
);

INSERT INTO customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment, n_emp) VALUES
(1, 'John Smith', '123 Main St, New York', 21, '212-555-0101', 1500.50, 'AUTOMOBILE', 'Regular customer', '05'),
(2, 'Maria Garcia', '456 Oak Ave, Los Angeles', 21, '310-555-0102', 2300.75, 'BUILDING', 'Good credit history', '05'),
(3, 'David Chen', '789 Pine Blvd, Chicago', 21, '312-555-0103', 1200.00, 'HOUSEHOLD', 'Prefers online payments', '05'),
(4, 'Anna Kowalski', '321 Maple Dr, Toronto', 4, '416-555-0104', 3400.20, 'AUTOMOBILE', 'VIP customer', '05'),
(5, 'Carlos Rodriguez', '654 Elm St, Mexico City', 12, '555-555-0105', 800.90, 'BUILDING', 'Frequent buyer', '05'),
(6, 'Lena Ivanova', '987 Birch Ln, Moscow', 14, '495-555-0106', 5600.00, 'MACHINERY', 'Corporate account', '11'),
(7, 'Mei Liu', '123 Silk Rd, Beijing', 5, '101-555-0107', 2100.30, 'FURNITURE', 'Loyal customer', '07'),
(8, 'Hans Mueller', '456 Berliner Str, Berlin', 8, '301-555-0108', 4300.10, 'AUTOMOBILE', 'High volume orders', '11'),
(9, 'Sofia Santos', '789 Lisboa Ave, Lisbon', 7, '211-555-0109', 950.75, 'HOUSEHOLD', 'New customer', '11'),
(10, 'Ahmed Hassan', '321 Cairo St, Cairo', 6, '202-555-0110', 1800.00, 'BUILDING', 'Regular orders', '03'),
(11, 'Olga Petrova', '654 Kiev Blvd, Kyiv', 2, '448-555-0111', 2700.45, 'MACHINERY', 'Long-term client', '05'),
(12, 'James Wilson', '987 London Rd, London', 20, '207-555-0112', 3400.00, 'FURNITURE', 'Corporate customer', '11'),
(13, 'Marie Dupont', '123 Paris Ave, Paris', 7, '119-555-0113', 1200.80, 'AUTOMOBILE', 'Often buys in bulk', '11'),
(14, 'Yuki Tanaka', '456 Tokyo Blvd, Tokyo', 11, '301-555-0114', 5100.00, 'HOUSEHOLD', 'Premium account', '07'),
(15, 'Pedro Martinez', '789 Madrid St, Madrid', 17, '916-555-0115', 890.25, 'BUILDING', 'Small business owner', '11'),
(16, 'Helen Brown', '321 Sydney Ave, Sydney', 23, '288-555-0116', 2100.90, 'MACHINERY', 'Industrial supplies', '04'),
(17, 'Ivan Petrov', '654 Sofia Ln, Sofia', 7, '295-555-0117', 3800.50, 'FURNITURE', 'Good payment history', '11'),
(18, 'Kim Min-jun', '987 Seoul Rd, Seoul', 16, '229-555-0118', 4700.00, 'AUTOMOBILE', 'Corporate client', '07'),
(19, 'Johannes Vermeer', '123 Amsterdam Blvd, Amsterdam', 20, '174-555-0119', 1600.75, 'HOUSEHOLD', 'Family business', '11'),
(20, 'Natalia Popova', '456 Warsaw St, Warsaw', 7, '274-555-0120', 920.30, 'BUILDING', 'Construction materials', '11'),
(21, 'Thomas Mueller', '789 Bern Ave, Bern', 25, '288-555-0121', 2800.60, 'MACHINERY', 'Industrial equipment', '11'),
(22, 'Elena Petrescu', '321 Bucharest Blvd, Bucharest', 4, '299-555-0122', 1950.40, 'FURNITURE', 'Home office orders', '05'),
(23, 'Ahmet Yilmaz', '654 Istanbul St, Istanbul', 19, '298-555-0123', 3200.00, 'AUTOMOBILE', 'Fleet manager', '03'),
(24, 'Olga Fedorova', '987 Kiev Blvd, Kyiv', 2, '448-555-0124', 4300.20, 'HOUSEHOLD', 'Wholesale buyer', '05'),
(25, 'Lucas Garcia', '123 Madrid Ave, Madrid', 17, '916-555-0125', 1450.90, 'BUILDING', 'Real estate', '11'),
(26, 'Svetlana Ivanova', '456 Minsk St, Minsk', 4, '390-555-0126', 2900.00, 'MACHINERY', 'Manufacturing', '05'),
(27, 'Omar Ahmed', '789 Dubai Blvd, Dubai', 6, '215-555-0127', 6700.50, 'FURNITURE', 'Luxury furniture', '03'),
(28, 'Giorgio Rossi', '321 Rome Ave, Rome', 10, '221-555-0128', 1850.75, 'AUTOMOBILE', 'Car dealership', '11'),
(29, 'Xiaomin Zhang', '654 Shanghai St, Shanghai', 5, '210-555-0129', 4200.30, 'HOUSEHOLD', 'Large orders', '07'),
(30, 'Anthony Brown', '987 Chicago Blvd, Chicago', 21, '312-555-0130', 5300.00, 'BUILDING', 'Real estate developer', '05');


-- ============================================
-- 4. Таблица supplier
-- ============================================
CREATE TABLE supplier (
    s_suppkey INTEGER PRIMARY KEY,
    s_name CHARACTER(25),
    s_address CHARACTER VARYING(40),
    s_nationkey INTEGER REFERENCES nation(n_nationkey),
    s_phone CHARACTER(15),
    s_acctbal NUMERIC(15,2),
    s_comment CHARACTER VARYING(101),
    n_emp CHARACTER(2)
);

INSERT INTO supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment, n_emp) VALUES
(1, 'Acme Corp', '100 Industrial Pkwy, New York', 21, '212-555-2001', 50000.00, 'Top supplier', '05'),
(2, 'Global Supply', '200 Commerce Blvd, Los Angeles', 21, '310-555-2002', 34000.50, 'Reliable supplier', '05'),
(3, 'EuroParts Ltd', '300 Tech Park, London', 20, '207-555-2003', 45000.00, 'European supplier', '11'),
(4, 'China Mfg', '400 Industrial Zone, Beijing', 5, '101-555-2004', 28000.75, 'Large volume supplier', '07'),
(5, 'Tokyo Traders', '500 Akihabara, Tokyo', 11, '301-555-2005', 62000.00, 'High quality', '07'),
(6, 'India Industries', '600 Silicon Valley, Bangalore', 9, '333-555-2006', 21000.20, 'IT supplier', '07'),
(7, 'Moscow Metals', '700 Steel Ave, Moscow', 14, '495-555-2007', 56000.00, 'Steel products', '11'),
(8, 'Brazil Exports', '800 Amazonia, Sao Paulo', 3, '332-555-2008', 32000.00, 'Agricultural supplier', '05'),
(9, 'Canada Trading', '900 Maple Ave, Toronto', 4, '416-555-2009', 41000.50, 'Energy sector', '05'),
(10, 'German Engineering', '1000 Auto Blvd, Berlin', 8, '301-555-2010', 78000.00, 'Precision parts', '11'),
(11, 'Australian Mining', '1100 Outback Rd, Sydney', 23, '288-555-2011', 53000.00, 'Mining equipment', '04'),
(12, 'French Quality', '1200 Wine St, Paris', 7, '119-555-2012', 36500.00, 'Luxury goods', '11'),
(13, 'Italian Design', '1300 Fashion Ave, Milan', 10, '221-555-2013', 42500.50, 'Fashion supplier', '11'),
(14, 'Korean Tech', '1400 Samsung Rd, Seoul', 16, '229-555-2014', 69000.00, 'Electronics', '07'),
(15, 'Spanish Shipping', '1500 Port Blvd, Madrid', 17, '916-555-2015', 27000.30, 'Logistics', '11'),
(16, 'Swiss Finance', '1600 Bank St, Zurich', 25, '288-555-2016', 82000.00, 'Financial services', '11'),
(17, 'Dutch Trading', '1700 Amsterdam Ave, Amsterdam', 20, '174-555-2017', 38000.00, 'Global trade', '11'),
(18, 'Thai Exports', '1800 Bangkok Rd, Bangkok', 5, '299-555-2018', 29500.00, 'Rice and rubber', '07'),
(19, 'Turkish Supply', '1900 Istanbul Blvd, Istanbul', 19, '298-555-2019', 31500.00, 'Textiles', '03'),
(20, 'South African Mining', '2000 Johannesburg Rd, Johannesburg', 15, '112-555-2020', 47000.00, 'Diamonds and gold', '02'),
(21, 'Mexico Export', '2100 Mexico City Blvd, Mexico City', 12, '555-555-2021', 26500.00, 'Automotive parts', '05'),
(22, 'Egyptian Trading', '2200 Cairo Ave, Cairo', 6, '202-555-2022', 34000.00, 'Cotton and textiles', '03'),
(23, 'Polish Manufacturing', '2300 Warsaw Blvd, Warsaw', 3, '274-555-2023', 38500.50, 'Machinery', '11'),
(24, 'Swedish Tech', '2400 Stockholm Ave, Stockholm', 18, '872-555-2024', 59000.00, 'Telecom equipment', '10'),
(25, 'Austrian Quality', '2500 Vienna Blvd, Vienna', 4, '988-555-2025', 42500.00, 'Precision tools', '05'),
(26, 'Singapore Trading', '2600 Singapore Ave, Singapore', 3, '199-555-2026', 52000.00, 'Port logistics', '07'),
(27, 'New Zealand', '2700 Auckland Rd, Auckland', 24, '654-555-2027', 31000.00, 'Dairy products', '04'),
(28, 'Pakistan Textiles', '2800 Karachi Blvd, Karachi', 9, '123-555-2028', 26500.00, 'Cotton and textiles', '07'),
(29, 'Chilean Mining', '2900 Santiago Ave, Santiago', 2, '522-555-2029', 44000.00, 'Copper exports', '05'),
(30, 'Indonesian Exports', '3000 Jakarta Blvd, Jakarta', 5, '456-555-2030', 35000.00, 'Palm oil and rubber', '07');


-- ============================================
-- 5. Таблица part
-- ============================================
CREATE TABLE part (
    p_partkey INTEGER PRIMARY KEY,
    p_name CHARACTER VARYING(55),
    p_mfgr CHARACTER(25),
    p_brand CHARACTER(10),
    p_type CHARACTER VARYING(25),
    p_size INTEGER,
    p_container CHARACTER(10),
    p_retailprice NUMERIC(15,2),
    p_comment CHARACTER VARYING(23),
    n_emp CHARACTER(2)
);

INSERT INTO part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment, n_emp) VALUES
(1, 'Steel Rod', 'Acme Steel', 'Brand#1', 'Steel', 10, 'Box', 150.00, 'High quality steel', '05'),
(2, 'Aluminum Sheet', 'Global Alum', 'Brand#2', 'Aluminum', 8, 'Case', 89.99, 'Lightweight', '05'),
(3, 'Copper Wire', 'Copper Inc', 'Brand#3', 'Copper', 12, 'Roll', 230.50, 'Electrical grade', '07'),
(4, 'Plastic Pipe', 'Plastics Co', 'Brand#4', 'Plastic', 15, 'Bulk', 45.75, 'PVC material', '11'),
(5, 'Rubber Gasket', 'Rubber World', 'Brand#5', 'Rubber', 5, 'Bag', 12.99, 'Seals and gaskets', '05'),
(6, 'Steel Beam', 'SteelWorks', 'Brand#6', 'Steel', 20, 'Pallet', 450.00, 'Construction grade', '11'),
(7, 'Glass Panel', 'GlassTech', 'Brand#7', 'Glass', 6, 'Crate', 175.00, 'Tempered glass', '07'),
(8, 'Wood Board', 'Timber Inc', 'Brand#8', 'Wood', 14, 'Bundle', 67.50, 'Pine wood', '04'),
(9, 'Brass Fitting', 'Brass Corp', 'Brand#9', 'Brass', 8, 'Box', 34.25, 'Plumbing parts', '05'),
(10, 'Nylon Rope', 'Nylon Ltd', 'Brand#10', 'Nylon', 11, 'Coil', 28.99, 'Strong and durable', '03'),
(11, 'Concrete Block', 'Concrete Inc', 'Brand#11', 'Concrete', 18, 'Pallet', 120.00, 'Building material', '05'),
(12, 'Ceramic Tile', 'Ceramic Co', 'Brand#12', 'Ceramic', 9, 'Case', 89.00, 'Floor tile', '11'),
(13, 'Silicon Chip', 'SiliconTech', 'Brand#13', 'Silicon', 3, 'Tray', 345.00, 'Semiconductor', '07'),
(14, 'Copper Tubing', 'CopperWorks', 'Brand#14', 'Copper', 10, 'Roll', 285.50, 'AC grade', '05'),
(15, 'Iron Casting', 'IronWorks', 'Brand#15', 'Iron', 16, 'Crate', 195.00, 'Cast iron', '11'),
(16, 'Zinc Plate', 'Zinc Corp', 'Brand#16', 'Zinc', 7, 'Sheet', 76.00, 'Galvanized', '05'),
(17, 'Bronze Bearing', 'Bronze Ltd', 'Brand#17', 'Bronze', 6, 'Box', 150.00, 'Heavy duty', '05'),
(18, 'Titanium Screw', 'Titanium Inc', 'Brand#18', 'Titanium', 4, 'Jar', 420.00, 'Aerospace grade', '07'),
(19, 'Lead Pipe', 'Lead Corp', 'Brand#19', 'Lead', 12, 'Bulk', 95.00, 'Heavy metal', '05'),
(20, 'Nickel Plate', 'NickelWorks', 'Brand#20', 'Nickel', 8, 'Sheet', 210.00, 'Corrosion resistant', '07'),
(21, 'Cotton Fabric', 'Cotton Co', 'Brand#21', 'Cotton', 13, 'Bale', 55.00, 'Textile grade', '03'),
(22, 'Wool Yarn', 'Wool Inc', 'Brand#22', 'Wool', 9, 'Spool', 75.00, 'Premium wool', '04'),
(23, 'Leather Hide', 'LeatherWorks', 'Brand#23', 'Leather', 14, 'Roll', 340.00, 'Full grain', '05'),
(24, 'Carbon Fiber', 'CarbonTech', 'Brand#24', 'Carbon', 5, 'Sheet', 890.00, 'Lightweight strong', '07'),
(25, 'Glass Fiber', 'Fiberglass Inc', 'Brand#25', 'Glass', 10, 'Roll', 270.00, 'Insulation', '05'),
(26, 'Cork Board', 'Cork Corp', 'Brand#26', 'Cork', 12, 'Sheet', 45.00, 'Natural material', '11'),
(27, 'Hemp Rope', 'Hemp Ltd', 'Brand#27', 'Hemp', 15, 'Coil', 35.00, 'Eco friendly', '03'),
(28, 'Bamboo Pole', 'Bamboo Inc', 'Brand#28', 'Bamboo', 18, 'Bundle', 120.00, 'Renewable resource', '07'),
(29, 'PVC Pipe', 'PVC Corp', 'Brand#29', 'PVC', 10, 'Bulk', 48.00, 'Electrical conduit', '05'),
(30, 'ABS Plastic', 'ABS Inc', 'Brand#30', 'ABS', 8, 'Box', 140.00, 'Engineering plastic', '07');


-- ============================================
-- 6. Таблица partsupp
-- ============================================
CREATE TABLE partsupp (
    ps_partkey INTEGER REFERENCES part(p_partkey),
    ps_suppkey INTEGER REFERENCES supplier(s_suppkey),
    ps_availqty INTEGER,
    ps_supplycost NUMERIC(15,2),
    ps_comment CHARACTER VARYING(199),
    n_emp CHARACTER(2),
    PRIMARY KEY (ps_partkey, ps_suppkey)
);

INSERT INTO partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment, n_emp) VALUES
(1, 1, 500, 75.00, 'Bulk order, competitive price', '05'),
(1, 2, 300, 80.00, 'Limited stock', '05'),
(1, 3, 400, 70.00, 'Best price in bulk', '11'),
(2, 2, 600, 45.00, 'Multiple orders, reliable', '05'),
(2, 4, 350, 50.00, 'New supplier, good quality', '07'),
(3, 5, 250, 120.00, 'Premium copper', '07'),
(3, 7, 200, 130.00, 'High purity', '11'),
(4, 6, 1000, 22.00, 'Bulk plastic pipes', '07'),
(4, 9, 800, 25.00, 'Competitive pricing', '05'),
(5, 11, 1500, 6.00, 'High volume', '04'),
(5, 13, 1200, 7.50, 'Good quality gaskets', '11'),
(6, 8, 100, 225.00, 'Premium steel', '05'),
(6, 10, 80, 240.00, 'Special order', '11'),
(7, 12, 200, 88.00, 'High quality glass', '11'),
(7, 14, 150, 95.00, 'Tempered glass', '07'),
(8, 15, 700, 34.00, 'Pine wood in bulk', '11'),
(8, 17, 600, 37.00, 'Hardwood order', '11'),
(9, 16, 400, 17.00, 'Brass fittings', '11'),
(9, 19, 350, 18.50, 'Plumbing supplies', '03'),
(10, 18, 800, 14.00, 'Nylon rope in bulk', '10'),
(10, 20, 750, 15.00, 'Quality nylon', '02'),
(11, 21, 500, 60.00, 'Building grade', '05'),
(11, 23, 450, 65.00, 'Concrete blocks', '11'),
(12, 22, 300, 44.00, 'Ceramic tiles', '07'),
(12, 24, 280, 46.00, 'Flooring order', '07'),
(13, 25, 100, 170.00, 'High-end chips', '07'),
(13, 26, 90, 180.00, 'Premium quality', '05'),
(14, 27, 250, 140.00, 'Copper coils', '11'),
(14, 28, 200, 150.00, 'Industrial grade', '04'),
(15, 29, 300, 98.00, 'Cast iron order', '07'),
(15, 30, 250, 105.00, 'Quality casting', '05');