import React from 'react';
import { cache } from 'react';
import type { Metadata } from 'next';
import { notFound } from 'next/navigation';
import { getProductBySlugUseCase, listProductSlugsUseCase } from '@/features/products/usecases/productUseCases';
import TopNavBar from '@/shared/ui/TopNavBar';
import Footer from '@/shared/ui/Footer';
import ProductGallery from '@/features/products/ui/components/ProductGallery';
import ProductInfo from '@/features/products/ui/components/ProductInfo';
import Link from 'next/link';
import { absoluteUrl, createPageMetadata, DEFAULT_SOCIAL_IMAGE, serializeJsonLd, SITE_URL } from '@/lib/seo';

export const dynamic = 'force-dynamic';

const getProduct = cache(getProductBySlugUseCase);

// Generate static params for all product slugs during export
export async function generateStaticParams() {
  const slugs = await listProductSlugsUseCase();
  return slugs.map((slug) => ({ slug }));
}



interface PageProps {
  params: Promise<{ slug: string }>;
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { slug } = await params;
  const product = await getProduct(slug);

  if (!product) {
    return createPageMetadata({
      title: 'Producto no encontrado',
      description: 'El producto solicitado no se encuentra disponible en el catálogo de Lavitex del Caribe.',
      path: `/producto/${slug}`,
      noIndex: true,
    });
  }

  const productImage = product.main_image?.trim();
  const hasRealImage = productImage && !/(^|\/)logo\.png(?:[?#].*)?$/i.test(productImage);

  return createPageMetadata({
    title: product.title,
    description: product.description || `Conoce ${product.title}, una solución textil de Lavitex del Caribe para el sector hotelero y comercial.`,
    path: `/producto/${product.slug}`,
    image: hasRealImage ? productImage : DEFAULT_SOCIAL_IMAGE,
  });
}


export default async function ProductPage({ params }: PageProps) {
  const { slug } = await params;
  const product = await getProduct(slug);

  if (!product) {
    notFound();
    return null;
  }

  const realImages = [product.main_image, ...(product.gallery ?? [])]
    .map((image) => image?.trim())
    .filter((image): image is string => Boolean(image) && !/(^|\/)logo\.png(?:[?#].*)?$/i.test(image));

  const productJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'Product',
    '@id': `${SITE_URL.origin}/producto/${product.slug}#product`,
    name: product.title,
    description: product.description,
    url: absoluteUrl(`/producto/${product.slug}`),
    ...(realImages.length > 0
      ? { image: realImages.map((image) => absoluteUrl(image)) }
      : {}),
    category: product.category,
    brand: {
      '@type': 'Brand',
      name: 'Lavitex del Caribe',
    },
    manufacturer: {
      '@id': `${SITE_URL.origin}/#organization`,
    },
  };

  const breadcrumbJsonLd = {
    '@context': 'https://schema.org',
    '@type': 'BreadcrumbList',
    itemListElement: [
      {
        '@type': 'ListItem',
        position: 1,
        name: 'Inicio',
        item: SITE_URL.origin,
      },
      {
        '@type': 'ListItem',
        position: 2,
        name: 'Productos',
        item: absoluteUrl('/productos'),
      },
      {
        '@type': 'ListItem',
        position: 3,
        name: product.title,
        item: absoluteUrl(`/producto/${product.slug}`),
      },
    ],
  };

  return (
    <>
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: serializeJsonLd(productJsonLd) }}
      />
      <script
        type="application/ld+json"
        dangerouslySetInnerHTML={{ __html: serializeJsonLd(breadcrumbJsonLd) }}
      />
      <TopNavBar />
      
      <main className="min-h-screen pt-24 pb-20 bg-white">
        <div className="max-w-container-max mx-auto px-gutter md:px-16 lg:px-24">
          
          {/* Breadcrumbs */}
          <nav className="mb-10">
            <ol className="flex items-center gap-2 text-sm text-on-surface-variant font-medium">
              <li>
                <Link href="/" className="hover:text-[#10B2CC] transition-colors">Inicio</Link>
              </li>
              <li className="material-symbols-outlined text-xs">chevron_right</li>
              <li>
                <Link href="/productos" className="hover:text-[#10B2CC] transition-colors">Productos</Link>
              </li>
              <li className="material-symbols-outlined text-xs">chevron_right</li>
              <li className="text-on-surface truncate max-w-[200px]">{product.title}</li>
            </ol>
          </nav>

          {/* Product Grid */}
          <div className="grid grid-cols-1 lg:grid-cols-2 gap-16 items-start">
            
            {/* Left Column: Gallery */}
            <ProductGallery 
              mainImage={product.main_image} 
              gallery={product.gallery} 
              title={product.title} 
            />

            {/* Right Column: Details */}
            <ProductInfo product={product} />

          </div>

          {/* Related Information / Full Description if needed */}
          <div className="mt-20 pt-16 border-t border-slate-100">
             <h2 className="font-headline-md text-headline-md text-on-surface mb-8">
               Compromiso Lavitex
             </h2>
             <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div className="p-6 bg-slate-50 rounded-2xl">
                   <span className="material-symbols-outlined text-[#10B2CC] text-4xl mb-4">verified</span>
                   <h3 className="font-bold text-lg mb-2">Calidad Certificada</h3>
                   <p className="text-sm text-on-surface-variant">Nuestros productos cumplen con los más altos estándares textiles.</p>
                </div>
                <div className="p-6 bg-slate-50 rounded-2xl">
                   <span className="material-symbols-outlined text-[#10B2CC] text-4xl mb-4">local_shipping</span>
                   <h3 className="font-bold text-lg mb-2">Envío Seguro</h3>
                   <p className="text-sm text-on-surface-variant">Distribución nacional a través de las mejores plataformas.</p>
                </div>
                <div className="p-6 bg-slate-50 rounded-2xl">
                   <span className="material-symbols-outlined text-[#10B2CC] text-4xl mb-4">support_agent</span>
                   <h3 className="font-bold text-lg mb-2">Atención Personalizada</h3>
                   <p className="text-sm text-on-surface-variant">Estamos aquí para resolver cualquier duda sobre tu pedido.</p>
                </div>
             </div>
          </div>
        </div>
      </main>

      <Footer />
    </>
  );
}
