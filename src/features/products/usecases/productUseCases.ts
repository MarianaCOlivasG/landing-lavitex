import { 
  fetchProductsFromSupabase, 
  fetchFeaturedProductsFromSupabase, 
  fetchProductBySlugFromSupabase,
  fetchAllProductSlugs 
} from '../data/supabaseProducts';
import { Product } from '../domain/product';

export async function getProductsUseCase(search = ''): Promise<Product[]> {
  // Business logic can be added here (e.g., mapping, filtering, caching)
  return fetchProductsFromSupabase(search);
}

export async function getFeaturedProductsUseCase(): Promise<Product[]> {
  return fetchFeaturedProductsFromSupabase();
}

export async function getProductBySlugUseCase(slug: string): Promise<Product | null> {
  return fetchProductBySlugFromSupabase(slug);
}

export async function listProductSlugsUseCase(): Promise<string[]> {
  return fetchAllProductSlugs();
}
