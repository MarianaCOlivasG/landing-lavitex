'use server';

import {
  fetchProductsFromMySQL,
  fetchFeaturedProductsFromMySQL,
  fetchProductBySlugFromMySQL,
  fetchAllProductSlugsFromMySQL
} from '../data/mysqlProducts';
import { Product } from '../domain/product';

export async function getProductsUseCase(search = ''): Promise<Product[]> {
  return fetchProductsFromMySQL(search);
}

export async function getFeaturedProductsUseCase(): Promise<Product[]> {
  return fetchFeaturedProductsFromMySQL();
}

export async function getProductBySlugUseCase(slug: string): Promise<Product | null> {
  return fetchProductBySlugFromMySQL(slug);
}

export async function listProductSlugsUseCase(): Promise<string[]> {
  return fetchAllProductSlugsFromMySQL();
}
