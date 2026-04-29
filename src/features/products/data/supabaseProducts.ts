import { supabase } from '@/lib/supabaseClient';
import { Product } from '../domain/product';

export async function fetchProductsFromSupabase(search = ''): Promise<Product[]> {
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
    .order('created_at', { ascending: false });

  if (search.trim()) {
    query = query.ilike('title', `%${search.trim()}%`);
  }

  const { data, error } = await query;

  if (error) {
    console.error('[fetchProductsFromSupabase] Supabase error:', error.message);
    return [];
  }

  return (data as any[]) ?? [];
}

export async function fetchFeaturedProductsFromSupabase(): Promise<Product[]> {
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
    .limit(6);

  if (error) {
    console.error('[fetchFeaturedProductsFromSupabase] Supabase error:', error.message);
    return [];
  }

  return (data as any[]) ?? [];
}

export async function fetchProductBySlugFromSupabase(slug: string): Promise<Product | null> {
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
    .maybeSingle();

  if (error) {
    console.error('[fetchProductBySlugFromSupabase] Supabase error:', error.message);
    return null;
  }

  return data as any;
}

export async function fetchAllProductSlugs(): Promise<string[]> {
  const { data, error } = await supabase
    .from('products')
    .select('slug')
    .eq('is_active', true);

  if (error) {
    console.error('[fetchAllProductSlugs] Supabase error:', error.message);
    return [];
  }

  return (data as { slug: string }[]).map((row) => row.slug);
}
