import pool from '@/lib/mysqlClient';
import { Product } from '../domain/product';

function mapRowToProduct(row: any): Product {
  let gallery: string[] = [];
  if (row.gallery) {
    if (typeof row.gallery === 'string') {
      try {
        gallery = JSON.parse(row.gallery);
      } catch (e) {
        console.error('Error parsing gallery JSON string:', e);
        gallery = [];
      }
    } else if (Array.isArray(row.gallery)) {
      gallery = row.gallery;
    }
  }

  let productVariants: any[] = [];
  if (row.product_variants) {
    if (typeof row.product_variants === 'string') {
      try {
        productVariants = JSON.parse(row.product_variants);
      } catch (e) {
        console.error('Error parsing product_variants JSON string:', e);
        productVariants = [];
      }
    } else if (Array.isArray(row.product_variants)) {
      productVariants = row.product_variants;
    }
  }

  // Clean up product variants: filter out null entries caused by JSON_ARRAYAGG empty results
  if (Array.isArray(productVariants)) {
    productVariants = productVariants.filter(
      (v: any) => v !== null && typeof v === 'object' && v.id !== null
    ).map((v: any) => {
      // Ensure price is converted to a number if it is a string decimal
      const price = v.price !== null && v.price !== undefined ? parseFloat(v.price) : null;
      return {
        ...v,
        price,
        is_active: !!v.is_active,
        // Map nested fabric_types and measurements from JSON object if present
        fabric_types: v.fabric_types && v.fabric_types.id ? v.fabric_types : null,
        measurements: v.measurements && v.measurements.id ? v.measurements : null,
      };
    });
  }

  return {
    id: row.id,
    title: row.title,
    description: row.description || '',
    main_image: row.main_image,
    gallery,
    slug: row.slug,
    category: row.category || undefined,
    is_active: !!row.is_active,
    is_featured: !!row.is_featured,
    mercadolibre_url: row.mercadolibre_url || undefined,
    amazon_url: row.amazon_url || undefined,
    created_at: row.created_at,
    product_variants: productVariants,
  };
}

export async function fetchProductsFromMySQL(search = ''): Promise<Product[]> {
  try {
    const [resultSets]: any = await pool.execute('CALL sp_search_products(?)', [search.trim()]);
    const rows = resultSets[0] || [];
    return rows.map(mapRowToProduct);
  } catch (error: any) {
    console.error('[fetchProductsFromMySQL] MySQL error:', error.message);
    return [];
  }
}

export async function fetchFeaturedProductsFromMySQL(): Promise<Product[]> {
  try {
    const query = `
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
      WHERE p.is_active = TRUE AND p.is_featured = TRUE
      ORDER BY p.created_at ASC
      LIMIT 6;
    `;
    const [rows]: any = await pool.execute(query);
    return (rows as any[]).map(mapRowToProduct);
  } catch (error: any) {
    console.error('[fetchFeaturedProductsFromMySQL] MySQL error:', error.message);
    return [];
  }
}

export async function fetchProductBySlugFromMySQL(slug: string): Promise<Product | null> {
  try {
    const query = `
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
      WHERE p.slug = ? AND p.is_active = TRUE
      LIMIT 1;
    `;
    const [rows]: any = await pool.execute(query, [slug]);
    if (rows && rows.length > 0) {
      return mapRowToProduct(rows[0]);
    }
    return null;
  } catch (error: any) {
    console.error('[fetchProductBySlugFromMySQL] MySQL error:', error.message);
    return null;
  }
}

export async function fetchAllProductSlugsFromMySQL(): Promise<string[]> {
  try {
    const query = 'SELECT slug FROM products WHERE is_active = TRUE;';
    const [rows]: any = await pool.execute(query);
    return (rows as any[]).map((row) => row.slug);
  } catch (error: any) {
    console.error('[fetchAllProductSlugsFromMySQL] MySQL error:', error.message);
    return [];
  }
}
