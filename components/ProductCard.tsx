import React from 'react';
import { Product } from '../data/products';

interface ProductCardProps {
  product: Product;
}

export default function ProductCard({ product }: ProductCardProps) {
  return (
    <div className="group bg-surface-container-lowest rounded-DEFAULT overflow-hidden shadow-md hover:shadow-lg transition-all duration-500 flex flex-col">
      <div className="relative h-72 w-full bg-surface-container overflow-hidden border-b border-surface-container-highest">
        <img 
          alt={product.alt}
          className="w-full h-full object-cover transform group-hover:scale-105 transition-transform duration-700" 
          data-alt={product.alt}
          src={product.image}
        />
        {product.badge && (
          <div className="absolute top-4 left-4 bg-surface-container-low text-primary px-3 py-1 text-xs font-label-caps uppercase tracking-wider rounded-DEFAULT">
            {product.badge}
          </div>
        )}
      </div>
      <div className="p-8 flex-1 flex flex-col">
        <h3 className="font-headline-sm text-headline-sm text-on-surface mb-2">{product.name}</h3>
        <p className="font-body-md text-body-md text-on-surface-variant mb-6 line-clamp-2">{product.description}</p>
        <div className="mt-auto pt-4 border-t border-surface-container-highest flex justify-between items-center text-sm">
          <span className="text-tertiary font-medium">{product.specs}</span>
          <span className="material-symbols-outlined text-outline" data-icon={product.icon}>{product.icon}</span>
        </div>
      </div>
    </div>
  );
}
