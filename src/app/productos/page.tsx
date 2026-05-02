import { Suspense } from 'react';
import TopNavBar from '@/shared/ui/TopNavBar';
import Footer from '@/shared/ui/Footer';
import SearchBar from '@/features/products/ui/components/SearchBar';
import ProductGrid from '@/features/products/ui/components/ProductGrid';
import styles from '@/features/products/ui/components/productos.module.css';

// Page metadata (must be exported from a server component)
export const metadata = {
  title: 'Productos – Lavitex del Caribe',
  description: 'Catálogo completo de lencería hotelera premium: sábanas, toallas, cobertores, manteles y más.',
};

export const dynamic = 'force-dynamic';

export default function ProductosPage() {
  return (
    <>
      <TopNavBar />
      <main className={styles.page}>
        {/* Hero */}
        <section className={styles.hero}>
          <div className={styles.heroContent}>
            <span className={styles.heroEyebrow}>Catálogo Textil</span>
            <h1 className={styles.heroTitle}>Nuestros Productos</h1>
            <p className={styles.heroSubtitle}>
              Lencería hotelera de alto rendimiento diseñada para el sector hotelero y comercial en el Caribe.
            </p>
          </div>
          <div className={styles.heroDecor} aria-hidden="true" />
        </section>

        {/* Search */}
        <section className={styles.searchSection}>
          <div className={styles.container}>
            <Suspense fallback={<div className="h-12 w-full bg-slate-100 animate-pulse rounded-DEFAULT" />}>
              <SearchBar />
            </Suspense>
          </div>
        </section>

        {/* Products grid */}
        <section className={styles.productsSection}>
          <div className={styles.container}>
            <Suspense fallback={<div className="grid grid-cols-1 md:grid-cols-3 gap-8"><div className="h-64 bg-slate-100 animate-pulse rounded-2xl" /></div>}>
              <ProductGrid />
            </Suspense>
          </div>
        </section>
      </main>
      <Footer />
    </>
  );
}
