-- Instalación completa de MySQL para Lavitex del Caribe 2026
-- Fuente: public/docs/Catalogo-2026.pdf, productos de páginas 4 a 40.
-- El programa de recuperación y reparación de blancos (página 41) es un servicio y no se inserta como producto.
-- Precio queda NULL y stock queda en 0 porque el catálogo no publica precios ni inventario.
-- SKU queda NULL porque el catálogo no proporciona códigos SKU.
-- Enlaces temporales: índices de Mercado Libre México y Amazon México.
-- main_image usa recursos existentes en public/images; logo.png funciona como imagen temporal donde no hay foto propia.
-- Las variantes base con measurement_id/fabric_type_id NULL representan productos para los que el PDF no especifica opciones.

/*!40101 SET NAMES utf8mb4 */;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS lavitex_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE lavitex_db;

DROP PROCEDURE IF EXISTS sp_search_products;
DROP TABLE IF EXISTS product_variants;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS measurements;
DROP TABLE IF EXISTS fabric_types;

CREATE TABLE fabric_types (
  id VARCHAR(36) NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_fabric_types_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE measurements (
  id VARCHAR(36) NOT NULL,
  label VARCHAR(255) NOT NULL,
  type VARCHAR(50) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_measurements_label (label)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE products (
  id VARCHAR(36) NOT NULL,
  slug VARCHAR(255) NOT NULL,
  title VARCHAR(255) NOT NULL,
  description TEXT NULL,
  main_image VARCHAR(1024) NOT NULL,
  gallery JSON NULL,
  category VARCHAR(100) NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_featured BOOLEAN NOT NULL DEFAULT FALSE,
  mercadolibre_url VARCHAR(1024) NULL,
  amazon_url VARCHAR(1024) NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_products_slug (slug),
  KEY idx_products_active_featured (is_active, is_featured),
  KEY idx_products_category (category),
  FULLTEXT KEY idx_products_search (title, description)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE product_variants (
  id VARCHAR(36) NOT NULL,
  product_id VARCHAR(36) NOT NULL,
  fabric_type_id VARCHAR(36) NULL,
  measurement_id VARCHAR(36) NULL,
  sku VARCHAR(100) NULL,
  price DECIMAL(10, 2) NULL,
  stock INT NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_product_variants_product_active (product_id, is_active),
  KEY idx_product_variants_fabric (fabric_type_id),
  KEY idx_product_variants_measurement (measurement_id),
  CONSTRAINT fk_product_variants_product
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
  CONSTRAINT fk_product_variants_fabric
    FOREIGN KEY (fabric_type_id) REFERENCES fabric_types(id) ON DELETE SET NULL,
  CONSTRAINT fk_product_variants_measurement
    FOREIGN KEY (measurement_id) REFERENCES measurements(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET FOREIGN_KEY_CHECKS = 1;

START TRANSACTION;

-- 1) Tipos de tela y composiciones especificadas en el catálogo
INSERT INTO fabric_types (id, name, description) VALUES
  ('015e5704-5a12-4815-b16c-0ac538170aa8', 'Poliéster satinado a rayas con relleno Delcron', 'Tela 100% poliéster satinado a rayas y relleno Delcron.'),
  ('763f6c23-fae6-49e6-aacf-70acfdfa18b4', '50% algodón / 50% poliéster con poliuretano 100%', 'Tela transpirable 50% algodón y 50% poliéster, con relleno de poliuretano 100%.'),
  ('38b11e94-9a74-4d87-81f8-7d1e9a9f0fa3', 'Percal 180 hilos 50% poliéster / 50% algodón', 'Tela percal de 180 hilos con composición 50% poliéster y 50% algodón.'),
  ('8a5144f7-0c20-4903-9bd5-b3955ba81da8', 'Percal 200 hilos 50% poliéster / 50% algodón', 'Tela percal de 200 hilos con composición 50% poliéster y 50% algodón.'),
  ('72e23f35-af89-490e-9dea-097b28eba10e', 'Percal 300 hilos 100% algodón', 'Tela percal de 300 hilos elaborada en 100% algodón.'),
  ('5a420232-7caf-414d-9b59-2ef4915a0a24', 'Percal 180 hilos con relleno fibra 100% poliéster', 'Forro de percal 180 hilos, 50% poliéster y 50% algodón, con relleno de fibra 100% poliéster.'),
  ('33c9132e-37bd-4c60-a420-170119ae1028', 'Percal 180 hilos con relleno microgel', 'Forro de percal 180 hilos, 50% poliéster y 50% algodón, con relleno microgel.'),
  ('afc26652-faac-4098-8d6d-e241583917c1', 'Satin líneas 250 hilos 50% poliéster / 50% algodón', 'Tela satin de líneas, 250 hilos, con composición 50% poliéster y 50% algodón.'),
  ('fbb731c4-155d-4273-8b57-b480956b2a1e', 'Tela waffle', 'Tela waffle con textura; composición no especificada para este producto en el catálogo.'),
  ('13b311dc-e5ee-4db7-b6d9-6a9f1a4b8833', 'Polar Flanel 100% poliéster', 'Tela Polar Flanel elaborada en 100% poliéster.'),
  ('b7ce8ea9-80ce-4114-b3eb-abad574ece8d', 'Waffle 50% algodón / 50% poliéster', 'Tela waffle con composición 50% algodón y 50% poliéster.'),
  ('0c71f882-2fda-4bcc-b37f-b1816864afab', 'Bramante 50% algodón / 50% poliéster', 'Tela Bramante con composición 50% algodón y 50% poliéster.'),
  ('740c7b03-1da6-4e2d-9b91-8c8e1613488a', 'Hilo Torzal 100% algodón', 'Felpa elaborada con hilo torzal 100% algodón.'),
  ('4a540f49-7c1e-4a01-9957-0d1f637811be', 'Manta', 'Tela de manta; composición no especificada en el catálogo.')
ON DUPLICATE KEY UPDATE
  name = VALUES(name),
  description = VALUES(description);

-- 2) Medidas, tamaños o formatos expresamente publicados
INSERT INTO measurements (id, label, type) VALUES
  ('5191a1c9-bcf9-4a19-a293-9c11e2647101', 'Individual', 'size'),
  ('d683f87d-3bfa-4539-9c61-c548b7f90dc1', 'Matrimonial', 'size'),
  ('0a8e3016-cf46-4293-9e9b-d8efd06b4863', 'Queen Size', 'size'),
  ('4d3af9c1-2e6f-4413-a163-0bca78420251', 'King Size', 'size'),
  ('2dcf03a5-49cd-41db-90e3-cee33e0ad20d', '160 x 270 cm', 'dimension'),
  ('3f932f0c-9baf-4e97-986f-515bb8dd7f89', '180 x 280 cm', 'dimension'),
  ('85267c68-c679-4e9d-9044-8f9a7365c7b1', '220 x 280 cm', 'dimension'),
  ('e53004b2-79f6-44bf-af4e-61c785993bf1', '240 x 280 cm', 'dimension'),
  ('ab7fe257-62ca-458f-8346-d5e2a5a65e31', '280 x 280 cm', 'dimension'),
  ('6f79f64a-d6cd-4f8e-bb5c-6a7dd9e44682', '50 x 80 cm', 'dimension'),
  ('5e9f9fb9-3a13-492d-949e-fda392bbf8f7', '50 x 100 cm', 'dimension'),
  ('3d812e60-e8a0-4b61-aab8-3267593812d2', '50 x 70 cm', 'dimension'),
  ('6ff207e0-3f9c-42e3-be76-83919def0b12', '50 x 90 cm', 'dimension'),
  ('1156f30c-5794-4fdf-9187-ee1a931461e6', '140 x 210 cm', 'dimension'),
  ('d46da32e-4e3f-41cf-a9b3-231e1c9a66f6', '300 x 210 cm', 'dimension'),
  ('d2800bdc-85e9-40f9-b3f3-fdadbab389c0', '180 x 180 cm', 'dimension'),
  ('34b74758-8998-42e5-a2ad-4d7c03d0604f', '40 x 40 cm', 'dimension'),
  ('53aeb794-4335-4579-b5a2-48f97cc220ed', '50 x 50 cm', 'dimension'),
  ('df3d6623-6a82-420f-895b-94bd4713a5d9', '40 x 70 cm / 200 g', 'dimension_weight'),
  ('6da0028f-6b3d-4c1b-ba87-c24b552f2132', '50 x 80 cm / 300 g', 'dimension_weight'),
  ('c6650316-de67-4007-9e3b-de96bbc9840f', '30 x 30 cm / 50 g', 'dimension_weight'),
  ('02fa854f-8067-44a3-a031-d7a9fe365fea', '90 x 150 cm / 770 g', 'dimension_weight'),
  ('0c8c9cc6-4cc8-4a6b-8d6f-6520316d4e55', '90 x 190 cm / 1000 g', 'dimension_weight'),
  ('9691a183-57df-4083-8f5d-18202b1fe32d', 'A la medida', 'custom'),
  ('a9508b90-f523-41d1-aae3-1acc2b72b92d', 'Sábana de cajón', 'format'),
  ('2784abd1-0ce1-4e55-ab0e-65dfbd483ac0', 'Cortina', 'format'),
  ('d3d75447-86ee-41ef-a31a-c39037359b78', 'Forro de colchón', 'format'),
  ('6df2180c-c805-4ea2-b747-3de6623f3aeb', '20 x 22', 'dimension'),
  ('079d98c6-8f2a-4279-aec8-96a8cd2bf16f', '26 x 33', 'dimension'),
  ('7aabd528-0274-4a0b-b744-23b981768cd4', '31 x 36', 'dimension'),
  ('e5c74321-79d3-4fdb-88d0-da4d4bea407a', '35 x 42', 'dimension'),
  ('7861dfbf-3450-4190-a5c7-947aaf3af818', '38 x 45', 'dimension')
ON DUPLICATE KEY UPDATE
  label = VALUES(label),
  type = VALUES(type);

-- 3) Productos del catálogo
INSERT INTO products
  (id, slug, title, description, main_image, gallery, category, is_active, is_featured, mercadolibre_url, amazon_url)
VALUES
  ('fa9cf47a-b9ed-43cb-aed2-9f1759d0d0a7', 'protector-de-colchon-capitonado-de-cajon', 'Protector de colchón capitonado de cajón', 'Una opción que brinda comodidad y protege el colchón en su superficie y laterales.', '/images/logo.png', CAST('[]' AS JSON), 'Blancos', 1, 1, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('338cb3e4-3575-4da6-b4ad-31f559843183', 'protector-de-colchon-capitonado-con-resorte', 'Protector de colchón capitonado con resorte', 'Su acolchado ligero protege el colchón y brinda mayor comodidad; los resortes ayudan a evitar que se mueva y su tela es fresca.', '/images/productos/protector_de_colchon_capitonado_con_resorte.jpeg', CAST('[]' AS JSON), 'Blancos', 1, 1, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('c58a89a8-8149-4855-b5e8-08c01e745fe1', 'protector-de-colchon-impermeable-funda-completa', 'Protector de colchón impermeable funda completa', 'Protector impermeable tipo duvet con cierre que cubre totalmente el colchón; su tela transpirable no genera calor.', '/images/logo.png', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('e0f115e7-1a79-4b86-beb9-107f85beaec2', 'sabanas', 'Sábanas', 'Sábanas diseñadas para brindar frescura, durabilidad y suavidad; también disponibles como sábanas de cajón.', '/images/logo.png', CAST('[]' AS JSON), 'Blancos', 1, 1, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('64f53151-bb61-43f0-9235-598a956d091c', 'fundas-y-protector-de-almohadas', 'Fundas y protector de almohadas', 'Fundas y protectores para almohada elaborados en tela percal, con opciones estándar y king size.', '/images/logo.png', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('0985f462-ceb0-4b15-b8bc-3de70383b8e0', 'almohadas', 'Almohadas', 'Almohadas con forro y relleno sintético, suaves, durables y diseñadas para no generar calor.', '/images/logo.png', CAST('[]' AS JSON), 'Blancos', 1, 1, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('3c229b21-f5f0-4617-98be-4a46c313c69b', 'duvet-e-insertos', 'Duvet e insertos', 'Funda duvet tipo sobre para sujetar fácilmente el inserto; el inserto puede elegirse desde ligero hasta muy esponjoso.', '/images/logo.png', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('8db922a0-74b1-478d-9874-0f01017287e2', 'duvet-y-sobrecamas', 'Duvet y sobrecamas', 'Opciones ligeras y decorativas, lisas o estampadas, en tela waffle o con texturas variadas.', '/images/logo.png', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('95cd79d7-718e-46f3-bb0d-da45c8908fac', 'edredones', 'Edredones', 'Edredones con relleno confortable y acabado suave que brindan calidez equilibrada y una presentación elegante.', '/images/logo.png', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('8984e83b-fefa-4f50-a2cd-152a6960ed75', 'cobertores', 'Cobertores', 'Cobertores de tela polar con textura ligera y cálida, ideales para complementar la cama.', '/images/logo.png', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('00ce97ba-2b71-437a-9438-ee9aa2211c85', 'batas-spa', 'Batas', 'Batas de spa en tela waffle tipo kimono, ligeras y altamente absorbentes, ideales para relajación.', '/images/logo.png', CAST('[]' AS JSON), 'Spa', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('c2f0e71a-2f40-448c-b074-346817767179', 'cojin-cilindro-y-fundas-cilindros', 'Cojín cilindro y fundas cilindros', 'Cojín cilíndrico con funda tipo spa, diseñado para brindar soporte cómodo y relajación.', '/images/logo.png', CAST('[]' AS JSON), 'Spa', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('e7a1bd59-b8cd-450b-94d8-d576495b3083', 'cojin-careta-y-funda-caretas', 'Cojín careta y funda caretas', 'Cojín careta con funda tipo spa que brinda soporte ergonómico y confort durante tratamientos.', '/images/logo.png', CAST('[]' AS JSON), 'Spa', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('4cf7c0ef-5353-4ed3-9de5-c009df214d48', 'batas-paciente', 'Batas paciente', 'Batas médicas para paciente, ligeras y confortables, diseñadas para facilitar la movilidad y brindar discreción.', '/images/logo.png', CAST('[]' AS JSON), 'Hospital', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('c8081967-3590-440c-aaad-af70f528e243', 'campos-medicos', 'Campos médicos', 'Campos médicos con tejidos resistentes y de fácil manejo que brindan protección y control durante procedimientos.', '/images/logo.png', CAST('[]' AS JSON), 'Hospital', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('47c1f3e9-b44b-410a-9baa-3203352ea675', 'cortinas-blackout', 'Cortinas blackout', 'Cortinas que bloquean la luz al 100%, ofrecen mayor privacidad y crean un ambiente acogedor.', '/images/productos/cortina_blackout.jpeg', CAST('[]' AS JSON), 'Decorativos', 1, 1, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('b3063196-0434-43ad-ba37-ba36fcd1a1c6', 'cortinas-traslucidas', 'Cortinas traslúcidas', 'Cortinas que dejan pasar la luz natural, aportando un toque de elegancia.', '/images/logo.png', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('3660ec90-fb2c-4930-ba35-3736fc224b3f', 'cortinas-semi-traslucidas', 'Cortinas semi-traslúcidas', 'Cortinas disponibles en gran variedad de colores, diseños y texturas.', '/images/logo.png', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('7152be27-0949-4695-9e4c-829def517ff4', 'cortinas-de-bano', 'Cortinas de baño', 'Cortinas resistentes y funcionales que protegen contra salpicaduras y ayudan a mantener espacios secos.', '/images/logo.png', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('53d988cd-5e31-40de-9dc7-d01038bb03b7', 'balinesas', 'Balinesas', 'Textiles para balinesas que aportan durabilidad, frescura y una presentación atractiva en exteriores.', '/images/logo.png', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('b91b88ff-fa57-400e-85bc-c975ac897214', 'rodapie', 'Rodapié', 'Rodapié textil resistente y funcional que protege la base de la cama y mejora la presentación de la habitación.', '/images/logo.png', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('b2094959-a301-4d85-abcc-f79f82b25422', 'pie-de-cama', 'Pie de cama', 'Pie de cama con textura suave y diseño decorativo que aporta calidez y estilo.', '/images/logo.png', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('79cdc012-c745-4602-b4db-4ab2c1483cf6', 'cojines', 'Cojines', 'Cojines decorativos con diseños versátiles y textura confortable que aportan estilo y personalidad.', '/images/logo.png', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('fe40fce2-e6d2-40a0-8221-80ee75e41e75', 'pabellon', 'Pabellón', 'Pabellón de cama ligero y envolvente que aporta protección y estilo a la experiencia de descanso.', '/images/logo.png', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('3c7d8521-6422-4b9e-9dcc-ddebd4d73a0d', 'toalla-de-manos', 'Toalla de manos', 'Toalla de manos de suavidad premium y alta absorción para una sensación impecable de higiene.', '/images/logo.png', CAST('[]' AS JSON), 'Felpa', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('e635c23c-8bfa-4ef5-8684-404d1e37cf37', 'tapete-felpa', 'Tapete felpa', 'Tapete de felpa con textura suave y gran absorción, diseñado para mantener espacios secos y limpios.', '/images/logo.png', CAST('[]' AS JSON), 'Felpa', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('579e823e-2103-41e6-8f07-abe2f191a2d7', 'faciales-felpa', 'Faciales felpa', 'Toallas faciales de felpa con textura extra suave y alta absorción.', '/images/logo.png', CAST('[]' AS JSON), 'Felpa', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('d5c4031f-eb6d-4fea-abe0-b8a456cdcd48', 'toallas-de-bano', 'Toallas de baño', 'Toallas de baño suaves y absorbentes, diseñadas para mantener su desempeño después de múltiples ciclos de lavado.', '/images/logo.png', CAST('[]' AS JSON), 'Felpa', 1, 1, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('7ab9a28e-faf3-460f-87d7-62d868c408aa', 'toallas-de-alberca-felpa', 'Toallas de alberca felpa', 'Toallas de alberca de gran formato y alta absorción, ideales para exteriores.', '/images/logo.png', CAST('[]' AS JSON), 'Felpa', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('198da116-762f-402c-96bc-e2c304254f98', 'servilletas', 'Servilletas', 'Servilletas de tela resistentes y elegantes que complementan la mesa con una presentación impecable.', '/images/logo.png', CAST('[]' AS JSON), 'Mantelería', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('77241df3-a24b-4354-83d3-81f591335a9b', 'manteles', 'Manteles', 'Manteles en formatos cuadrados, rectangulares y redondos, diseñados para adaptarse a cualquier montaje.', '/images/logo.png', CAST('[]' AS JSON), 'Mantelería', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('ebfa7a6e-70e2-4b9d-af69-5eb698be2a87', 'bambalinas', 'Bambalinas', 'Bambalinas con acabado textil elegante que aportan un remate decorativo limpio y uniforme.', '/images/logo.png', CAST('[]' AS JSON), 'Mantelería', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('9c4cd58b-d19e-422a-bc41-40401c6f28ea', 'cubresillas', 'Cubre Sillas', 'Cubre sillas con ajuste preciso y acabado elegante que aportan uniformidad y protección al mobiliario.', '/images/logo.png', CAST('[]' AS JSON), 'Mantelería', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('214c63dc-138b-4a3f-a59d-4df90e1bf57d', 'tortilleros-porta-calientes', 'Tortilleros porta calientes', 'Tortilleros con aislamiento eficiente que conservan la temperatura por más tiempo.', '/images/logo.png', CAST('[]' AS JSON), 'Mantelería', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('c3823359-2df0-44c2-944b-d28718b884cd', 'bolsas-amenities', 'Bolsas amenities', 'Bolsas de amenities en manta, ideales para organizar y resguardar artículos en habitación.', '/images/logo.png', CAST('[]' AS JSON), 'Promocionales', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('35471985-0dba-4608-803d-0aadeb93e903', 'bolsas-de-manta', 'Bolsas de Manta', 'Bolsas de manta prácticas y versátiles para uso diario o promocional, disponibles en cinco medidas publicadas en el catálogo.', '/images/logo.png', CAST('[]' AS JSON), 'Promocionales', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('dcae0d44-3558-4b84-83f9-a27f669fb201', 'playeras-promocionales', 'Playeras promocionales', 'Playeras textiles personalizables para fortalecer la identidad de marca.', '/images/logo.png', CAST('[]' AS JSON), 'Promocionales', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/'),
  ('eb5ea67f-201d-46a2-8689-5bb8f1c07708', 'mandiles-promocionales', 'Mandiles promocionales', 'Mandiles textiles personalizables que combinan funcionalidad y presencia de marca.', '/images/logo.png', CAST('[]' AS JSON), 'Promocionales', 1, 0, 'https://www.mercadolibre.com.mx/', 'https://www.amazon.com.mx/')
ON DUPLICATE KEY UPDATE
  title = VALUES(title),
  description = VALUES(description),
  category = VALUES(category),
  is_active = VALUES(is_active),
  is_featured = VALUES(is_featured),
  mercadolibre_url = VALUES(mercadolibre_url),
  amazon_url = VALUES(amazon_url),
  main_image = VALUES(main_image),
  gallery = VALUES(gallery);

-- 4) Variantes de producto
-- Se eliminan únicamente las variantes de los productos publicados en este catálogo para no conservar opciones obsoletas.
DELETE pv
FROM product_variants pv
JOIN products p ON p.id = pv.product_id
WHERE p.slug IN (
  'protector-de-colchon-capitonado-de-cajon',
  'protector-de-colchon-capitonado-con-resorte',
  'protector-de-colchon-impermeable-funda-completa',
  'sabanas',
  'fundas-y-protector-de-almohadas',
  'almohadas',
  'duvet-e-insertos',
  'duvet-y-sobrecamas',
  'edredones',
  'cobertores',
  'batas-spa',
  'cojin-cilindro-y-fundas-cilindros',
  'cojin-careta-y-funda-caretas',
  'batas-paciente',
  'campos-medicos',
  'cortinas-blackout',
  'cortinas-traslucidas',
  'cortinas-semi-traslucidas',
  'cortinas-de-bano',
  'balinesas',
  'rodapie',
  'pie-de-cama',
  'cojines',
  'pabellon',
  'toalla-de-manos',
  'tapete-felpa',
  'faciales-felpa',
  'toallas-de-bano',
  'toallas-de-alberca-felpa',
  'servilletas',
  'manteles',
  'bambalinas',
  'cubresillas',
  'tortilleros-porta-calientes',
  'bolsas-amenities',
  'bolsas-de-manta',
  'playeras-promocionales',
  'mandiles-promocionales'
);

-- Se resuelven las relaciones por slug/name/label para que el seed funcione aunque ya existan entidades con IDs previos.
INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '65fad9be-1f67-4aba-a43d-d4693b1ab8d8', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'Individual'
JOIN fabric_types f ON f.name = 'Poliéster satinado a rayas con relleno Delcron'
WHERE p.slug = 'protector-de-colchon-capitonado-de-cajon'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '0e8b4234-b755-425e-bc97-88625f473288', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'Matrimonial'
JOIN fabric_types f ON f.name = 'Poliéster satinado a rayas con relleno Delcron'
WHERE p.slug = 'protector-de-colchon-capitonado-de-cajon'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'bcf570a7-72e8-4ee8-b542-6d6898b886d7', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'Queen Size'
JOIN fabric_types f ON f.name = 'Poliéster satinado a rayas con relleno Delcron'
WHERE p.slug = 'protector-de-colchon-capitonado-de-cajon'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '472c6262-b6b8-4cb8-9bf1-b7823bed18f5', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'King Size'
JOIN fabric_types f ON f.name = 'Poliéster satinado a rayas con relleno Delcron'
WHERE p.slug = 'protector-de-colchon-capitonado-de-cajon'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '7872ddba-3d4d-4521-bff7-513498751a45', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'Individual'
JOIN fabric_types f ON f.name = 'Poliéster satinado a rayas con relleno Delcron'
WHERE p.slug = 'protector-de-colchon-capitonado-con-resorte'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '8aec1d3d-0d3a-4694-b80a-9717158eddd4', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'Matrimonial'
JOIN fabric_types f ON f.name = 'Poliéster satinado a rayas con relleno Delcron'
WHERE p.slug = 'protector-de-colchon-capitonado-con-resorte'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '3e5d67e1-d7d3-450f-ac75-644c4676470a', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'Queen Size'
JOIN fabric_types f ON f.name = 'Poliéster satinado a rayas con relleno Delcron'
WHERE p.slug = 'protector-de-colchon-capitonado-con-resorte'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'ba1310fc-fbec-4348-ad8b-cbfb71bd0ce3', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'King Size'
JOIN fabric_types f ON f.name = 'Poliéster satinado a rayas con relleno Delcron'
WHERE p.slug = 'protector-de-colchon-capitonado-con-resorte'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'ba4544f6-8b15-458f-a070-68004e7ff99e', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'Individual'
JOIN fabric_types f ON f.name = '50% algodón / 50% poliéster con poliuretano 100%'
WHERE p.slug = 'protector-de-colchon-impermeable-funda-completa'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '32f03ff0-523e-4d83-8b53-0b3d91250bd5', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'Matrimonial'
JOIN fabric_types f ON f.name = '50% algodón / 50% poliéster con poliuretano 100%'
WHERE p.slug = 'protector-de-colchon-impermeable-funda-completa'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '32b565f3-9991-497c-9ede-9b28186dc11c', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'Queen Size'
JOIN fabric_types f ON f.name = '50% algodón / 50% poliéster con poliuretano 100%'
WHERE p.slug = 'protector-de-colchon-impermeable-funda-completa'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'c7adffd4-7a72-46e7-b410-f9d8eadc27bf', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'King Size'
JOIN fabric_types f ON f.name = '50% algodón / 50% poliéster con poliuretano 100%'
WHERE p.slug = 'protector-de-colchon-impermeable-funda-completa'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '46e7c33e-f910-450b-ab1c-dbb37c65855e', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '160 x 270 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '94d3a243-7fe1-4fe3-8a55-5e00267fe9c5', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '160 x 270 cm'
JOIN fabric_types f ON f.name = 'Percal 200 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '258b160a-67c4-49ed-b974-5b9004890896', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '160 x 270 cm'
JOIN fabric_types f ON f.name = 'Percal 300 hilos 100% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '1ff78691-4345-4cf6-8163-d0df7017219e', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '180 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '377d715a-b9a3-4dc1-94c0-3effcc304410', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '180 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 200 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '7c5352f0-e2bb-4996-9df2-369c15a01971', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '180 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 300 hilos 100% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '6f0fd979-ec29-4111-ad86-52b1e84a54bd', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '220 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '7accb25f-cf15-4004-b140-b9808888a368', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '220 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 200 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dfd2ce14-95b7-4e6a-ae53-beffea23d0fe', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '220 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 300 hilos 100% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'a4d2fd91-4f9d-49ba-a76c-fe14806696a9', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '240 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'd110f6b2-0b9f-46cc-82c0-deec5439751f', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '240 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 200 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'df668ba6-a202-43c0-a0fc-26f2cf8265c4', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '240 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 300 hilos 100% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '887c77e0-f74c-4ff6-a513-74179db1dd46', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '280 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '889a98a1-6e0c-46bd-b8f8-7df1d1521a1a', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '280 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 200 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '3d1f7378-2585-4d4f-b0ce-8cfaa6c7370a', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '280 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 300 hilos 100% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

-- El catálogo también publica sábanas de cajón, sin una medida específica.
INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '715ecbfe-1090-44d3-a813-4efec2487f37', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'Sábana de cajón'
JOIN fabric_types f ON f.name = 'Percal 180 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '0266889c-f989-463d-bb94-50a49b934d08', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'Sábana de cajón'
JOIN fabric_types f ON f.name = 'Percal 200 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'e07c084e-e540-449a-ae3a-1c4caf2ff4f7', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'Sábana de cajón'
JOIN fabric_types f ON f.name = 'Percal 300 hilos 100% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'c4ed25a2-99af-4b4a-b342-12a2aa4e4de0', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '50 x 80 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'fundas-y-protector-de-almohadas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'b49c63c0-10f9-4d47-b5bb-74fbf9c0567d', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '50 x 80 cm'
JOIN fabric_types f ON f.name = 'Percal 200 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'fundas-y-protector-de-almohadas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '855a6df9-0b9a-4f50-a961-2af3e3936ab1', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '50 x 80 cm'
JOIN fabric_types f ON f.name = 'Percal 300 hilos 100% algodón'
WHERE p.slug = 'fundas-y-protector-de-almohadas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'fdb56a29-cec9-4612-a2f7-244e52d4c469', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '50 x 100 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'fundas-y-protector-de-almohadas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '35320f26-1883-4ee3-9e89-7e2191b78ed0', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '50 x 100 cm'
JOIN fabric_types f ON f.name = 'Percal 200 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'fundas-y-protector-de-almohadas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '121279d3-e28f-437c-b1e9-03e63bd51b2f', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '50 x 100 cm'
JOIN fabric_types f ON f.name = 'Percal 300 hilos 100% algodón'
WHERE p.slug = 'fundas-y-protector-de-almohadas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'cdd80a7c-a7de-4306-ac3d-4000a8834df5', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '50 x 70 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos con relleno fibra 100% poliéster'
WHERE p.slug = 'almohadas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '82ac7537-7a5a-4dba-bedf-04d99dd4db0b', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '50 x 70 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos con relleno microgel'
WHERE p.slug = 'almohadas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '1b0858b6-9fad-4e0c-8f09-6559d56f257b', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '50 x 90 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos con relleno fibra 100% poliéster'
WHERE p.slug = 'almohadas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '1fe51ea2-87f8-479e-9cde-9841be95416a', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '50 x 90 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos con relleno microgel'
WHERE p.slug = 'almohadas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '001af87a-2ae6-4854-9815-dd5024c9f11d', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '180 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '8cfe391b-c63b-4022-ba8e-880d19312ef0', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '180 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 200 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '3d292675-2d6d-44c8-aa78-542ecb8a5d7c', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '180 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 300 hilos 100% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '15f928fa-d570-4c97-ac37-b33fae996159', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '180 x 280 cm'
JOIN fabric_types f ON f.name = 'Satin líneas 250 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'f6989a83-4f4e-4519-9585-1dc0443a816f', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '220 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '446d605d-731b-4af2-bb0b-b9287c5e0b92', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '220 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 200 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'c56de99a-8afc-4ff0-bb9a-8c47cfe3669b', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '220 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 300 hilos 100% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '3acccb21-c05b-457c-9ca1-6edeb56bc2c8', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '220 x 280 cm'
JOIN fabric_types f ON f.name = 'Satin líneas 250 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'd69b2a0a-3e02-4e48-a220-d9171aca95f3', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '240 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'e154d38b-f352-41b6-accc-18a7c71ba4cd', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '240 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 200 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'b5781efc-be82-477e-8bba-88bd631742af', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '240 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 300 hilos 100% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'f573869e-6119-4f5e-bd0c-6ba885c82679', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '240 x 280 cm'
JOIN fabric_types f ON f.name = 'Satin líneas 250 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'd7b4e089-8fba-4718-be9a-0ed6520049b4', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '280 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 180 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'a6adea79-2856-4746-a484-fba3cb42fc39', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '280 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 200 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'f041bcc4-e55c-4cb3-96b3-f7944ead9435', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '280 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 300 hilos 100% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'c204110b-310e-46ac-abd9-03aaba601255', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '280 x 280 cm'
JOIN fabric_types f ON f.name = 'Satin líneas 250 hilos 50% poliéster / 50% algodón'
WHERE p.slug = 'duvet-e-insertos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '4a1260fc-3a2d-442a-b043-aaea052ccd64', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '180 x 280 cm'
JOIN fabric_types f ON f.name = 'Tela waffle'
WHERE p.slug = 'duvet-y-sobrecamas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'b3d80ce3-9ea8-474f-86bb-423f46a94b9a', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '220 x 280 cm'
JOIN fabric_types f ON f.name = 'Tela waffle'
WHERE p.slug = 'duvet-y-sobrecamas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '9e60765c-7d99-47b8-99b7-16ebda9ad9a7', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '240 x 280 cm'
JOIN fabric_types f ON f.name = 'Tela waffle'
WHERE p.slug = 'duvet-y-sobrecamas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '045441c9-d7cb-4208-87b7-508aacae1209', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '280 x 280 cm'
JOIN fabric_types f ON f.name = 'Tela waffle'
WHERE p.slug = 'duvet-y-sobrecamas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '35812842-db95-402b-b2b2-01b52c6ddf54', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'edredones'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'db5815ef-975e-455a-9f52-1af34846d7d0', p.id, NULL, f.id, NULL, NULL, 0, 1
FROM products p
JOIN fabric_types f ON f.name = 'Polar Flanel 100% poliéster'
WHERE p.slug = 'cobertores'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'c4126d07-cc87-459e-9788-7aed103ab820', p.id, NULL, f.id, NULL, NULL, 0, 1
FROM products p
JOIN fabric_types f ON f.name = 'Waffle 50% algodón / 50% poliéster'
WHERE p.slug = 'batas-spa'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'e1c8fb7c-c9db-4ab1-9e2d-8dc6db7931d6', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'cojin-cilindro-y-fundas-cilindros'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'bd611b5c-2000-47ae-9b83-c099ae108534', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'cojin-careta-y-funda-caretas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '564eeb95-d5be-4b6e-9de0-90d50671b09c', p.id, NULL, f.id, NULL, NULL, 0, 1
FROM products p
JOIN fabric_types f ON f.name = 'Bramante 50% algodón / 50% poliéster'
WHERE p.slug = 'batas-paciente'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '7f9292d6-8318-4df4-b70b-9c6face51991', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'campos-medicos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '2d6b408b-33c8-411a-b525-84a0ceddb47c', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '140 x 210 cm'
WHERE p.slug = 'cortinas-blackout'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '544d966f-8591-4d14-be00-f663bb17757f', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'A la medida'
WHERE p.slug = 'cortinas-blackout'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'd78c49da-0fb0-4478-bdfd-d40807d95d40', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '300 x 210 cm'
WHERE p.slug = 'cortinas-traslucidas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '5f9a7cb2-fc9b-4db5-b290-6020e72dfd7c', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'A la medida'
WHERE p.slug = 'cortinas-traslucidas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '89f6338e-da9a-4b1a-9da7-c785e97d4031', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '140 x 210 cm'
WHERE p.slug = 'cortinas-semi-traslucidas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '5dc18935-fa0a-4058-879d-4929c5c4c8cd', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'A la medida'
WHERE p.slug = 'cortinas-semi-traslucidas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'c9f5d5cb-eb49-464d-8901-872cd20026c8', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '180 x 180 cm'
WHERE p.slug = 'cortinas-de-bano'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'f7a4ad0e-a4fe-46db-9fef-8544db70dd53', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'Cortina'
WHERE p.slug = 'balinesas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '96ce7e5e-2f11-47d3-bb19-05b912a09041', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'Forro de colchón'
WHERE p.slug = 'balinesas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'c2d8f03d-14f9-4de2-8355-cb1f9d08e015', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'rodapie'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'a159fd89-4596-4967-9bc3-95679fded0cf', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'pie-de-cama'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '2bcc0c7b-ec6b-41d0-a548-00c326a61a89', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '40 x 40 cm'
WHERE p.slug = 'cojines'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'bd3470f1-da57-405f-bf6c-cf5e15d13a7c', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '50 x 50 cm'
WHERE p.slug = 'cojines'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '4dbc3b50-dbe8-4b87-b6ed-fc9a1d8e6b7e', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'pabellon'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'c6f9d5a4-c735-4d19-b2ae-9ce578202272', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '40 x 70 cm / 200 g'
JOIN fabric_types f ON f.name = 'Hilo Torzal 100% algodón'
WHERE p.slug = 'toalla-de-manos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '70331daa-b6fd-49a1-bbba-540b519200be', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '50 x 80 cm / 300 g'
JOIN fabric_types f ON f.name = 'Hilo Torzal 100% algodón'
WHERE p.slug = 'tapete-felpa'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'b4cb7000-7c1f-4125-8bf8-87031383a0cb', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '30 x 30 cm / 50 g'
JOIN fabric_types f ON f.name = 'Hilo Torzal 100% algodón'
WHERE p.slug = 'faciales-felpa'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'ca51dc8f-a367-44cf-a389-90be4a1c0ac4', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '90 x 150 cm / 770 g'
JOIN fabric_types f ON f.name = 'Hilo Torzal 100% algodón'
WHERE p.slug = 'toallas-de-bano'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'd990bd46-0be3-4923-91f0-bf27267e4f6a', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '90 x 190 cm / 1000 g'
JOIN fabric_types f ON f.name = 'Hilo Torzal 100% algodón'
WHERE p.slug = 'toallas-de-alberca-felpa'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '96304041-5bba-436e-a24c-eebac408e1a8', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'servilletas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '395cfc29-7950-47e3-8994-4993b685a0e3', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'manteles'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '000e320d-ffa4-48f2-b5f3-aaf1ed7d18f8', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'bambalinas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '20639009-e04f-48a2-8f1d-2cf4a1307192', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'cubresillas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '34494352-bb23-446f-9645-792581ac9c40', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'tortilleros-porta-calientes'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '056593cb-260e-4552-aba4-1e981f263dad', p.id, NULL, f.id, NULL, NULL, 0, 1
FROM products p
JOIN fabric_types f ON f.name = 'Manta'
WHERE p.slug = 'bolsas-amenities'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'a2ed63fd-277b-47f8-9a58-bbcd0e149353', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '20 x 22'
JOIN fabric_types f ON f.name = 'Manta'
WHERE p.slug = 'bolsas-de-manta'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '30116dfc-02ec-42c5-96ea-34091ff318d5', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '26 x 33'
JOIN fabric_types f ON f.name = 'Manta'
WHERE p.slug = 'bolsas-de-manta'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '72b0fea9-768f-48c5-a30c-7ecc1c485a86', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '31 x 36'
JOIN fabric_types f ON f.name = 'Manta'
WHERE p.slug = 'bolsas-de-manta'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '2c4ed575-77cc-4a53-8571-94dd43d54c9d', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '35 x 42'
JOIN fabric_types f ON f.name = 'Manta'
WHERE p.slug = 'bolsas-de-manta'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '65391881-1d50-4d62-92aa-a65c3b95bc04', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '38 x 45'
JOIN fabric_types f ON f.name = 'Manta'
WHERE p.slug = 'bolsas-de-manta'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT '9f937bc9-ed14-436b-9e8b-fc95b78f96da', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'playeras-promocionales'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dff3f725-8832-4f64-9197-3d75127e221b', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'mandiles-promocionales'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

COMMIT;

-- Procedimiento consumido por src/features/products/data/mysqlProducts.ts
DELIMITER $$

CREATE PROCEDURE sp_search_products(IN search_term VARCHAR(255))
BEGIN
  IF search_term IS NULL OR TRIM(search_term) = '' THEN
    SELECT
      p.*,
      (
        SELECT JSON_ARRAYAGG(
          JSON_OBJECT(
            'id', pv.id,
            'sku', pv.sku,
            'price', pv.price,
            'stock', pv.stock,
            'is_active', pv.is_active,
            'fabric_types', (
              SELECT JSON_OBJECT(
                'id', ft.id,
                'name', ft.name,
                'description', ft.description
              )
              FROM fabric_types ft
              WHERE ft.id = pv.fabric_type_id
            ),
            'measurements', (
              SELECT JSON_OBJECT(
                'id', m.id,
                'label', m.label,
                'type', m.type
              )
              FROM measurements m
              WHERE m.id = pv.measurement_id
            )
          )
        )
        FROM product_variants pv
        WHERE pv.product_id = p.id
          AND pv.is_active = TRUE
      ) AS product_variants
    FROM products p
    WHERE p.is_active = TRUE
    ORDER BY p.created_at ASC;
  ELSE
    SELECT
      p.*,
      (
        SELECT JSON_ARRAYAGG(
          JSON_OBJECT(
            'id', pv.id,
            'sku', pv.sku,
            'price', pv.price,
            'stock', pv.stock,
            'is_active', pv.is_active,
            'fabric_types', (
              SELECT JSON_OBJECT(
                'id', ft.id,
                'name', ft.name,
                'description', ft.description
              )
              FROM fabric_types ft
              WHERE ft.id = pv.fabric_type_id
            ),
            'measurements', (
              SELECT JSON_OBJECT(
                'id', m.id,
                'label', m.label,
                'type', m.type
              )
              FROM measurements m
              WHERE m.id = pv.measurement_id
            )
          )
        )
        FROM product_variants pv
        WHERE pv.product_id = p.id
          AND pv.is_active = TRUE
      ) AS product_variants
    FROM products p
    WHERE p.is_active = TRUE
      AND (
        p.title LIKE CONCAT('%', TRIM(search_term), '%')
        OR p.description LIKE CONCAT('%', TRIM(search_term), '%')
        OR p.category LIKE CONCAT('%', TRIM(search_term), '%')
      )
    ORDER BY p.created_at ASC;
  END IF;
END$$

DELIMITER ;

-- Resumen esperado del seed: 38 productos, 14 tipos de tela, 32 medidas/formatos y 99 variantes.
