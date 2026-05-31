-- MySQL Database Schema and Seed Data for Lavitex
-- Generated on: 2026-05-31T19:47:17.101Z

/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE IF NOT EXISTS lavitex_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE lavitex_db;

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
('aaaaaaaa-0001-0001-0001-000000000001', 'Algodón 100%', 'Fibra natural suave y transpirable, ideal para hotelería de lujo'),
('aaaaaaaa-0001-0001-0001-000000000002', 'Percal 200 hilos', 'Tejido de algodón fino con acabado sedoso y durabilidad superior'),
('aaaaaaaa-0001-0001-0001-000000000003', 'Satén', 'Superficie brillante y suave, aspecto lujoso y elegante'),
('aaaaaaaa-0001-0001-0001-000000000004', 'Microfibra', 'Tejido sintético ultrasuave, resistente y de secado rápido'),
('aaaaaaaa-0001-0001-0001-000000000005', 'Bambú', 'Fibra ecológica, antibacterial y termorreguladora'),
('aaaaaaaa-0001-0001-0001-000000000006', 'Lino', 'Tejido natural premium con textura característica y alta resistencia'),
('aaaaaaaa-0001-0001-0001-000000000007', 'Jacquard', 'Tejido con patrones bordados en relieve, alta elegancia'),
('aaaaaaaa-0001-0001-0001-000000000008', 'Poliéster satinado a rayas', 'Tela fresca y resistente con acabado satinado elegante'),
('aaaaaaaa-0001-0001-0001-000000000009', '50% Algodón / 50% Poliéster', 'Mezcla equilibrada para mayor durabilidad y confort'),
('aaaaaaaa-0001-0001-0001-000000000010', 'Felpa Premium', 'Tejido absorbente y suave de alta calidad'),
('aaaaaaaa-0001-0001-0001-000000000011', 'Tergal', 'Tela resistente ideal para mantelería y cortinas'),
('aaaaaaaa-0001-0001-0001-000000000012', 'Gabardina', 'Tejido de algodón resistente para uniformes y mandiles');

-- --------------------------------------------------------
-- Dumping data for table measurements
-- --------------------------------------------------------
INSERT INTO measurements (id, label, type) VALUES
('bbbbbbbb-0001-0001-0001-000000000001', 'Individual (Twin)', 'size'),
('bbbbbbbb-0001-0001-0001-000000000002', 'Matrimonial (Full)', 'size'),
('bbbbbbbb-0001-0001-0001-000000000003', 'Queen', 'size'),
('bbbbbbbb-0001-0001-0001-000000000004', 'King', 'size'),
('bbbbbbbb-0001-0001-0001-000000000005', '50x70 cm', 'dimension'),
('bbbbbbbb-0001-0001-0001-000000000006', '70x140 cm', 'dimension'),
('bbbbbbbb-0001-0001-0001-000000000007', '100x150 cm', 'dimension'),
('bbbbbbbb-0001-0001-0001-000000000008', '45x45 cm', 'dimension'),
('bbbbbbbb-0001-0001-0001-000000000009', 'Estándar', 'size'),
('bbbbbbbb-0001-0001-0001-000000000010', 'Unitalla', 'size'),
('bbbbbbbb-0001-0001-0001-000000000011', '90x150 cm', 'dimension'),
('bbbbbbbb-0001-0001-0001-000000000012', '30x30 cm', 'dimension'),
('bbbbbbbb-0001-0001-0001-000000000013', '40x60 cm', 'dimension');

-- --------------------------------------------------------
-- Dumping data for table products
-- --------------------------------------------------------
INSERT INTO products (id, slug, title, description, main_image, gallery, category, is_active, created_at, updated_at, is_featured, mercadolibre_url, amazon_url) VALUES
('0544841f-5e8d-43cc-b649-ca493f935654', 'protector-de-colchon-capitonado-con-resorte', 'Protector de colchón capitonado con resorte', 'Su acolchado ligero permite proteger tu colchón al mismo tiempo que brinda mayor comodidad y confort, los resortes se ajustan muy bien para que no se mueva.', 'https://images.unsplash.com/photo-1632053003290-7f28d84a706f?auto=format&fit=crop&q=80&w=800', '[]', 'Blancos', 1, '2026-05-02T21:14:07.611936+00:00', '2026-05-02T21:14:07.611936+00:00', 1, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('a34babbf-ace7-475b-8dd4-ed35373a0086', 'protector-de-colchon-capitonado-de-cajon', 'Protector de colchón capitonado de cajón', 'Protección integral con ajuste tipo cajón que envuelve el colchón para evitar desplazamientos.', 'https://images.unsplash.com/photo-1584132967334-10e028bd69f7?auto=format&fit=crop&q=80&w=800', '[]', 'Blancos', 1, '2026-05-02T21:14:07.611936+00:00', '2026-05-02T21:14:07.611936+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('db71c363-8177-45d9-b82b-5dd3727c6cca', 'protector-de-colchon-impermeable-funda-completa', 'Protector de colchón impermeable funda completa', 'Funda impermeable tipo duvet con cierre que cubre totalmente el colchón, protegiéndolo de líquidos y ácaros.', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&q=80&w=800', '[]', 'Blancos', 1, '2026-05-02T21:14:07.611936+00:00', '2026-05-02T21:14:07.611936+00:00', 1, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('919efbe1-5316-4eaf-a708-9fe8ffabd1dd', 'batas-paciente', 'Batas paciente', 'Batas diseñadas para la comodidad del paciente y facilidad de uso clínico.', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&q=80&w=800', '[]', 'Hospital', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('8389e124-65ee-48c3-b7dd-51bc30b3e87e', 'campos-medicos', 'Campos médicos', 'Textiles esterilizables y resistentes para entornos quirúrgicos y médicos.', 'https://images.unsplash.com/photo-1516549655169-df83a0774514?auto=format&fit=crop&q=80&w=800', '[]', 'Hospital', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('60f88a98-d51e-40b9-9e16-22bfff06af7e', 'cortinas-blackout', 'Cortinas blackout', 'Control total de la luz y privacidad, ideales para un descanso ininterrumpido.', 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&q=80&w=800', '[]', 'Decorativos', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 1, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('0745190c-fd47-4846-93b5-88bf2789a6cd', 'traslucidas-y-semi-traslucidas', 'Traslúcidas y semi-traslúcidas', 'Elegancia que permite el paso de luz natural, creando ambientes suaves y acogedores.', 'https://images.unsplash.com/photo-1572635196237-14b3f281503f?auto=format&fit=crop&q=80&w=800', '[]', 'Decorativos', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('46121f85-428c-4712-aaa2-04d938573796', 'toallas-de-alberca', 'Toallas de alberca', 'Toallas de gran tamaño y alta absorción, perfectas para áreas exteriores y albercas.', 'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?auto=format&fit=crop&q=80&w=800', '[]', 'Felpa', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 1, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('f8ae1808-3968-4a76-8e11-6c063686f44c', 'toallas-de-bano', 'Toallas de baño', 'Suavidad y absorción superior para el uso diario, diseñadas para durar.', 'https://images.unsplash.com/photo-1583912267550-d44d4a3c399a?auto=format&fit=crop&q=80&w=800', '[]', 'Felpa', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('b7bb4b92-ecd5-46a5-8816-5e7c4878b23a', 'cortinas-de-bano', 'Cortinas de baño', 'Funcionalidad y diseño para el baño, resistentes a la humedad y fáciles de lavar.', 'https://images.unsplash.com/photo-1620626011761-9963d7521476?auto=format&fit=crop&q=80&w=800', '[]', 'Decorativos', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('d597a8ca-8c1d-4525-a2dd-d500510e89e4', 'balinesas', 'Balinesas', 'Cortinas con estilo tropical y relajado, perfectas para climas costeros.', 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', '[]', 'Decorativos', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('d8b74054-1309-41a8-ac0c-1d59738f98ed', 'rodapie', 'Rodapié', 'Faldón elegante que oculta la base de la cama, brindando un acabado profesional.', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&q=80&w=800', '[]', 'Decorativos', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('17f88f82-9330-4956-ae1d-86295f71dbdd', 'pie-de-cama', 'Pie de cama', 'Acento decorativo que añade una capa de color y textura al final de la cama.', 'https://images.unsplash.com/photo-1616627561950-9f746e330171?auto=format&fit=crop&q=80&w=800', '[]', 'Decorativos', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('597a48a0-073c-4edf-873e-aa52a1f2e3f5', 'cojines', 'Cojines', 'Cojines decorativos para realzar cualquier espacio con estilo y confort.', 'https://images.unsplash.com/photo-1584132915807-fd1f5fbc078f?auto=format&fit=crop&q=80&w=800', '[]', 'Decorativos', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('03cc4b79-111e-4879-8ee1-dbaabab01228', 'sabanas', 'Sábanas', 'Juego de sábanas suaves y resistentes, diseñadas para el uso rudo hotelero sin perder el confort.', 'https://images.unsplash.com/photo-1629949009765-40f74d943a86?auto=format&fit=crop&q=80&w=800', '[]', 'Blancos', 1, '2026-05-02T21:14:07.611936+00:00', '2026-05-02T21:14:07.611936+00:00', 1, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('b78297d0-0c38-44c8-8c37-3c65096779b0', 'fundas-y-protector-de-almohadas', 'Fundas y Protector de Almohadas', 'Protección esencial para prolongar la vida útil de tus almohadas con suavidad al tacto.', 'https://images.unsplash.com/photo-1584132915807-fd1f5fbc078f?auto=format&fit=crop&q=80&w=800', '[]', 'Blancos', 1, '2026-05-02T21:14:07.611936+00:00', '2026-05-02T21:14:07.611936+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('b8027755-a210-49c5-9bf3-982f6ce6ce57', 'almohadas', 'Almohadas', 'Almohadas con relleno de alta calidad que mantienen su forma y brindan un soporte óptimo.', 'https://images.unsplash.com/photo-1574633966429-1064299b93bc?auto=format&fit=crop&q=80&w=800', '[]', 'Blancos', 1, '2026-05-02T21:14:07.611936+00:00', '2026-05-02T21:14:07.611936+00:00', 1, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('25ec15ff-416c-4047-82e8-2a3555334581', 'duvet-e-insertos', 'Duvet e insertos', 'Fundas duvet y rellenos suaves que aportan calidez y elegancia a cualquier habitación.', 'https://images.unsplash.com/photo-1616627561839-014173700d2d?auto=format&fit=crop&q=80&w=800', '[]', 'Blancos', 1, '2026-05-02T21:14:07.611936+00:00', '2026-05-02T21:14:07.611936+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('3c25d004-7765-43fe-a10d-56b4d86d23b9', 'sobrecamas', 'Sobrecamas', 'Sobrecamas ligeras y decorativas, ideales para climas cálidos y una presentación impecable.', 'https://images.unsplash.com/photo-1616627561950-9f746e330171?auto=format&fit=crop&q=80&w=800', '[]', 'Blancos', 1, '2026-05-02T21:14:07.611936+00:00', '2026-05-02T21:14:07.611936+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('9e09ce67-f182-41dc-9c95-f4f2b1a3c6c7', 'edredones', 'Edredones', 'Edredones acolchados con diseños variados que combinan estilo y funcionalidad.', 'https://images.unsplash.com/photo-1505691723518-36a5ac3be353?auto=format&fit=crop&q=80&w=800', '[]', 'Blancos', 1, '2026-05-02T21:14:07.611936+00:00', '2026-05-02T21:14:07.611936+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('fadf73d7-c7cd-47cd-bf4a-a575491119d2', 'cobertores', 'Cobertores', 'Máxima calidez para noches frescas, con texturas suaves y duraderas.', 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?auto=format&fit=crop&q=80&w=800', '[]', 'Blancos', 1, '2026-05-02T21:14:07.611936+00:00', '2026-05-02T21:14:07.611936+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('cedcb58e-4a13-4981-8bb4-530dd3ddd971', 'toallas-de-manos', 'Toallas de manos', 'El complemento perfecto para el baño, con la misma calidad y suavidad premium.', 'https://images.unsplash.com/photo-1583912267550-d44d4a3c399a?auto=format&fit=crop&q=80&w=800', '[]', 'Felpa', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('b617d60f-37d6-4470-a121-da7039be2bb1', 'tapete', 'Tapete', 'Tapetes de felpa absorbentes para mayor seguridad y confort al salir de la ducha.', 'https://images.unsplash.com/photo-1583912267550-d44d4a3c399a?auto=format&fit=crop&q=80&w=800', '[]', 'Felpa', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('ab9ec762-8058-4a65-b041-626f1139c146', 'faciales', 'Faciales', 'Pequeñas toallas faciales de tacto delicado, ideales para spas y hoteles.', 'https://images.unsplash.com/photo-1583912267550-d44d4a3c399a?auto=format&fit=crop&q=80&w=800', '[]', 'Felpa', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('5ad10c6a-171f-4199-aa92-cd458a15995a', 'cilindros-y-fundas-para-cilindros', 'Cilindros y Fundas para Cilindros', 'Accesorios esenciales para el soporte y confort durante tratamientos de spa.', 'https://images.unsplash.com/photo-1544161515-4af6b1d4640d?auto=format&fit=crop&q=80&w=800', '[]', 'Spa', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('d4163ebd-0b9e-459c-a42d-bc81e53275b9', 'pabellones', 'Pabellones', 'Estructuras ligeras que añaden un toque romántico y protección a la cama.', 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&q=80&w=800', '[]', 'Decorativos', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('70aa7754-8f20-4ca5-9937-865abb819028', 'servilletas', 'Servilletas', 'Servilletas de tela duraderas y fáciles de lavar, ideales para restaurantes y eventos.', 'https://images.unsplash.com/photo-1544145945-f904253db0ad?auto=format&fit=crop&q=80&w=800', '[]', 'Mantelería', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('cb166580-6ae6-4367-ba94-4b4ee7d6c886', 'manteles', 'Manteles', 'Confección de manteles a la medida para todo tipo de mesas, con gran variedad de telas.', 'https://images.unsplash.com/photo-1595113316349-9fa4ee24f884?auto=format&fit=crop&q=80&w=800', '[]', 'Mantelería', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('924dae7b-5dcd-4608-a5ab-a9e11923da0b', 'bambalinas', 'Bambalinas', 'Faldones decorativos para mesas que realzan la presentación de cualquier evento.', 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?auto=format&fit=crop&q=80&w=800', '[]', 'Mantelería', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('f172efde-b0a8-4a51-b87c-980ca0acd5e6', 'listones', 'Listones', 'Detalles decorativos para sillas y mantelería que aportan un toque de color.', 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?auto=format&fit=crop&q=80&w=800', '[]', 'Mantelería', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('2047ad97-ca85-43d5-a8ca-30002175cbb7', 'cubresillas', 'Cubresillas', 'Fundas ajustables para sillas que transforman instantáneamente cualquier salón.', 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?auto=format&fit=crop&q=80&w=800', '[]', 'Mantelería', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('b2f09215-af9c-4dab-926a-06c847951945', 'tortilleros-portacalientes', 'Tortilleros portacalientes', 'Accesorios tradicionales para mantener el calor de los alimentos en la mesa.', 'https://images.unsplash.com/photo-1595113316349-9fa4ee24f884?auto=format&fit=crop&q=80&w=800', '[]', 'Mantelería', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('70c1011d-e1ee-49db-9d2c-4cfa9f036a9d', 'bolsas', 'Bolsas', 'Bolsas de tela personalizables para promoción y uso diario, ecológicas y resistentes.', 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&q=80&w=800', '[]', 'Promocionales', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('6df18046-6dfd-4b37-8a07-058cc33274a0', 'playeras', 'Playeras', 'Playeras de algodón de alta calidad, listas para personalización con tu marca.', 'https://images.unsplash.com/photo-1521572267360-ee0c2909d518?auto=format&fit=crop&q=80&w=800', '[]', 'Promocionales', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
('7a92d670-732f-4025-8cd3-14e931bf392d', 'mandiles', 'Mandiles', 'Mandiles de trabajo resistentes y funcionales para diversos usos comerciales.', 'https://images.unsplash.com/photo-1581622558663-b2e33377dfb2?auto=format&fit=crop&q=80&w=800', '[]', 'Promocionales', 1, '2026-05-02T21:14:35.382265+00:00', '2026-05-02T21:14:35.382265+00:00', 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx');

-- --------------------------------------------------------
-- Dumping data for table product_variants
-- --------------------------------------------------------
INSERT INTO product_variants (id, product_id, fabric_type_id, measurement_id, sku, price, stock, is_active, created_at) VALUES
('f96cefdb-338e-4273-8e04-b835dbc18d59', 'cccccccc-0001-0001-0001-000000000001', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000001', 'SAB-ALG-TWIN', 450, 50, 1, '2026-04-26T22:11:42.862563+00:00'),
('52165f01-5127-486d-a3a9-620d746b4e2a', 'cccccccc-0001-0001-0001-000000000001', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000002', 'SAB-ALG-FULL', 550, 40, 1, '2026-04-26T22:11:42.862563+00:00'),
('59b0ecd1-0223-42e9-8281-5cafd8e5fb8b', 'cccccccc-0001-0001-0001-000000000001', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000003', 'SAB-ALG-QUEEN', 650, 35, 1, '2026-04-26T22:11:42.862563+00:00'),
('c7258308-ff90-409b-bd45-abc787b14c32', 'cccccccc-0001-0001-0001-000000000001', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000004', 'SAB-ALG-KING', 750, 30, 1, '2026-04-26T22:11:42.862563+00:00'),
('2b2cb8b7-465d-4926-8a20-69c88879514e', 'cccccccc-0001-0001-0001-000000000002', 'aaaaaaaa-0001-0001-0001-000000000002', 'bbbbbbbb-0001-0001-0001-000000000001', 'SAB-PER-TWIN', 520, 45, 1, '2026-04-26T22:11:42.862563+00:00'),
('2085a91c-180c-4006-b899-5abeb2bb6f64', 'cccccccc-0001-0001-0001-000000000002', 'aaaaaaaa-0001-0001-0001-000000000002', 'bbbbbbbb-0001-0001-0001-000000000003', 'SAB-PER-QUEEN', 720, 30, 1, '2026-04-26T22:11:42.862563+00:00'),
('959ed00f-83c4-411c-af48-977e5e9ccd54', 'cccccccc-0001-0001-0001-000000000002', 'aaaaaaaa-0001-0001-0001-000000000002', 'bbbbbbbb-0001-0001-0001-000000000004', 'SAB-PER-KING', 820, 25, 1, '2026-04-26T22:11:42.862563+00:00'),
('b077bbfc-9ce1-4231-83a7-11b49424b6c2', 'cccccccc-0001-0001-0001-000000000003', 'aaaaaaaa-0001-0001-0001-000000000003', 'bbbbbbbb-0001-0001-0001-000000000003', 'SAB-SAT-QUEEN', 950, 20, 1, '2026-04-26T22:11:42.862563+00:00'),
('a65f2b9d-b646-4be7-9957-7b44dddecf9a', 'cccccccc-0001-0001-0001-000000000003', 'aaaaaaaa-0001-0001-0001-000000000003', 'bbbbbbbb-0001-0001-0001-000000000004', 'SAB-SAT-KING', 1100, 15, 1, '2026-04-26T22:11:42.862563+00:00'),
('8b644964-df70-4ce0-8c02-e6d4f718d330', 'cccccccc-0001-0001-0001-000000000004', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000005', 'ALM-MIC-50X70', 180, 100, 1, '2026-04-26T22:11:42.862563+00:00'),
('726bc636-608d-41ca-9834-47bfb7c26e16', 'cccccccc-0001-0001-0001-000000000004', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000006', 'ALM-MIC-70X140', 220, 80, 1, '2026-04-26T22:11:42.862563+00:00'),
('aad53e0e-c3f8-4c6a-94fb-a6d962dc45ae', 'cccccccc-0001-0001-0001-000000000005', 'aaaaaaaa-0001-0001-0001-000000000005', 'bbbbbbbb-0001-0001-0001-000000000005', 'ALM-BAM-50X70', 240, 60, 1, '2026-04-26T22:11:42.862563+00:00'),
('90ac52d5-fc04-4648-9295-e20d76e87d6c', 'cccccccc-0001-0001-0001-000000000005', 'aaaaaaaa-0001-0001-0001-000000000005', 'bbbbbbbb-0001-0001-0001-000000000006', 'ALM-BAM-70X140', 300, 45, 1, '2026-04-26T22:11:42.862563+00:00'),
('ec8f8d94-c95b-40bd-bab8-89e2a9c387dd', 'cccccccc-0001-0001-0001-000000000006', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000006', 'TOA-SPA-70X140', 280, 200, 1, '2026-04-26T22:11:42.862563+00:00'),
('fcbdb151-b2af-4326-9876-d16a7dd9b7b1', 'cccccccc-0001-0001-0001-000000000006', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000007', 'TOA-SPA-100X150', 350, 150, 1, '2026-04-26T22:11:42.862563+00:00'),
('8378e739-466b-4fdf-a457-df3e9e46da51', 'cccccccc-0001-0001-0001-000000000007', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000005', 'TOA-CARA-50X70', 95, 300, 1, '2026-04-26T22:11:42.862563+00:00'),
('ff3e5f46-6f13-45f7-82f1-cec4f61c6ec0', 'cccccccc-0001-0001-0001-000000000008', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000007', 'TOA-PIS-100X150', 320, 120, 1, '2026-04-26T22:11:42.862563+00:00'),
('e8ffdc46-f7ed-406e-831a-4a5f0bd8e8ac', 'cccccccc-0001-0001-0001-000000000009', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000003', 'COB-PLU-QUEEN', 1800, 20, 1, '2026-04-26T22:11:42.862563+00:00'),
('5aa408bf-d557-4e43-ae48-67d4460e8568', 'cccccccc-0001-0001-0001-000000000009', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000004', 'COB-PLU-KING', 2200, 15, 1, '2026-04-26T22:11:42.862563+00:00'),
('9ae2d4ce-8a98-49fa-8df0-6a7854678da7', 'cccccccc-0001-0001-0001-000000000010', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000002', 'COB-FIB-FULL', 750, 35, 1, '2026-04-26T22:11:42.862563+00:00'),
('dac689f1-653b-4af3-9aca-4b6c77592138', 'cccccccc-0001-0001-0001-000000000010', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000003', 'COB-FIB-QUEEN', 900, 30, 1, '2026-04-26T22:11:42.862563+00:00'),
('09e6d6d3-1e0b-4697-bfaa-7231e5054dcc', 'cccccccc-0001-0001-0001-000000000010', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000004', 'COB-FIB-KING', 1050, 25, 1, '2026-04-26T22:11:42.862563+00:00'),
('1d33f165-7787-4218-9474-9912d21f88a9', 'cccccccc-0001-0001-0001-000000000011', 'aaaaaaaa-0001-0001-0001-000000000006', NULL, 'MAN-LIN-STD', 380, 80, 1, '2026-04-26T22:11:42.862563+00:00'),
('0f1e88ba-8ade-407d-9d94-785f6a50ff92', 'cccccccc-0001-0001-0001-000000000012', 'aaaaaaaa-0001-0001-0001-000000000007', NULL, 'MAN-JAC-STD', 580, 40, 1, '2026-04-26T22:11:42.862563+00:00'),
('04eaac73-c0cd-45a2-b494-9f87e03db90c', 'cccccccc-0001-0001-0001-000000000013', 'aaaaaaaa-0001-0001-0001-000000000005', 'bbbbbbbb-0001-0001-0001-000000000002', 'CCO-BAM-FULL', 420, 30, 1, '2026-04-26T22:11:42.862563+00:00'),
('facbd5b2-3c06-4a5e-987e-f53c0f1357de', 'cccccccc-0001-0001-0001-000000000013', 'aaaaaaaa-0001-0001-0001-000000000005', 'bbbbbbbb-0001-0001-0001-000000000003', 'CCO-BAM-QUEEN', 490, 25, 1, '2026-04-26T22:11:42.862563+00:00'),
('8da24c5f-f634-4015-9ef7-e44267482e80', 'cccccccc-0001-0001-0001-000000000013', 'aaaaaaaa-0001-0001-0001-000000000005', 'bbbbbbbb-0001-0001-0001-000000000004', 'CCO-BAM-KING', 560, 20, 1, '2026-04-26T22:11:42.862563+00:00'),
('b908ace3-5260-4010-975d-5bf25d9baeb6', 'cccccccc-0001-0001-0001-000000000014', 'aaaaaaaa-0001-0001-0001-000000000002', 'bbbbbbbb-0001-0001-0001-000000000003', 'CCO-ACO-QUEEN', 680, 22, 1, '2026-04-26T22:11:42.862563+00:00'),
('b922fd52-bae8-49d6-a2e7-8e5c46d848cd', 'cccccccc-0001-0001-0001-000000000014', 'aaaaaaaa-0001-0001-0001-000000000002', 'bbbbbbbb-0001-0001-0001-000000000004', 'CCO-ACO-KING', 780, 18, 1, '2026-04-26T22:11:42.862563+00:00'),
('0912af43-1df8-4ba6-8ac7-8ac6372b093c', 'cccccccc-0001-0001-0001-000000000015', 'aaaaaaaa-0001-0001-0001-000000000001', NULL, 'DEL-CAM-STD', 120, 150, 1, '2026-04-26T22:11:42.862563+00:00'),
('7e936c64-b553-4426-a7fa-18c6da9d27a0', 'cccccccc-0001-0001-0001-000000000016', 'aaaaaaaa-0001-0001-0001-000000000001', NULL, 'BAT-SPA-UNI', 480, 80, 1, '2026-04-26T22:11:42.862563+00:00'),
('2f4e8b1c-c9c0-4698-8ad5-8eecdbee5cf4', 'cccccccc-0001-0001-0001-000000000017', 'aaaaaaaa-0001-0001-0001-000000000003', 'bbbbbbbb-0001-0001-0001-000000000005', 'FUN-SAT-50X70', 160, 120, 1, '2026-04-26T22:11:42.862563+00:00'),
('58567d5c-21ef-4386-85d3-10fbd1f271d3', 'cccccccc-0001-0001-0001-000000000017', 'aaaaaaaa-0001-0001-0001-000000000003', 'bbbbbbbb-0001-0001-0001-000000000006', 'FUN-SAT-70X140', 200, 90, 1, '2026-04-26T22:11:42.862563+00:00'),
('76c06af2-6925-4807-8413-df85bfd0dcff', 'cccccccc-0001-0001-0001-000000000018', 'aaaaaaaa-0001-0001-0001-000000000002', 'bbbbbbbb-0001-0001-0001-000000000003', 'FAL-PER-QUEEN', 310, 35, 1, '2026-04-26T22:11:42.862563+00:00'),
('ceea75d0-0799-46ce-bfa4-bf6b7ec27c91', 'cccccccc-0001-0001-0001-000000000018', 'aaaaaaaa-0001-0001-0001-000000000002', 'bbbbbbbb-0001-0001-0001-000000000004', 'FAL-PER-KING', 360, 28, 1, '2026-04-26T22:11:42.862563+00:00'),
('8c4a0383-2c3f-4067-be54-db701ea55afd', 'cccccccc-0001-0001-0001-000000000019', 'aaaaaaaa-0001-0001-0001-000000000006', 'bbbbbbbb-0001-0001-0001-000000000008', 'SER-LIN-45X45', 45, 500, 1, '2026-04-26T22:11:42.862563+00:00'),
('aa11b464-535f-4ce5-ad68-9c3f17acbf52', 'cccccccc-0001-0001-0001-000000000020', 'aaaaaaaa-0001-0001-0001-000000000007', 'bbbbbbbb-0001-0001-0001-000000000008', 'COJ-JAC-45X45', 280, 60, 1, '2026-04-26T22:11:42.862563+00:00'),
('6265dfd1-26b5-4034-b046-b4555d1fdf58', '0544841f-5e8d-43cc-b649-ca493f935654', 'aaaaaaaa-0001-0001-0001-000000000008', 'bbbbbbbb-0001-0001-0001-000000000001', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('2ac943cb-e52c-4744-89b2-b18d87002cc6', '0544841f-5e8d-43cc-b649-ca493f935654', 'aaaaaaaa-0001-0001-0001-000000000008', 'bbbbbbbb-0001-0001-0001-000000000002', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('a3e4b19e-0750-47ef-892c-29d3c5944174', '0544841f-5e8d-43cc-b649-ca493f935654', 'aaaaaaaa-0001-0001-0001-000000000008', 'bbbbbbbb-0001-0001-0001-000000000003', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('05a5c5ae-fd61-4f63-8191-423eedf5431a', '0544841f-5e8d-43cc-b649-ca493f935654', 'aaaaaaaa-0001-0001-0001-000000000008', 'bbbbbbbb-0001-0001-0001-000000000004', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('56a6a296-0727-4072-b3ae-142b1ff5174e', 'a34babbf-ace7-475b-8dd4-ed35373a0086', 'aaaaaaaa-0001-0001-0001-000000000008', 'bbbbbbbb-0001-0001-0001-000000000001', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('93958569-d225-4b80-963d-3de4692df467', 'a34babbf-ace7-475b-8dd4-ed35373a0086', 'aaaaaaaa-0001-0001-0001-000000000008', 'bbbbbbbb-0001-0001-0001-000000000002', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('4a25b1b5-65d3-4ae4-b54b-103d76d72cbd', 'a34babbf-ace7-475b-8dd4-ed35373a0086', 'aaaaaaaa-0001-0001-0001-000000000008', 'bbbbbbbb-0001-0001-0001-000000000003', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('0936c295-1fef-4b8f-8d5a-a722b9f08b7b', 'a34babbf-ace7-475b-8dd4-ed35373a0086', 'aaaaaaaa-0001-0001-0001-000000000008', 'bbbbbbbb-0001-0001-0001-000000000004', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('020fa400-2968-41a2-b4b8-4a11035f9457', 'db71c363-8177-45d9-b82b-5dd3727c6cca', 'aaaaaaaa-0001-0001-0001-000000000009', 'bbbbbbbb-0001-0001-0001-000000000001', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('a08601ef-5d91-42d1-8628-2e067ef2bb24', 'db71c363-8177-45d9-b82b-5dd3727c6cca', 'aaaaaaaa-0001-0001-0001-000000000009', 'bbbbbbbb-0001-0001-0001-000000000002', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('867aea52-1757-4e45-9758-c61c03543afe', 'db71c363-8177-45d9-b82b-5dd3727c6cca', 'aaaaaaaa-0001-0001-0001-000000000009', 'bbbbbbbb-0001-0001-0001-000000000003', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('f21dc7c9-4dd5-4f46-9c5e-6e9a3fb18314', 'db71c363-8177-45d9-b82b-5dd3727c6cca', 'aaaaaaaa-0001-0001-0001-000000000009', 'bbbbbbbb-0001-0001-0001-000000000004', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('75d21fbf-a8aa-4524-9e8d-5cd2b220d40c', '03cc4b79-111e-4879-8ee1-dbaabab01228', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000001', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('23fb5e5a-f850-419a-abc1-13e4213e1c99', '03cc4b79-111e-4879-8ee1-dbaabab01228', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000002', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('d13ced5c-849e-47d2-9112-3ba6d7e73ebd', '03cc4b79-111e-4879-8ee1-dbaabab01228', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000003', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('3e91fbe3-f481-4142-a930-7c7f816d64c4', '03cc4b79-111e-4879-8ee1-dbaabab01228', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000004', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('16b0dcab-26df-4eb2-b6ca-d3efa00655d3', '03cc4b79-111e-4879-8ee1-dbaabab01228', 'aaaaaaaa-0001-0001-0001-000000000002', 'bbbbbbbb-0001-0001-0001-000000000001', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('3b66876b-0519-4595-b829-3ca79cae711f', '03cc4b79-111e-4879-8ee1-dbaabab01228', 'aaaaaaaa-0001-0001-0001-000000000002', 'bbbbbbbb-0001-0001-0001-000000000002', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('e8e65ff8-5f77-4362-865c-c4a36e31af63', '03cc4b79-111e-4879-8ee1-dbaabab01228', 'aaaaaaaa-0001-0001-0001-000000000002', 'bbbbbbbb-0001-0001-0001-000000000003', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('742d4f47-efe9-4986-aef7-ed58752d0069', '03cc4b79-111e-4879-8ee1-dbaabab01228', 'aaaaaaaa-0001-0001-0001-000000000002', 'bbbbbbbb-0001-0001-0001-000000000004', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('c2f4cd04-61b8-4958-bb81-845724eb363a', 'b78297d0-0c38-44c8-8c37-3c65096779b0', 'aaaaaaaa-0001-0001-0001-000000000009', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('f4d3c9e9-014e-4a87-b0b8-fc63f0938f9d', 'b78297d0-0c38-44c8-8c37-3c65096779b0', 'aaaaaaaa-0001-0001-0001-000000000009', 'bbbbbbbb-0001-0001-0001-000000000004', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('3bbb5bd7-bb18-4c1c-a98f-eea3707682fc', 'b8027755-a210-49c5-9bf3-982f6ce6ce57', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('9180d5c7-dcf6-4bdd-a089-78744f34dde8', 'b8027755-a210-49c5-9bf3-982f6ce6ce57', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000004', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('e3c6d6bd-2ccf-4f5a-bca6-3f814501ba97', '25ec15ff-416c-4047-82e8-2a3555334581', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000001', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('5c258d93-eca2-4def-bb5f-7533b7eb47f0', '25ec15ff-416c-4047-82e8-2a3555334581', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000002', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('1e30713f-b5ed-4393-8b6c-726c4ef1e069', '25ec15ff-416c-4047-82e8-2a3555334581', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000003', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('e2a97986-3fba-46e4-8e9f-7f6cca132e6c', '25ec15ff-416c-4047-82e8-2a3555334581', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000004', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('242aac5c-abff-4b7b-8736-af546f88697f', '3c25d004-7765-43fe-a10d-56b4d86d23b9', 'aaaaaaaa-0001-0001-0001-000000000007', 'bbbbbbbb-0001-0001-0001-000000000001', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('41529229-9008-4e33-a580-96c4536952fa', '3c25d004-7765-43fe-a10d-56b4d86d23b9', 'aaaaaaaa-0001-0001-0001-000000000007', 'bbbbbbbb-0001-0001-0001-000000000002', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('eaa75f6e-495c-4598-961e-05923fe66cc7', '3c25d004-7765-43fe-a10d-56b4d86d23b9', 'aaaaaaaa-0001-0001-0001-000000000007', 'bbbbbbbb-0001-0001-0001-000000000003', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('c89aa90f-a4db-40b0-bda7-9c51d0ed19a8', '3c25d004-7765-43fe-a10d-56b4d86d23b9', 'aaaaaaaa-0001-0001-0001-000000000007', 'bbbbbbbb-0001-0001-0001-000000000004', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('83b46ea5-223b-4a48-b41a-24a1a969f28b', '9e09ce67-f182-41dc-9c95-f4f2b1a3c6c7', 'aaaaaaaa-0001-0001-0001-000000000009', 'bbbbbbbb-0001-0001-0001-000000000001', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('3818d051-0c90-4f9d-af54-e00efca8cfae', '9e09ce67-f182-41dc-9c95-f4f2b1a3c6c7', 'aaaaaaaa-0001-0001-0001-000000000009', 'bbbbbbbb-0001-0001-0001-000000000002', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('46035a28-b400-49ec-b8e5-2387a691314e', '9e09ce67-f182-41dc-9c95-f4f2b1a3c6c7', 'aaaaaaaa-0001-0001-0001-000000000009', 'bbbbbbbb-0001-0001-0001-000000000003', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('eef9f557-412d-411b-996d-f95e3bb1c7a0', '9e09ce67-f182-41dc-9c95-f4f2b1a3c6c7', 'aaaaaaaa-0001-0001-0001-000000000009', 'bbbbbbbb-0001-0001-0001-000000000004', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('412b3cea-0221-491c-9a3f-55774012fe07', 'fadf73d7-c7cd-47cd-bf4a-a575491119d2', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000001', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('9341d5ae-95ce-4e2c-b40b-7d2747a7bd57', 'fadf73d7-c7cd-47cd-bf4a-a575491119d2', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000002', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('a5f96349-3596-4bc0-bb7b-2492a42b2730', 'fadf73d7-c7cd-47cd-bf4a-a575491119d2', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000003', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('73c68333-0e0a-4296-b500-736999a77442', 'fadf73d7-c7cd-47cd-bf4a-a575491119d2', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000004', NULL, NULL, 0, 1, '2026-05-02T21:14:07.611936+00:00'),
('5e932284-6129-4611-a088-1f2617e3ba28', '5ad10c6a-171f-4199-aa92-cd458a15995a', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('8da6ce2e-c0f4-491e-a95f-545f91e738d9', '919efbe1-5316-4eaf-a708-9fe8ffabd1dd', 'aaaaaaaa-0001-0001-0001-000000000009', 'bbbbbbbb-0001-0001-0001-000000000010', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('b5d29723-aecd-4f64-9ce6-832001779904', '8389e124-65ee-48c3-b7dd-51bc30b3e87e', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('af0cdc7a-bc4f-4cf4-8124-52682a9dd07a', '60f88a98-d51e-40b9-9e16-22bfff06af7e', 'aaaaaaaa-0001-0001-0001-000000000011', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('3a97906d-f212-46b1-8d11-125fd965dcd3', '0745190c-fd47-4846-93b5-88bf2789a6cd', 'aaaaaaaa-0001-0001-0001-000000000011', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('463b909b-e241-4966-9cb8-3ffcdd070e42', 'b7bb4b92-ecd5-46a5-8816-5e7c4878b23a', 'aaaaaaaa-0001-0001-0001-000000000004', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('63226bb4-e24e-43db-8128-328342ec5921', 'd597a8ca-8c1d-4525-a2dd-d500510e89e4', 'aaaaaaaa-0001-0001-0001-000000000006', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('8097f0fe-0078-4f9f-92e5-8a41b6a365a6', 'd8b74054-1309-41a8-ac0c-1d59738f98ed', 'aaaaaaaa-0001-0001-0001-000000000009', 'bbbbbbbb-0001-0001-0001-000000000001', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('b6499e5d-70de-4ca4-9c58-0c2ecd52fc72', 'd8b74054-1309-41a8-ac0c-1d59738f98ed', 'aaaaaaaa-0001-0001-0001-000000000009', 'bbbbbbbb-0001-0001-0001-000000000004', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('6ac433c3-859e-4559-8de4-b01db9397bbc', '17f88f82-9330-4956-ae1d-86295f71dbdd', 'aaaaaaaa-0001-0001-0001-000000000007', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('9776d7d7-39fd-41f5-956c-e3c1d84b4fba', '597a48a0-073c-4edf-873e-aa52a1f2e3f5', 'aaaaaaaa-0001-0001-0001-000000000007', 'bbbbbbbb-0001-0001-0001-000000000008', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('98ed0613-5529-46ce-a479-ada36dac202f', 'd4163ebd-0b9e-459c-a42d-bc81e53275b9', 'aaaaaaaa-0001-0001-0001-000000000003', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('099d4700-d824-4b23-bfcc-f2e191cdbc81', '70aa7754-8f20-4ca5-9937-865abb819028', 'aaaaaaaa-0001-0001-0001-000000000011', 'bbbbbbbb-0001-0001-0001-000000000008', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('7b547e85-dd68-46ca-af66-da02b13bb27a', 'cb166580-6ae6-4367-ba94-4b4ee7d6c886', 'aaaaaaaa-0001-0001-0001-000000000011', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('5021883a-93a8-4a23-8b8f-6499bd8e3e34', '924dae7b-5dcd-4608-a5ab-a9e11923da0b', 'aaaaaaaa-0001-0001-0001-000000000011', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('dcce7499-e02d-4f8e-8328-7d16a2cfecc6', 'f172efde-b0a8-4a51-b87c-980ca0acd5e6', 'aaaaaaaa-0001-0001-0001-000000000003', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('ad1f09fc-10f1-40cc-81cb-b5d85bb3ebbd', '2047ad97-ca85-43d5-a8ca-30002175cbb7', 'aaaaaaaa-0001-0001-0001-000000000011', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('006c9a29-5894-4435-9ab2-8d8e6c1fd906', 'b2f09215-af9c-4dab-926a-06c847951945', 'aaaaaaaa-0001-0001-0001-000000000009', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('21e74d75-3c17-49e1-83ed-99ccc77a7ffd', '70c1011d-e1ee-49db-9d2c-4cfa9f036a9d', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000009', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('8b618a41-a2b6-4757-82ea-eb70aba9dd02', '6df18046-6dfd-4b37-8a07-058cc33274a0', 'aaaaaaaa-0001-0001-0001-000000000001', 'bbbbbbbb-0001-0001-0001-000000000010', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('1733630a-bd35-40f6-8fa7-35703db9c44a', '7a92d670-732f-4025-8cd3-14e931bf392d', 'aaaaaaaa-0001-0001-0001-000000000012', 'bbbbbbbb-0001-0001-0001-000000000010', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('72837e7e-19e3-4b97-93a9-3700b94ec4c0', '46121f85-428c-4712-aaa2-04d938573796', 'aaaaaaaa-0001-0001-0001-000000000010', 'bbbbbbbb-0001-0001-0001-000000000011', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('589a3224-6db9-450a-8c8c-1e8562831e09', 'f8ae1808-3968-4a76-8e11-6c063686f44c', 'aaaaaaaa-0001-0001-0001-000000000010', 'bbbbbbbb-0001-0001-0001-000000000006', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('05cb6257-5779-4e4a-a5a6-44140a1b8992', 'cedcb58e-4a13-4981-8bb4-530dd3ddd971', 'aaaaaaaa-0001-0001-0001-000000000010', 'bbbbbbbb-0001-0001-0001-000000000013', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('21ad6b1e-d691-4504-8aa8-225911accaac', 'b617d60f-37d6-4470-a121-da7039be2bb1', 'aaaaaaaa-0001-0001-0001-000000000010', 'bbbbbbbb-0001-0001-0001-000000000007', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00'),
('74b05bc7-ccac-4ffc-80e8-797238dd70c7', 'ab9ec762-8058-4a65-b041-626f1139c146', 'aaaaaaaa-0001-0001-0001-000000000010', 'bbbbbbbb-0001-0001-0001-000000000012', NULL, NULL, 0, 1, '2026-05-02T21:14:35.382265+00:00');

-- --------------------------------------------------------
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
                           'fabric_types', (SELECT JSON_OBJECT('id', ft.id, 'name', ft.name, 'description', ft.description) FROM fabric_types ft WHERE ft.id = pv.fabric_type_id),
                           'measurements', (SELECT JSON_OBJECT('id', m.id, 'label', m.label, 'type', m.type) FROM measurements m WHERE m.id = pv.measurement_id)
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
                           'fabric_types', (SELECT JSON_OBJECT('id', ft.id, 'name', ft.name, 'description', ft.description) FROM fabric_types ft WHERE ft.id = pv.fabric_type_id),
                           'measurements', (SELECT JSON_OBJECT('id', m.id, 'label', m.label, 'type', m.type) FROM measurements m WHERE m.id = pv.measurement_id)
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
