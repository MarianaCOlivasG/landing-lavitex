import { createClient } from '@supabase/supabase-js'

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || ''
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || ''

if (!supabaseUrl || !supabaseAnonKey) {
  console.warn('Supabase credentials are missing. If this is during build time, ensure you are passing build-args if you have client-side fetching.')
}

export const supabase = createClient(supabaseUrl || 'https://placeholder.supabase.co', supabaseAnonKey || 'placeholder')

// ─── Types ────────────────────────────────────────────────────────────────────

export interface FabricType {
  id: string
  name: string
  description: string | null
}

export interface Measurement {
  id: string
  label: string
  type: string
}

export interface ProductVariant {
  id: string
  product_id: string
  fabric_type_id: string | null
  measurement_id: string | null
  sku: string | null
  price: number | null
  stock: number
  is_active: boolean
  fabric_types?: FabricType | null
  measurements?: Measurement | null
}

export interface Product {
  id: string
  slug: string
  title: string
  description: string | null
  main_image: string
  gallery: string[]
  category: string | null
  is_active: boolean
  is_featured: boolean
  mercadolibre_url: string | null
  amazon_url: string | null
  created_at: string
  product_variants?: ProductVariant[]
}

// ─── Data fetching helpers ────────────────────────────────────────────────────

/** Fetch products with optional title search. Used in Server Components. */
export async function getProducts(search = ''): Promise<Product[]> {
  let query = supabase
    .from('products')
    .select(`
      *,
      product_variants (
        *,
        fabric_types ( id, name, description ),
        measurements ( id, label, type )
      )
    `)
    .eq('is_active', true)
    .order('created_at', { ascending: false })

  if (search.trim()) {
    query = query.ilike('title', `%${search.trim()}%`)
  }

  const { data, error } = await query

  if (error) {
    console.error('[getProducts] Supabase error:', error.message)
    return []
  }

  return (data as Product[]) ?? []
}

/** Fetch the 6 featured products for the home page. */
export async function getFeaturedProducts(): Promise<Product[]> {
  const { data, error } = await supabase
    .from('products')
    .select(`
      *,
      product_variants (
        *,
        fabric_types ( id, name, description ),
        measurements ( id, label, type )
      )
    `)
    .eq('is_active', true)
    .eq('is_featured', true)
    .order('created_at', { ascending: true })
    .limit(6)

  if (error) {
    console.error('[getFeaturedProducts] Supabase error:', error.message)
    return []
  }

  return (data as Product[]) ?? []
}

/** Fetch a single product by slug. */
export async function getProductBySlug(slug: string): Promise<Product | null> {
  const { data, error } = await supabase
    .from('products')
    .select(`
      *,
      product_variants (
        *,
        fabric_types ( id, name, description ),
        measurements ( id, label, type )
      )
    `)
    .eq('slug', slug)
    .eq('is_active', true)
    .single()

  if (error) {
    console.error('[getProductBySlug] Supabase error:', error.message)
    return null
  }

  return data as Product
}
