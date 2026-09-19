import React from 'react';
import Image from 'next/image';
import Link from 'next/link';
import { Product } from '@/features/products/domain/product';
import styles from './productos.module.css';

interface ProductCardProps {
  product: Product;
}

export default function ProductCard({ product }: ProductCardProps) {
  // Get unique fabric types and measurements from variants
  const fabricTypes = Array.from(new Set(
    (product.product_variants ?? []).flatMap((variant) =>
      variant.fabric_types?.name ? [variant.fabric_types.name] : []
    )
  ));
  const measurements = Array.from(new Set(
    (product.product_variants ?? []).flatMap((variant) =>
      variant.measurements?.label ? [variant.measurements.label] : []
    )
  ));
  const hasImage = typeof product.main_image === 'string' && product.main_image.trim().length > 0;

  return (
    <div className={`${styles.card} premium-card`}>
      <div className={styles.cardImageWrap}>
        {hasImage ? (
          <Image
            src={product.main_image}
            alt={product.title}
            fill
            className={styles.cardImage}
            sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
          />
        ) : (
          <div className={styles.cardImagePlaceholder} aria-label={`${product.title}, imagen no disponible`}>
            <span className={styles.placeholderIcon} aria-hidden="true">
              <span className="material-symbols-outlined">image</span>
            </span>
            <span className={styles.placeholderText}>Imagen no disponible</span>
          </div>
        )}
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
