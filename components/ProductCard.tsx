import React from 'react';
import Image from 'next/image';
import Link from 'next/link';
import { Product } from '@/lib/supabase';
import styles from '@/app/productos/productos.module.css';

interface ProductCardProps {
  product: Product;
}

export default function ProductCard({ product }: ProductCardProps) {
  // Get unique fabric types and measurements from variants
  const fabricTypes = Array.from(new Set(product.product_variants?.map(v => v.fabric_types?.name).filter(Boolean)));
  const measurements = Array.from(new Set(product.product_variants?.map(v => v.measurements?.label).filter(Boolean)));

  return (
    <div className={`${styles.card} premium-card`}>
      <div className={styles.cardImageWrap}>
        <Image 
          src={product.main_image} 
          alt={product.title} 
          fill 
          className={styles.cardImage}
          sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
        />
        {product.category && (
          <span className={styles.categoryBadge}>{product.category}</span>
        )}
      </div>

      <div className={styles.cardBody}>
        <h3 className={styles.cardTitle}>{product.title}</h3>
        <p className={styles.cardDescription}>{product.description}</p>
        
        <div className="flex flex-col gap-3 mt-2">
          {fabricTypes.length > 0 && (
            <div className={styles.tagRow}>
              <span className={styles.tagLabel}>Telas:</span>
              {fabricTypes.map((type, idx) => (
                <span key={idx} className={styles.tag}>{type}</span>
              ))}
            </div>
          )}
          
          {measurements.length > 0 && (
            <div className={styles.tagRow}>
              <span className={styles.tagLabel}>Medidas:</span>
              {measurements.map((size, idx) => (
                <span key={idx} className={`${styles.tag} ${styles.tagSize}`}>{size}</span>
              ))}
            </div>
          )}
        </div>

        <div className={styles.cardFooter}>
          <Link href={`/producto/${product.slug}`} className={`${styles.ctaBtn} w-full justify-center`}>
            Ver producto
            <span className="material-symbols-outlined text-[18px]" data-icon="arrow_forward">arrow_forward</span>
          </Link>
        </div>
      </div>
    </div>
  );
}
