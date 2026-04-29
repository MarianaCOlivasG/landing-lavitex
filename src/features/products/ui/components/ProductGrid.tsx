"use client";
import { useEffect, useState } from 'react';
import { useSearchParams } from 'next/navigation';
import { getProductsUseCase } from '@/features/products/usecases/productUseCases';
import ProductCard from './ProductCard';
import styles from './productos.module.css';

export default function ProductGrid() {
  const searchParams = useSearchParams();
  const search = searchParams.get('query') ?? '';

  const [products, setProducts] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    setLoading(true);
    getProductsUseCase(search).then((data) => {
      setProducts(data);
      setLoading(false);
    });
  }, [search]);

  if (loading) {
    return (
      <div className={styles.grid}>
        {Array.from({ length: 9 }).map((_, i) => (
          <div key={i} className={`${styles.card} ${styles.skeleton}`}>
            <div className={styles.skeletonImage} />
            <div className={styles.cardBody}>
              <div className={styles.skeletonLine} style={{ width: '70%', height: 22 }} />
              <div className={styles.skeletonLine} style={{ width: '100%', height: 14, marginTop: 8 }} />
              <div className={styles.skeletonLine} style={{ width: '90%', height: 14, marginTop: 4 }} />
              <div className={styles.skeletonLine} style={{ width: '50%', height: 18, marginTop: 16 }} />
            </div>
          </div>
        ))}
      </div>
    );
  }

  if (products.length === 0) {
    return (
      <div className={styles.emptyState}>
        <span className={`material-symbols-outlined ${styles.emptyIcon}`}>inventory_2</span>
        <h3>No se encontraron productos</h3>
        <p>Intenta con otro término de búsqueda.</p>
        <a href="/productos" className={styles.emptyLink}>Ver todos los productos</a>
      </div>
    );
  }

  return (
    <div className={styles.grid}>
      {products.map((p) => (
        <ProductCard key={p.id} product={p} />
      ))}
    </div>
  );
}
