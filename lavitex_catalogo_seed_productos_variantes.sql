-- Seed de catálogo Lavitex del Caribe 2026
-- Fuente: Catalogo LAVITEX 2026-6.pdf, productos de páginas 4 a 40.
-- El programa de recuperación y reparación de blancos (página 41) es un servicio y no se inserta como producto.
-- Precio queda NULL y stock queda en 0 porque el catálogo no publica precios ni inventario.
-- SKU queda NULL porque el catálogo no proporciona códigos SKU.
-- main_image utiliza una ruta local convencional; sustituye o publica esos archivos en tu aplicación.
-- Las variantes base con measurement_id/fabric_type_id NULL representan productos para los que el PDF no especifica opciones.

START TRANSACTION;

-- 1) Tipos de tela y composiciones especificadas en el catálogo
INSERT INTO fabric_types (id, name, description) VALUES
  ('aaaaaaaa-0001-0001-0001-000000000001', 'Poliéster satinado a rayas con relleno Delcron', 'Tela 100% poliéster satinado a rayas y relleno Delcron.'),
  ('aaaaaaaa-0001-0001-0001-000000000002', '50% algodón / 50% poliéster con poliuretano 100%', 'Tela transpirable 50% algodón y 50% poliéster, con relleno de poliuretano 100%.'),
  ('aaaaaaaa-0001-0001-0001-000000000003', 'Percal 180 hilos 50% poliéster / 50% algodón', 'Tela percal de 180 hilos con composición 50% poliéster y 50% algodón.'),
  ('aaaaaaaa-0001-0001-0001-000000000004', 'Percal 200 hilos 50% poliéster / 50% algodón', 'Tela percal de 200 hilos con composición 50% poliéster y 50% algodón.'),
  ('aaaaaaaa-0001-0001-0001-000000000005', 'Percal 300 hilos 100% algodón', 'Tela percal de 300 hilos elaborada en 100% algodón.'),
  ('aaaaaaaa-0001-0001-0001-000000000006', 'Percal 180 hilos con relleno fibra 100% poliéster', 'Forro de percal 180 hilos, 50% poliéster y 50% algodón, con relleno de fibra 100% poliéster.'),
  ('aaaaaaaa-0001-0001-0001-000000000007', 'Percal 180 hilos con relleno microgel', 'Forro de percal 180 hilos, 50% poliéster y 50% algodón, con relleno microgel.'),
  ('aaaaaaaa-0001-0001-0001-000000000008', 'Satin líneas 250 hilos 50% poliéster / 50% algodón', 'Tela satin de líneas, 250 hilos, con composición 50% poliéster y 50% algodón.'),
  ('aaaaaaaa-0001-0001-0001-000000000009', 'Tela waffle', 'Tela waffle con textura; composición no especificada para este producto en el catálogo.'),
  ('aaaaaaaa-0001-0001-0001-000000000010', 'Polar Flanel 100% poliéster', 'Tela Polar Flanel elaborada en 100% poliéster.'),
  ('aaaaaaaa-0001-0001-0001-000000000011', 'Waffle 50% algodón / 50% poliéster', 'Tela waffle con composición 50% algodón y 50% poliéster.'),
  ('aaaaaaaa-0001-0001-0001-000000000012', 'Bramante 50% algodón / 50% poliéster', 'Tela Bramante con composición 50% algodón y 50% poliéster.'),
  ('aaaaaaaa-0001-0001-0001-000000000013', 'Hilo Torzal 100% algodón', 'Felpa elaborada con hilo torzal 100% algodón.'),
  ('aaaaaaaa-0001-0001-0001-000000000014', 'Manta', 'Tela de manta; composición no especificada en el catálogo.')
ON DUPLICATE KEY UPDATE description = VALUES(description);

-- 2) Medidas, tamaños o formatos expresamente publicados
INSERT INTO measurements (id, label, type) VALUES
  ('bbbbbbbb-0001-0001-0001-000000000001', 'Individual', 'size'),
  ('bbbbbbbb-0001-0001-0001-000000000002', 'Matrimonial', 'size'),
  ('bbbbbbbb-0001-0001-0001-000000000003', 'Queen Size', 'size'),
  ('bbbbbbbb-0001-0001-0001-000000000004', 'King Size', 'size'),
  ('bbbbbbbb-0001-0001-0001-000000000005', '160 x 270 cm', 'dimension'),
  ('bbbbbbbb-0001-0001-0001-000000000006', '180 x 280 cm', 'dimension'),
  ('bbbbbbbb-0001-0001-0001-000000000007', '220 x 280 cm', 'dimension'),
  ('bbbbbbbb-0001-0001-0001-000000000008', '240 x 280 cm', 'dimension'),
  ('bbbbbbbb-0001-0001-0001-000000000009', '280 x 280 cm', 'dimension'),
  ('bbbbbbbb-0001-0001-0001-000000000010', '50 x 80 cm', 'dimension'),
  ('bbbbbbbb-0001-0001-0001-000000000011', '50 x 100 cm', 'dimension'),
  ('bbbbbbbb-0001-0001-0001-000000000012', '50 x 70 cm', 'dimension'),
  ('bbbbbbbb-0001-0001-0001-000000000013', '50 x 90 cm', 'dimension'),
  ('bbbbbbbb-0001-0001-0001-000000000014', '140 x 210 cm', 'dimension'),
  ('bbbbbbbb-0001-0001-0001-000000000015', '300 x 210 cm', 'dimension'),
  ('bbbbbbbb-0001-0001-0001-000000000016', '180 x 180 cm', 'dimension'),
  ('bbbbbbbb-0001-0001-0001-000000000017', '40 x 40 cm', 'dimension'),
  ('bbbbbbbb-0001-0001-0001-000000000018', '50 x 50 cm', 'dimension'),
  ('bbbbbbbb-0001-0001-0001-000000000019', '40 x 70 cm / 200 g', 'dimension_weight'),
  ('bbbbbbbb-0001-0001-0001-000000000020', '50 x 80 cm / 300 g', 'dimension_weight'),
  ('bbbbbbbb-0001-0001-0001-000000000021', '30 x 30 cm / 50 g', 'dimension_weight'),
  ('bbbbbbbb-0001-0001-0001-000000000022', '90 x 150 cm / 770 g', 'dimension_weight'),
  ('bbbbbbbb-0001-0001-0001-000000000023', '90 x 190 cm / 1000 g', 'dimension_weight'),
  ('bbbbbbbb-0001-0001-0001-000000000024', 'A la medida', 'custom')
ON DUPLICATE KEY UPDATE type = VALUES(type);

-- 3) Productos del catálogo
INSERT INTO products
  (id, slug, title, description, main_image, gallery, category, is_active, is_featured, mercadolibre_url, amazon_url)
VALUES
  ('cccccccc-0001-0001-0001-000000000001', 'protector-de-colchon-capitonado-de-cajon', 'Protector de colchón capitonado de cajón', 'Una opción que brinda comodidad y protege el colchón en su superficie y laterales.', '/images/products/catalogo/protector-de-colchon-capitonado-de-cajon.webp', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000002', 'protector-de-colchon-capitonado-con-resorte', 'Protector de colchón capitonado con resorte', 'Su acolchado ligero protege el colchón y brinda mayor comodidad; los resortes ayudan a evitar que se mueva y su tela es fresca.', '/images/products/catalogo/protector-de-colchon-capitonado-con-resorte.webp', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000003', 'protector-de-colchon-impermeable-funda-completa', 'Protector de colchón impermeable funda completa', 'Protector impermeable tipo duvet con cierre que cubre totalmente el colchón; su tela transpirable no genera calor.', '/images/products/catalogo/protector-de-colchon-impermeable-funda-completa.webp', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000004', 'sabanas', 'Sábanas', 'Sábanas diseñadas para brindar frescura, durabilidad y suavidad; también disponibles como sábanas de cajón.', '/images/products/catalogo/sabanas.webp', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000005', 'fundas-y-protector-de-almohadas', 'Fundas y protector de almohadas', 'Fundas y protectores para almohada elaborados en tela percal, con opciones estándar y king size.', '/images/products/catalogo/fundas-y-protector-de-almohadas.webp', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000006', 'almohadas', 'Almohadas', 'Almohadas con forro y relleno sintético, suaves, durables y diseñadas para no generar calor.', '/images/products/catalogo/almohadas.webp', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000007', 'duvet-e-insertos', 'Duvet e insertos', 'Funda duvet tipo sobre para sujetar fácilmente el inserto; el inserto puede elegirse desde ligero hasta muy esponjoso.', '/images/products/catalogo/duvet-e-insertos.webp', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000008', 'duvet-y-sobrecamas', 'Duvet y sobrecamas', 'Opciones ligeras y decorativas, lisas o estampadas, en tela waffle o con texturas variadas.', '/images/products/catalogo/duvet-y-sobrecamas.webp', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000009', 'edredones', 'Edredones', 'Edredones con relleno confortable y acabado suave que brindan calidez equilibrada y una presentación elegante.', '/images/products/catalogo/edredones.webp', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000010', 'cobertores', 'Cobertores', 'Cobertores de tela polar con textura ligera y cálida, ideales para complementar la cama.', '/images/products/catalogo/cobertores.webp', CAST('[]' AS JSON), 'Blancos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000011', 'batas-spa', 'Batas', 'Batas de spa en tela waffle tipo kimono, ligeras y altamente absorbentes, ideales para relajación.', '/images/products/catalogo/batas-spa.webp', CAST('[]' AS JSON), 'Spa', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000012', 'cojin-cilindro-y-fundas-cilindros', 'Cojín cilindro y fundas cilindros', 'Cojín cilíndrico con funda tipo spa, diseñado para brindar soporte cómodo y relajación.', '/images/products/catalogo/cojin-cilindro-y-fundas-cilindros.webp', CAST('[]' AS JSON), 'Spa', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000013', 'cojin-careta-y-funda-caretas', 'Cojín careta y funda caretas', 'Cojín careta con funda tipo spa que brinda soporte ergonómico y confort durante tratamientos.', '/images/products/catalogo/cojin-careta-y-funda-caretas.webp', CAST('[]' AS JSON), 'Spa', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000014', 'batas-paciente', 'Batas paciente', 'Batas médicas para paciente, ligeras y confortables, diseñadas para facilitar la movilidad y brindar discreción.', '/images/products/catalogo/batas-paciente.webp', CAST('[]' AS JSON), 'Hospital', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000015', 'campos-medicos', 'Campos médicos', 'Campos médicos con tejidos resistentes y de fácil manejo que brindan protección y control durante procedimientos.', '/images/products/catalogo/campos-medicos.webp', CAST('[]' AS JSON), 'Hospital', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000016', 'cortinas-blackout', 'Cortinas blackout', 'Cortinas que bloquean la luz al 100%, ofrecen mayor privacidad y crean un ambiente acogedor.', '/images/products/catalogo/cortinas-blackout.webp', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000017', 'cortinas-traslucidas', 'Cortinas traslúcidas', 'Cortinas que dejan pasar la luz natural, aportando un toque de elegancia.', '/images/products/catalogo/cortinas-traslucidas.webp', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000018', 'cortinas-semi-traslucidas', 'Cortinas semi-traslúcidas', 'Cortinas disponibles en gran variedad de colores, diseños y texturas.', '/images/products/catalogo/cortinas-semi-traslucidas.webp', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000019', 'cortinas-de-bano', 'Cortinas de baño', 'Cortinas resistentes y funcionales que protegen contra salpicaduras y ayudan a mantener espacios secos.', '/images/products/catalogo/cortinas-de-bano.webp', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000020', 'balinesas', 'Balinesas', 'Textiles para balinesas que aportan durabilidad, frescura y una presentación atractiva en exteriores.', '/images/products/catalogo/balinesas.webp', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000021', 'rodapie', 'Rodapié', 'Rodapié textil resistente y funcional que protege la base de la cama y mejora la presentación de la habitación.', '/images/products/catalogo/rodapie.webp', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000022', 'pie-de-cama', 'Pie de cama', 'Pie de cama con textura suave y diseño decorativo que aporta calidez y estilo.', '/images/products/catalogo/pie-de-cama.webp', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000023', 'cojines', 'Cojines', 'Cojines decorativos con diseños versátiles y textura confortable que aportan estilo y personalidad.', '/images/products/catalogo/cojines.webp', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000024', 'pabellon', 'Pabellón', 'Pabellón de cama ligero y envolvente que aporta protección y estilo a la experiencia de descanso.', '/images/products/catalogo/pabellon.webp', CAST('[]' AS JSON), 'Decorativos', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000025', 'toalla-de-manos', 'Toalla de manos', 'Toalla de manos de suavidad premium y alta absorción para una sensación impecable de higiene.', '/images/products/catalogo/toalla-de-manos.webp', CAST('[]' AS JSON), 'Felpa', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000026', 'tapete-felpa', 'Tapete felpa', 'Tapete de felpa con textura suave y gran absorción, diseñado para mantener espacios secos y limpios.', '/images/products/catalogo/tapete-felpa.webp', CAST('[]' AS JSON), 'Felpa', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000027', 'faciales-felpa', 'Faciales felpa', 'Toallas faciales de felpa con textura extra suave y alta absorción.', '/images/products/catalogo/faciales-felpa.webp', CAST('[]' AS JSON), 'Felpa', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000028', 'toallas-de-bano', 'Toallas de baño', 'Toallas de baño suaves y absorbentes, diseñadas para mantener su desempeño después de múltiples ciclos de lavado.', '/images/products/catalogo/toallas-de-bano.webp', CAST('[]' AS JSON), 'Felpa', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000029', 'toallas-de-alberca-felpa', 'Toallas de alberca felpa', 'Toallas de alberca de gran formato y alta absorción, ideales para exteriores.', '/images/products/catalogo/toallas-de-alberca-felpa.webp', CAST('[]' AS JSON), 'Felpa', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000030', 'servilletas', 'Servilletas', 'Servilletas de tela resistentes y elegantes que complementan la mesa con una presentación impecable.', '/images/products/catalogo/servilletas.webp', CAST('[]' AS JSON), 'Mantelería', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000031', 'manteles', 'Manteles', 'Manteles en formatos cuadrados, rectangulares y redondos, diseñados para adaptarse a cualquier montaje.', '/images/products/catalogo/manteles.webp', CAST('[]' AS JSON), 'Mantelería', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000032', 'bambalinas', 'Bambalinas', 'Bambalinas con acabado textil elegante que aportan un remate decorativo limpio y uniforme.', '/images/products/catalogo/bambalinas.webp', CAST('[]' AS JSON), 'Mantelería', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000033', 'cubresillas', 'Cubresillas', 'Cubresillas con ajuste preciso y acabado elegante que aportan uniformidad y protección al mobiliario.', '/images/products/catalogo/cubresillas.webp', CAST('[]' AS JSON), 'Mantelería', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000034', 'tortilleros-porta-calientes', 'Tortilleros porta calientes', 'Tortilleros con aislamiento eficiente que conservan la temperatura por más tiempo.', '/images/products/catalogo/tortilleros-porta-calientes.webp', CAST('[]' AS JSON), 'Mantelería', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000035', 'bolsas-amenities', 'Bolsas amenities', 'Bolsas de amenities en manta, ideales para organizar y resguardar artículos en habitación.', '/images/products/catalogo/bolsas-amenities.webp', CAST('[]' AS JSON), 'Promocionales', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000036', 'bolsas-de-manta', 'Bolsas de manta', 'Bolsas de manta en diferentes tamaños, prácticas y versátiles para uso diario o promocional.', '/images/products/catalogo/bolsas-de-manta.webp', CAST('[]' AS JSON), 'Promocionales', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000037', 'playeras-promocionales', 'Playeras promocionales', 'Playeras textiles personalizables para fortalecer la identidad de marca.', '/images/products/catalogo/playeras-promocionales.webp', CAST('[]' AS JSON), 'Promocionales', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx'),
  ('cccccccc-0001-0001-0001-000000000038', 'mandiles-promocionales', 'Mandiles promocionales', 'Mandiles textiles personalizables que combinan funcionalidad y presencia de marca.', '/images/products/catalogo/mandiles-promocionales.webp', CAST('[]' AS JSON), 'Promocionales', 1, 0, 'https://www.mercadolibre.com.mx', 'https://www.amazon.com.mx')
ON DUPLICATE KEY UPDATE
  title = VALUES(title),
  description = VALUES(description),
  category = VALUES(category),
  is_active = VALUES(is_active),
  is_featured = VALUES(is_featured),
  mercadolibre_url = VALUES(mercadolibre_url),
  amazon_url = VALUES(amazon_url),
  main_image = IF(main_image = '', VALUES(main_image), main_image);

-- 4) Variantes de producto
-- Se resuelven las relaciones por slug/name/label para que el seed funcione aunque ya existan productos, telas o medidas con IDs previos.
INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000001', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000002', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000003', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000004', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000005', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000006', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000007', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000008', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000009', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000010', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000011', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000012', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000013', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000014', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000015', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000016', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000017', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000018', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000019', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000020', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000021', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000022', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000023', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000024', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000025', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000026', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000027', p.id, m.id, f.id, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '280 x 280 cm'
JOIN fabric_types f ON f.name = 'Percal 300 hilos 100% algodón'
WHERE p.slug = 'sabanas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000028', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000029', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000030', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000031', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000032', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000033', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000034', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000035', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000036', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000037', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000038', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000039', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000040', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000041', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000042', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000043', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000044', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000045', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000046', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000047', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000048', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000049', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000050', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000051', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000052', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000053', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000054', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000055', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000056', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000057', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000058', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'edredones'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000059', p.id, NULL, f.id, NULL, NULL, 0, 1
FROM products p
JOIN fabric_types f ON f.name = 'Polar Flanel 100% poliéster'
WHERE p.slug = 'cobertores'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000060', p.id, NULL, f.id, NULL, NULL, 0, 1
FROM products p
JOIN fabric_types f ON f.name = 'Waffle 50% algodón / 50% poliéster'
WHERE p.slug = 'batas-spa'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000061', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'cojin-cilindro-y-fundas-cilindros'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000062', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'cojin-careta-y-funda-caretas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000063', p.id, NULL, f.id, NULL, NULL, 0, 1
FROM products p
JOIN fabric_types f ON f.name = 'Bramante 50% algodón / 50% poliéster'
WHERE p.slug = 'batas-paciente'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000064', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'campos-medicos'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000065', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '140 x 210 cm'
WHERE p.slug = 'cortinas-blackout'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000066', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'A la medida'
WHERE p.slug = 'cortinas-blackout'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000067', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '300 x 210 cm'
WHERE p.slug = 'cortinas-traslucidas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000068', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'A la medida'
WHERE p.slug = 'cortinas-traslucidas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000069', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '140 x 210 cm'
WHERE p.slug = 'cortinas-semi-traslucidas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000070', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = 'A la medida'
WHERE p.slug = 'cortinas-semi-traslucidas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000071', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '180 x 180 cm'
WHERE p.slug = 'cortinas-de-bano'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000072', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'balinesas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000073', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'rodapie'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000074', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'pie-de-cama'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000075', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '40 x 40 cm'
WHERE p.slug = 'cojines'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000076', p.id, m.id, NULL, NULL, NULL, 0, 1
FROM products p
JOIN measurements m ON m.label = '50 x 50 cm'
WHERE p.slug = 'cojines'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000077', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'pabellon'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000078', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000079', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000080', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000081', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000082', p.id, m.id, f.id, NULL, NULL, 0, 1
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
SELECT 'dddddddd-0001-0001-0001-000000000083', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'servilletas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000084', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'manteles'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000085', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'bambalinas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000086', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'cubresillas'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000087', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'tortilleros-porta-calientes'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000088', p.id, NULL, f.id, NULL, NULL, 0, 1
FROM products p
JOIN fabric_types f ON f.name = 'Manta'
WHERE p.slug = 'bolsas-amenities'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000089', p.id, NULL, f.id, NULL, NULL, 0, 1
FROM products p
JOIN fabric_types f ON f.name = 'Manta'
WHERE p.slug = 'bolsas-de-manta'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000090', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'playeras-promocionales'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

INSERT INTO product_variants (id, product_id, measurement_id, fabric_type_id, price, sku, stock, is_active)
SELECT 'dddddddd-0001-0001-0001-000000000091', p.id, NULL, NULL, NULL, NULL, 0, 1
FROM products p
WHERE p.slug = 'mandiles-promocionales'
ON DUPLICATE KEY UPDATE
  product_id = VALUES(product_id),
  measurement_id = VALUES(measurement_id),
  fabric_type_id = VALUES(fabric_type_id),
  is_active = VALUES(is_active);

COMMIT;

-- Resumen esperado del seed: 38 productos, 14 tipos de tela, 24 medidas y 91 variantes.