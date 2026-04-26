import { getProducts } from '@/lib/supabase'
import Link from 'next/link'
import { Suspense } from 'react'
import TopNavBar from '@/components/TopNavBar'
import Footer from '@/components/Footer'
import ProductCard from '@/components/ProductCard'
import styles from './productos.module.css'

// ─── Search form ──────────────────────────────────────────────────────────────

function SearchBar({ defaultValue }: { defaultValue: string }) {
  return (
    <form action="/productos" method="GET" className={styles.searchForm}>
      <div className={styles.searchInputWrap}>
        <span className={`material-symbols-outlined ${styles.searchIcon}`}>search</span>
        <input
          type="text"
          name="q"
          defaultValue={defaultValue}
          placeholder="Buscar productos…"
          className={styles.searchInput}
          autoComplete="off"
        />
        {defaultValue && (
          <Link href="/productos" className={styles.clearBtn} title="Limpiar búsqueda">
            <span className="material-symbols-outlined">close</span>
          </Link>
        )}
      </div>
      <button type="submit" className={`${styles.searchBtn} btn-primary`}>Buscar</button>
    </form>
  )
}

// ─── Product grid (async) ─────────────────────────────────────────────────────

async function ProductGrid({ search }: { search: string }) {
  const products = await getProducts(search)

  if (products.length === 0) {
    return (
      <div className={styles.emptyState}>
        <span className={`material-symbols-outlined ${styles.emptyIcon}`}>inventory_2</span>
        <h3>No se encontraron productos</h3>
        <p>Intenta con otro término de búsqueda.</p>
        <Link href="/productos" className={styles.emptyLink}>Ver todos los productos</Link>
      </div>
    )
  }

  return (
    <div className={styles.grid}>
      {products.map(p => <ProductCard key={p.id} product={p} />)}
    </div>
  )
}

// ─── Skeleton ─────────────────────────────────────────────────────────────────

function ProductsSkeleton() {
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
  )
}

// ─── Page ─────────────────────────────────────────────────────────────────────

interface PageProps {
  searchParams: Promise<{ q?: string }>
}

export const metadata = {
  title: 'Productos – Lavitex del Caribe',
  description: 'Catálogo completo de lencería hotelera premium: sábanas, toallas, cobertores, manteles y más.',
}

export default async function ProductosPage({ searchParams }: PageProps) {
  const params = await searchParams
  const search = params.q ?? ''

  return (
    <>
      <TopNavBar />
      <main className={styles.page}>

        {/* ── Hero ── */}
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

        {/* ── Search ── */}
        <section className={styles.searchSection}>
          <div className={styles.container}>
            <SearchBar defaultValue={search} />
            {search && (
              <p className={styles.searchNote}>
                Resultados para: <strong>&ldquo;{search}&rdquo;</strong>
              </p>
            )}
          </div>
        </section>

        {/* ── Products grid ── */}
        <section className={styles.productsSection}>
          <div className={styles.container}>
            <Suspense fallback={<ProductsSkeleton />}>
              <ProductGrid search={search} />
            </Suspense>
          </div>
        </section>

      </main>
      <Footer />
    </>
  )
}
