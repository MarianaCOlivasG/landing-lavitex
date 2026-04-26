import React from 'react';
import Link from 'next/link';
import { getFeaturedProducts } from '@/lib/supabase';
import ProductCard from './ProductCard';

export default async function ProductsSection() {
  const products = await getFeaturedProducts()

  return (
    <section id="catalog" className="w-full py-section-gap bg-gradient-to-b from-slate-50 to-slate-100">
      <div className="max-w-container-max mx-auto px-gutter md:px-16 lg:px-24">

        {/* Header */}
        <div className="flex flex-col md:flex-row justify-between items-end mb-16 gap-6">
          <div>
            <span className="font-label-caps text-label-caps text-secondary uppercase tracking-[0.2em] mb-4 block">
              Líneas de Producto
            </span>
            <h2 className="font-headline-md text-headline-md text-on-surface">
              Diseñado para la Excelencia
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
