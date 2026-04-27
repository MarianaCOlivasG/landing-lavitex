'use client';

import React from 'react';
import { Product } from '@/lib/supabase';

interface ProductInfoProps {
  product: Product;
}

export default function ProductInfo({ product }: ProductInfoProps) {
  const fabricTypes = Array.from(new Set(product.product_variants?.map(v => v.fabric_types?.name).filter(Boolean)));
  const measurements = Array.from(new Set(product.product_variants?.map(v => v.measurements?.label).filter(Boolean)));

  const shareUrl = typeof window !== 'undefined' ? window.location.href : '';
  const shareTitle = `Mira este producto en Lavitex: ${product.title}`;

  const shareLinks = [
    {
      name: 'WhatsApp',
      icon: 'chat',
      url: `https://wa.me/?text=${encodeURIComponent(`${shareTitle} ${shareUrl}`)}`,
      color: 'bg-[#25D366]'
    },
    {
      name: 'Facebook',
      icon: 'share',
      url: `https://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent(shareUrl)}`,
      color: 'bg-[#1877F2]'
    },
    {
      name: 'X',
      icon: 'close',
      url: `https://twitter.com/intent/tweet?text=${encodeURIComponent(shareTitle)}&url=${encodeURIComponent(shareUrl)}`,
      color: 'bg-black'
    }
  ];

  return (
    <div className="flex flex-col gap-8">
      {/* Title and Category */}
      <div>
        {product.category && (
          <span className="text-[#10B2CC] font-label-caps text-sm tracking-widest uppercase mb-2 block">
            {product.category}
          </span>
        )}
        <h1 className="font-headline-lg text-headline-lg text-on-surface mb-4">
          {product.title}
        </h1>
        <p className="text-on-surface-variant text-lg leading-relaxed">
          {product.description}
        </p>
      </div>

      {/* Variants */}
      <div className="space-y-6">
        {fabricTypes.length > 0 && (
          <div>
            <h3 className="font-headline-sm text-sm font-semibold text-on-surface mb-3 uppercase tracking-wider">
              Tipos de Tela
            </h3>
            <div className="flex flex-wrap gap-2">
              {fabricTypes.map((type, idx) => (
                <span key={idx} className="px-4 py-2 bg-slate-100 rounded-full text-on-surface text-sm border border-slate-200">
                  {type}
                </span>
              ))}
            </div>
          </div>
        )}

        {measurements.length > 0 && (
          <div>
            <h3 className="font-headline-sm text-sm font-semibold text-on-surface mb-3 uppercase tracking-wider">
              Medidas Disponibles
            </h3>
            <div className="flex flex-wrap gap-2">
              {measurements.map((size, idx) => (
                <span key={idx} className="px-4 py-2 bg-white border-2 border-slate-200 rounded-lg text-on-surface text-sm font-medium">
                  {size}
                </span>
              ))}
            </div>
          </div>
        )}
      </div>

      {/* Purchase Links */}
      <div className="flex flex-col gap-4 pt-4">
        <div className="flex flex-col sm:flex-row gap-4">
          {product.mercadolibre_url && (
            <a
              href={product.mercadolibre_url}
              target="_blank"
              rel="noopener noreferrer"
              className="flex-1 flex items-center justify-center gap-2 bg-[#FFE600] text-black px-8 py-4 rounded-xl font-bold hover:bg-[#F5DC00] transition-all shadow-md active:scale-95"
            >
              Ver en Mercado Libre
              <span className="material-symbols-outlined">shopping_cart</span>
            </a>
          )}
          {product.amazon_url && (
            <a
              href={product.amazon_url}
              target="_blank"
              rel="noopener noreferrer"
              className="flex-1 flex items-center justify-center gap-2 bg-[#FF9900] text-white px-8 py-4 rounded-xl font-bold hover:bg-[#E68A00] transition-all shadow-md active:scale-95"
            >
              Ver en Amazon
              <span className="material-symbols-outlined">shopping_bag</span>
            </a>
          )}
        </div>

        {/* WhatsApp remains as a persistent high-conversion channel */}
        <a
          href={`https://wa.me/5211234567890?text=${encodeURIComponent(`Hola, me interesa comprar el producto: ${product.title}`)}`}
          target="_blank"
          rel="noopener noreferrer"
          className="flex items-center justify-center gap-3 bg-[#25D366] text-white px-8 py-4 rounded-xl font-bold hover:bg-[#20bd5a] transition-all shadow-md hover:shadow-lg active:scale-95 w-full"
        >
          <span className="material-symbols-outlined">chat</span>
          Comprar por WhatsApp
        </a>
      </div>

      {/* Social Sharing */}
      <div className="pt-6 border-t border-slate-100">
        <h3 className="text-sm font-medium text-on-surface-variant mb-4">Compartir producto:</h3>
        <div className="flex gap-3">
          {shareLinks.map((link) => (
            <a
              key={link.name}
              href={link.url}
              target="_blank"
              rel="noopener noreferrer"
              className={`flex items-center gap-2 px-4 py-2 rounded-lg text-white text-sm font-medium transition-transform hover:-translate-y-1 ${link.color}`}
            >
              <span className="material-symbols-outlined text-lg">{link.icon}</span>
              {link.name}
            </a>
          ))}
        </div>
      </div>
    </div>
  );
}
