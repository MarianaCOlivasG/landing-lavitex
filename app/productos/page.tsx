import { getProducts, Product } from '@/lib/supabase'
import Image from 'next/image'
import Link from 'next/link'
import { Suspense } from 'react'
import styles from './productos.module.css'

// ─── Search form (client search handled via URL params) ───────────────────────

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
      <button type="submit" className={styles.searchBtn}>Buscar</button>
    </form>
  )
}

// ─── Price range from variants ────────────────────────────────────────────────

function getPriceRange(product: Product): string {
  const prices = (product.product_variants ?? [])
    .map(v => v.price)
    .filter((p): p is number => p !== null && p > 0)

  if (prices.length === 0) return 'Consultar precio'
  const min = Math.min(...prices)
  const max = Math.max(...prices)
  const fmt = (n: number) =>
    new Intl.NumberFormat('es-MX', { style: 'currency', currency: 'MXN', maximumFractionDigits: 0 }).format(n)

  return min === max ? fmt(min) : `${fmt(min)} – ${fmt(max)}`
}

// ─── Unique fabrics from variants ─────────────────────────────────────────────

function getFabrics(product: Product): string[] {
  const seen = new Set<string>()
  const fabrics: string[] = []
  for (const v of product.product_variants ?? []) {
    const name = v.fabric_types?.name
    if (name && !seen.has(name)) {
      seen.add(name)
      fabrics.push(name)
    }
  }
  return fabrics
}

// ─── Unique sizes from variants ───────────────────────────────────────────────

function getSizes(product: Product): string[] {
  const seen = new Set<string>()
  const sizes: string[] = []
  for (const v of product.product_variants ?? []) {
    const label = v.measurements?.label
    if (label && !seen.has(label)) {
      seen.add(label)
      sizes.push(label)
    }
  }
  return sizes
}

// ─── Product card ─────────────────────────────────────────────────────────────

function ProductCard({ product }: { product: Product }) {
  const priceRange = getPriceRange(product)
  const fabrics    = getFabrics(product)
  const sizes      = getSizes(product)

  return (
    <article className={styles.card}>
      <div className={styles.cardImageWrap}>
        <Image
          src={product.main_image}
          alt={product.title}
          fill
          sizes="(max-width:640px) 100vw, (max-width:1024px) 50vw, 33vw"
          className={styles.cardImage}
          unoptimized
        />
        {product.category && (
          <span className={styles.categoryBadge}>{product.category}</span>
        )}
        {(product.gallery ?? []).length > 0 && (
          <div className={styles.galleryDots}>
            {[product.main_image, ...(product.gallery ?? [])].slice(0, 5).map((_, i) => (
              <span key={i} className={`${styles.dot} ${i === 0 ? styles.dotActive : ''}`} />
            ))}
          </div>
        )}
      </div>

      <div className={styles.cardBody}>
        <h2 className={styles.cardTitle}>{product.title}</h2>

        {product.description && (
          <p className={styles.cardDescription}>
            {product.description.slice(0, 110)}{product.description.length > 110 ? '…' : ''}
          </p>
        )}

        {fabrics.length > 0 && (
          <div className={styles.tagRow}>
            <span className={styles.tagLabel}>Telas:</span>
            {fabrics.map(f => <span key={f} className={styles.tag}>{f}</span>)}
          </div>
        )}

        {sizes.length > 0 && (
          <div className={styles.tagRow}>
            <span className={styles.tagLabel}>Medidas:</span>
            {sizes.map(s => <span key={s} className={`${styles.tag} ${styles.tagSize}`}>{s}</span>)}
          </div>
        )}

        <div className={styles.cardFooter}>
          <span className={styles.price}>{priceRange}</span>
          <button className={styles.ctaBtn}>
            Ver producto
            <span className="material-symbols-outlined">arrow_forward</span>
          </button>
        </div>
      </div>
    </article>
  )
}

// ─── Product grid ─────────────────────────────────────────────────────────────

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

      {/* ── Products ── */}
      <section className={styles.productsSection}>
        <div className={styles.container}>
          <Suspense fallback={<ProductsSkeleton />}>
            <ProductGrid search={search} />
          </Suspense>
        </div>
      </section>
    </main>
  )
}

// ─── Loading skeleton ─────────────────────────────────────────────────────────

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
