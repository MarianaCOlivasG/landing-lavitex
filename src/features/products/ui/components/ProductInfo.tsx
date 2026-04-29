'use client';

import React from 'react';
import { Product } from '@/features/products/domain/product';

interface ProductInfoProps {
  product: any; // Using any for now to avoid complex mapping logic, but typed to Product in intent
}

export default function ProductInfo({ product }: { product: any }) {
  const [shareUrl, setShareUrl] = React.useState('');

  React.useEffect(() => {
    setShareUrl(window.location.href);
  }, []);

  const fabricTypes = Array.from(new Set(product.product_variants?.map((v: any) => v.fabric_types?.name).filter(Boolean)));
  const measurements = Array.from(new Set(product.product_variants?.map((v: any) => v.measurements?.label).filter(Boolean)));

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
              {fabricTypes.map((type: any, idx: number) => (
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
              {measurements.map((size: any, idx: number) => (
                <span key={idx} className="px-4 py-2 bg-white border-2 border-slate-200 rounded-lg text-on-surface text-sm font-medium">
                  {size}
                </span>
              ))}
            </div>
          </div>
        )}
      </div>

      {/* Purchase Links (Icon only) */}
      <div className="flex items-center gap-3 pt-4">
        <span className="text-sm font-medium text-on-surface-variant mr-2">Disponibilidad en:</span>
        <div className="flex gap-4">
          {product.mercadolibre_url && (
            <a
              href={product.mercadolibre_url}
              target="_blank"
              rel="noopener noreferrer"
              className="w-12 h-12 flex items-center justify-center bg-[#FFE600] rounded-full shadow-md hover:shadow-lg transition-all hover:-translate-y-1 active:scale-90"
              title="Ver en Mercado Libre"
            >
              {/* Simple representation of ML logo (shaking hands / M) */}
              <img 
                src="https://http2.mlstatic.com/frontend-assets/ui-navigation/5.21.22/mercadolibre/logo__small.png" 
                alt="Mercado Libre" 
                className="w-8 h-auto object-contain"
              />
            </a>
          )}
          {product.amazon_url && (
            <a
              href={product.amazon_url}
              target="_blank"
              rel="noopener noreferrer"
              className="w-12 h-12 flex items-center justify-center bg-white border border-slate-200 rounded-full shadow-md hover:shadow-lg transition-all hover:-translate-y-1 active:scale-90"
              title="Ver en Amazon"
            >
              <img 
                src="https://upload.wikimedia.org/wikipedia/commons/4/4a/Amazon_icon.svg" 
                alt="Amazon" 
                className="w-7 h-auto object-contain"
              />
            </a>
          )}
        </div>
      </div>

      {/* Social Sharing (Icon only) */}
      <div className="pt-8 border-t border-slate-100">
        <div className="flex items-center gap-4">
          <span className="text-sm font-medium text-on-surface-variant">Compartir:</span>
          <div className="flex gap-3">
            {shareLinks.map((link) => (
              <a
                key={link.name}
                href={link.url}
                target="_blank"
                rel="noopener noreferrer"
                className={`w-10 h-10 flex items-center justify-center rounded-full text-white shadow-sm transition-all hover:-translate-y-1 hover:shadow-md active:scale-90 ${link.color}`}
                title={`Compartir en ${link.name}`}
              >
                <span className="material-symbols-outlined text-xl">{link.icon}</span>
              </a>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
