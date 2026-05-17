import React from 'react';
import Link from 'next/link';
import { getFeaturedProductsUseCase } from '@/features/products/usecases/productUseCases';
import ProductCard from '@/features/products/ui/components/ProductCard';

export default async function ProductsSection() {
  const products = await getFeaturedProductsUseCase()

  return (
    <section id="catalog" className="w-full py-section-gap bg-gradient-to-b from-slate-50 to-slate-100">
      <div className="max-w-container-max mx-auto px-gutter md:px-16 lg:px-24">

        {/* Header */}
        <div className="flex flex-col md:flex-row justify-between items-end mb-16 gap-6">
          <div>
            <div className="flex flex-wrap items-center gap-x-3 gap-y-2 mb-4">
              <span className="font-label-caps text-label-caps text-secondary uppercase tracking-[0.2em]">
                Líneas de Producto
              </span>
              <span className="text-slate-300 text-xs mx-1">|</span>
              {['Hogar', 'Hotelera', 'Spa', 'Hospital', 'Eventos'].map((line, index) => (
                <React.Fragment key={line}>
                  <span className="text-xs font-medium tracking-widest uppercase text-slate-500">
                    {line}
                  </span>
                  {index < 4 && <span className="text-slate-300 text-xs">•</span>}
                </React.Fragment>
              ))}
            </div>
            <h2 className="font-headline-md text-headline-md text-on-surface">
              Productos Destacados
            </h2>
          </div>
          <Link
            href="/productos"
            className="bg-transparent text-[#10B2CC] border border-[#10B2CC] px-6 py-3 rounded-DEFAULT
                       font-headline-sm text-headline-sm hover:bg-[#EDF4F6]
                       transition-colors duration-300 flex items-center gap-2 whitespace-nowrap"
          >
            Ver Catálogo Completo
            <span className="material-symbols-outlined text-[18px] leading-none">arrow_forward</span>
          </Link>
        </div>

        {/* Grid */}
        {products.length > 0 ? (
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            {products.map(p => <ProductCard key={p.id} product={p} />)}
          </div>
        ) : (
          <p className="text-center text-on-surface-variant py-16">
            No hay productos destacados en este momento.
          </p>
        )}
      </div>
    </section>
  )
}
