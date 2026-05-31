const fs = require('fs');
const path = require('path');

function escapeString(val) {
  if (val === null || val === undefined) {
    return 'NULL';
  }
  return `'${val.toString().replace(/'/g, "''")}'`;
}

function escapeJSON(val) {
  if (val === null || val === undefined) {
    return 'NULL';
  }
  return `'${JSON.stringify(val).replace(/'/g, "''")}'`;
}

function run() {
  const fabricTypes = JSON.parse(fs.readFileSync(path.join(__dirname, 'fabric_types.json'), 'utf8'));
  const measurements = JSON.parse(fs.readFileSync(path.join(__dirname, 'measurements.json'), 'utf8'));
  const products = JSON.parse(fs.readFileSync(path.join(__dirname, 'products.json'), 'utf8'));
  const productVariants = JSON.parse(fs.readFileSync(path.join(__dirname, 'product_variants.json'), 'utf8'));

  let sql = `-- MySQL Database Schema and Seed Data for Lavitex
-- Generated on: ${new Date().toISOString()}

CREATE DATABASE IF NOT EXISTS lavitex;
USE lavitex;

-- --------------------------------------------------------
-- Table structure for table fabric_types
-- --------------------------------------------------------
DROP TABLE IF EXISTS product_variants;
DROP TABLE IF EXISTS fabric_types;
CREATE TABLE fabric_types (
  id VARCHAR(36) NOT NULL,
  name VARCHAR(255) NOT NULL UNIQUE,
  description TEXT,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table measurements
-- --------------------------------------------------------
DROP TABLE IF EXISTS measurements;
CREATE TABLE measurements (
  id VARCHAR(36) NOT NULL,
  label VARCHAR(255) NOT NULL UNIQUE,
  type VARCHAR(50) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------
-- Table structure for table products
-- --------------------------------------------------------
DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id VARCHAR(36) NOT NULL,
  slug VARCHAR(255) NOT NULL UNIQUE,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  main_image VARCHAR(1024) NOT NULL,
  gallery JSON,
  category VARCHAR(100),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_featured BOOLEAN NOT NULL DEFAULT FALSE,
  mercadolibre_url VARCHAR(1024),
  amazon_url VARCHAR(1024),
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Add Full-Text index on title and description for search optimization
ALTER TABLE products ADD FULLTEXT INDEX idx_products_search (title, description);

-- --------------------------------------------------------
-- Table structure for table product_variants
-- --------------------------------------------------------
CREATE TABLE product_variants (
  id VARCHAR(36) NOT NULL,
  product_id VARCHAR(36) NOT NULL,
  fabric_type_id VARCHAR(36),
  measurement_id VARCHAR(36),
  sku VARCHAR(100),
  price DECIMAL(10, 2),
  stock INT DEFAULT 0,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  FOREIGN KEY (fabric_type_id) REFERENCES fabric_types(id) ON DELETE SET NULL,
  FOREIGN KEY (measurement_id) REFERENCES measurements(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------
-- Dumping data for table fabric_types
-- --------------------------------------------------------
INSERT INTO fabric_types (id, name, description) VALUES
`;

  sql += fabricTypes.map(ft => 
    `(${escapeString(ft.id)}, ${escapeString(ft.name)}, ${escapeString(ft.description)})`
  ).join(',\n') + ';\n\n';

  sql += `-- --------------------------------------------------------
-- Dumping data for table measurements
-- --------------------------------------------------------
INSERT INTO measurements (id, label, type) VALUES
`;

  sql += measurements.map(m => 
    `(${escapeString(m.id)}, ${escapeString(m.label)}, ${escapeString(m.type)})`
  ).join(',\n') + ';\n\n';

  sql += `-- --------------------------------------------------------
-- Dumping data for table products
-- --------------------------------------------------------
INSERT INTO products (id, slug, title, description, main_image, gallery, category, is_active, created_at, updated_at, is_featured, mercadolibre_url, amazon_url) VALUES
`;

  sql += products.map(p => {
    return `(${escapeString(p.id)}, ${escapeString(p.slug)}, ${escapeString(p.title)}, ${escapeString(p.description)}, ${escapeString(p.main_image)}, ${escapeJSON(p.gallery)}, ${escapeString(p.category)}, ${p.is_active ? 1 : 0}, ${escapeString(p.created_at)}, ${escapeString(p.updated_at)}, ${p.is_featured ? 1 : 0}, ${escapeString(p.mercadolibre_url)}, ${escapeString(p.amazon_url)})`;
  }).join(',\n') + ';\n\n';

  sql += `-- --------------------------------------------------------
-- Dumping data for table product_variants
-- --------------------------------------------------------
INSERT INTO product_variants (id, product_id, fabric_type_id, measurement_id, sku, price, stock, is_active, created_at) VALUES
`;

  sql += productVariants.map(pv => {
    return `(${escapeString(pv.id)}, ${escapeString(pv.product_id)}, ${escapeString(pv.fabric_type_id)}, ${escapeString(pv.measurement_id)}, ${escapeString(pv.sku)}, ${pv.price !== null ? pv.price : 'NULL'}, ${pv.stock !== null ? pv.stock : 0}, ${pv.is_active ? 1 : 0}, ${escapeString(pv.created_at)})`;
  }).join(',\n') + ';\n\n';

  sql += `-- --------------------------------------------------------
-- Stored Procedures for Searching Products
-- --------------------------------------------------------
DELIMITER //

DROP PROCEDURE IF EXISTS sp_search_products //
CREATE PROCEDURE sp_search_products(IN search_term VARCHAR(255))
BEGIN
    IF search_term IS NULL OR TRIM(search_term) = '' THEN
        SELECT p.*, 
               (
                   SELECT JSON_ARRAYAGG(
                       JSON_OBJECT(
                           'id', pv.id,
                           'sku', pv.sku,
                           'price', pv.price,
                           'stock', pv.stock,
                           'is_active', pv.is_active,
                           'fabric_type', (SELECT JSON_OBJECT('id', ft.id, 'name', ft.name, 'description', ft.description) FROM fabric_types ft WHERE ft.id = pv.fabric_type_id),
                           'measurement', (SELECT JSON_OBJECT('id', m.id, 'label', m.label, 'type', m.type) FROM measurements m WHERE m.id = pv.measurement_id)
                       )
                   )
                   FROM product_variants pv
                   WHERE pv.product_id = p.id AND pv.is_active = TRUE
               ) AS product_variants
        FROM products p
        WHERE p.is_active = TRUE
        ORDER BY p.created_at DESC;
    ELSE
        -- Perform Full-Text search or LIKE search depending on requirement.
        -- We will use LIKE here as it is very reliable for short strings/partial matches,
        -- but you can also use MATCH(p.title, p.description) AGAINST(search_term IN BOOLEAN MODE).
        SELECT p.*, 
               (
                   SELECT JSON_ARRAYAGG(
                       JSON_OBJECT(
                           'id', pv.id,
                           'sku', pv.sku,
                           'price', pv.price,
                           'stock', pv.stock,
                           'is_active', pv.is_active,
                           'fabric_type', (SELECT JSON_OBJECT('id', ft.id, 'name', ft.name, 'description', ft.description) FROM fabric_types ft WHERE ft.id = pv.fabric_type_id),
                           'measurement', (SELECT JSON_OBJECT('id', m.id, 'label', m.label, 'type', m.type) FROM measurements m WHERE m.id = pv.measurement_id)
                       )
                   )
                   FROM product_variants pv
                   WHERE pv.product_id = p.id AND pv.is_active = TRUE
               ) AS product_variants
        FROM products p
        WHERE p.is_active = TRUE 
          AND (p.title LIKE CONCAT('%', search_term, '%') OR p.description LIKE CONCAT('%', search_term, '%'))
        ORDER BY p.created_at DESC;
    END IF;
END //

DELIMITER ;
`;

  fs.writeFileSync(path.join(__dirname, '../mysql_db.sql'), sql, 'utf8');
  console.log('Successfully generated mysql_db.sql in the root directory!');
}

run();
