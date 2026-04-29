'use client';

import React, { useState } from 'react';
import Image from 'next/image';

interface ProductGalleryProps {
  mainImage: string;
  gallery: string[];
  title: string;
}

export default function ProductGallery({ mainImage, gallery, title }: ProductGalleryProps) {
  const images = [mainImage, ...(gallery || [])].slice(0, 5);
  const [selectedImage, setSelectedImage] = useState(0);

  return (
    <div className="flex flex-col gap-4">
      {/* Main Image */}
      <div className="relative aspect-square w-full overflow-hidden rounded-2xl bg-slate-100 shadow-lg group">
        <Image
          src={images[selectedImage]}
          alt={title}
          fill
          className="object-cover transition-transform duration-500 group-hover:scale-105"
          sizes="(max-width: 768px) 100vw, 50vw"
          priority
        />
      </div>

      {/* Thumbnails */}
      <div className="flex gap-3 overflow-x-auto pb-2 scrollbar-hide">
        {images.map((img, idx) => (
          <button
            key={idx}
            onClick={() => setSelectedImage(idx)}
            className={`relative aspect-square w-20 flex-shrink-0 overflow-hidden rounded-lg border-2 transition-all duration-200 ${
              selectedImage === idx ? 'border-[#10B2CC] scale-95 shadow-sm' : 'border-transparent hover:border-slate-300'
            }`}
          >
            <Image
              src={img}
              alt={`${title} thumbnail ${idx + 1}`}
              fill
              className="object-cover"
              sizes="80px"
            />
          </button>
        ))}
      </div>
    </div>
  );
}
