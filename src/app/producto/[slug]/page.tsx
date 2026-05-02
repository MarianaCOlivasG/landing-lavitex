import React from 'react';
import { notFound } from 'next/navigation';
import { getProductBySlugUseCase, listProductSlugsUseCase } from '@/features/products/usecases/productUseCases';
import TopNavBar from '@/shared/ui/TopNavBar';
import Footer from '@/shared/ui/Footer';
import ProductGallery from '@/features/products/ui/components/ProductGallery';
import ProductInfo from '@/features/products/ui/components/ProductInfo';
import Link from 'next/link';

// Generate static params for all product slugs during export
export async function generateStaticParams() {
  const slugs = await listProductSlugsUseCase();
  return slugs.map((slug) => ({ slug }));
}



interface PageProps {
  params: Promise<{ slug: string }>;
}

export const dynamic = 'force-dynamic';

export default async function ProductPage({ params }: PageProps) {
  const { slug } = await params;
  const product = await getProductBySlugUseCase(slug);

  if (!product) {
    notFound();
    return null;
  }

  return (
    <>
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
