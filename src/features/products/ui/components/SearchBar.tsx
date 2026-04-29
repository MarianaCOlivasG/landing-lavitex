"use client";
import { useSearchParams } from 'next/navigation';
import Link from 'next/link';
import styles from './productos.module.css';

export default function SearchBar() {
  const searchParams = useSearchParams();
  const defaultValue = searchParams.get('query') ?? '';

  return (
    <form action="/productos" method="GET" className={styles.searchForm}>
      <div className={styles.searchInputWrap}>
        <span className={`material-symbols-outlined ${styles.searchIcon}`}>search</span>
        <input
          type="text"
          name="query"
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
  );
}
