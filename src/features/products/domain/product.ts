export interface FabricType {
  id: string;
  name: string;
  description: string | null;
}

export interface Measurement {
  id: string;
  label: string;
  type: string;
}

export interface ProductVariant {
  id: string;
  product_id: string;
  fabric_type_id: string | null;
  measurement_id: string | null;
  sku: string | null;
  price: number | null;
  stock: number;
  is_active: boolean;
  fabric_types?: FabricType | null;
  measurements?: Measurement | null;
}

export interface Product {
  id: string;
  title: string;
  description: string;
  main_image: string;
  gallery: string[];
  slug: string;
  category?: string;
  is_active: boolean;
  is_featured: boolean;
  mercadolibre_url?: string;
  amazon_url?: string;
  created_at?: string;
  product_variants?: ProductVariant[];
}
