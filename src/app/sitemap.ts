import type { MetadataRoute } from 'next';
import { listProductSlugsUseCase } from '@/features/products/usecases/productUseCases';
import { absoluteUrl } from '@/lib/seo';
import catalogProducts from '../../scratch/products.json';

export const revalidate = 86400;

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const databaseProductSlugs = await listProductSlugsUseCase();
  const productSlugs = databaseProductSlugs.length > 0
    ? databaseProductSlugs
    : catalogProducts.map((product) => product.slug);

  const staticRoutes: MetadataRoute.Sitemap = [
    { url: absoluteUrl('/'), changeFrequency: 'weekly', priority: 1 },
    { url: absoluteUrl('/productos'), changeFrequency: 'weekly', priority: 0.9 },
    { url: absoluteUrl('/carta-garantia'), changeFrequency: 'yearly', priority: 0.6 },
    { url: absoluteUrl('/sustentabilidad'), changeFrequency: 'yearly', priority: 0.5 },
    { url: absoluteUrl('/politicas-de-calidad'), changeFrequency: 'yearly', priority: 0.5 },
    { url: absoluteUrl('/aviso-de-privacidad'), changeFrequency: 'yearly', priority: 0.3 },
    { url: absoluteUrl('/terminos-de-servicio'), changeFrequency: 'yearly', priority: 0.3 },
  ];

  const productRoutes: MetadataRoute.Sitemap = productSlugs.map((slug) => ({
    url: absoluteUrl(`/producto/${encodeURIComponent(slug)}`),
    changeFrequency: 'monthly',
    priority: 0.7,
  }));

  return [...staticRoutes, ...productRoutes];
}
