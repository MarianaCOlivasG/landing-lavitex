'use client';

import React, { useState } from 'react';
import Image from 'next/image';

interface ProductGalleryProps {
  mainImage: string;
  gallery: string[];
  title: string;
}

export default function ProductGallery({ mainImage, gallery, title }: ProductGalleryProps) {
  const availableImages = Array.from(new Set(
    [mainImage, ...(gallery || [])]
      .map((image) => typeof image === 'string' ? image.trim() : '')
      .filter((image) => image.length > 0 && !/(^|\/)logo\.png(?:[?#].*)?$/i.test(image))
  )).slice(0, 5);
  const images = availableImages.length > 0 ? availableImages : [''];
  const [selectedImage, setSelectedImage] = useState(0);
  const [failedImages, setFailedImages] = useState<Set<string>>(new Set());
  const selectedSource = images[selectedImage] ?? '';
  const selectedImageUnavailable = selectedSource.length === 0 || failedImages.has(selectedSource);

  const markImageAsUnavailable = (source: string) => {
    setFailedImages((current) => {
      const updated = new Set(current);
      updated.add(source);
      return updated;
    });
  };

  return (
    <div className="flex flex-col gap-4">
      {/* Main Image */}
      <div className="relative aspect-square w-full overflow-hidden rounded-2xl bg-slate-100 shadow-lg group">
        {selectedImageUnavailable ? (
          <div
            className="absolute inset-0 flex flex-col items-center justify-center gap-4 bg-[linear-gradient(135deg,rgba(255,255,255,0.52),transparent_52%),#e9edf0] text-slate-500"
            aria-label={`${title}, imagen no disponible`}
          >
            <span className="absolute inset-6 rounded-xl border border-slate-400/15" aria-hidden="true" />
            <span className="flex h-16 w-16 items-center justify-center rounded-full border border-slate-300 bg-white/45" aria-hidden="true">
              <span className="material-symbols-outlined text-[30px] text-slate-500">image</span>
            </span>
            <span className="text-[11px] font-semibold uppercase tracking-[0.14em] text-slate-500">Imagen no disponible</span>
          </div>
        ) : (
          <Image
            src={selectedSource}
            alt={title}
            fill
            className="object-cover transition-transform duration-500 group-hover:scale-105"
            sizes="(max-width: 768px) 100vw, 50vw"
            priority
            onError={() => markImageAsUnavailable(selectedSource)}
          />
        )}
      </div>

      {/* Thumbnails */}
      {images.length > 1 && <div className="flex gap-3 overflow-x-auto pb-2 scrollbar-hide">
        {images.map((img, idx) => (
          <button
            key={`${img}-${idx}`}
            onClick={() => setSelectedImage(idx)}
            className={`relative aspect-square w-20 flex-shrink-0 overflow-hidden rounded-lg border-2 transition-all duration-200 ${
              selectedImage === idx ? 'border-[#10B2CC] scale-95 shadow-sm' : 'border-transparent hover:border-slate-300'
            }`}
            aria-label={`Ver imagen ${idx + 1} de ${title}`}
          >
            {failedImages.has(img) ? (
              <span className="absolute inset-0 flex items-center justify-center bg-[#e9edf0] text-slate-500">
                <span className="material-symbols-outlined text-xl" aria-hidden="true">image</span>
              </span>
            ) : (
              <Image
                src={img}
                alt={`${title}, imagen ${idx + 1}`}
                fill
                className="object-cover"
                sizes="80px"
                onError={() => markImageAsUnavailable(img)}
              />
            )}
          </button>
        ))}
      </div>}
    </div>
  );
}
