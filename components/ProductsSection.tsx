import React from 'react';
import { mockProducts } from '../data/products';
import ProductCard from './ProductCard';

export default function ProductsSection() {
  return (
    <section id="catalog" className="w-full py-section-gap bg-surface">
      <div className="max-w-container-max mx-auto px-gutter md:px-16 lg:px-24">
        <div className="flex flex-col md:flex-row justify-between items-end mb-16 gap-6">
          <div>
            <span className="font-label-caps text-label-caps text-secondary uppercase tracking-[0.2em] mb-4 block">Líneas de Producto</span>
            <h2 className="font-headline-md text-headline-md text-on-surface">Diseñado para la Excelencia</h2>
          </div>
          <button className="bg-transparent text-primary border border-primary px-6 py-3 rounded-DEFAULT font-headline-sm text-headline-sm hover:bg-surface-container-low transition-colors duration-300">
            Ver Catálogo Completo
          </button>
        </div>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {mockProducts.map((product) => (
            <ProductCard key={product.id} product={product} />
          ))}
        </div>
      </div>
    </section>
  );
}
