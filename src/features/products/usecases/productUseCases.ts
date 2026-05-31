'use server';

import { 
  fetchProductsFromSupabase, 
  fetchFeaturedProductsFromSupabase, 
  fetchProductBySlugFromSupabase,
  fetchAllProductSlugs 
} from '../data/supabaseProducts';
import {
  fetchProductsFromMySQL,
  fetchFeaturedProductsFromMySQL,
  fetchProductBySlugFromMySQL,
  fetchAllProductSlugsFromMySQL
} from '../data/mysqlProducts';
import { Product } from '../domain/product';

const isMySQL = process.env.DB_TYPE === 'mysql';

export async function getProductsUseCase(search = ''): Promise<Product[]> {
  if (isMySQL) {
    return fetchProductsFromMySQL(search);
  }
  return fetchProductsFromSupabase(search);
}

export async function getFeaturedProductsUseCase(): Promise<Product[]> {
  if (isMySQL) {
    return fetchFeaturedProductsFromMySQL();
  }
  return fetchFeaturedProductsFromSupabase();
}

export async function getProductBySlugUseCase(slug: string): Promise<Product | null> {
  if (isMySQL) {
    return fetchProductBySlugFromMySQL(slug);
  }
  return fetchProductBySlugFromSupabase(slug);
}

export async function listProductSlugsUseCase(): Promise<string[]> {
  if (isMySQL) {
    return fetchAllProductSlugsFromMySQL();
  }
  return fetchAllProductSlugs();
}

