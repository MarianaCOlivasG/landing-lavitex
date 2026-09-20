import type { Metadata } from 'next';
import Link from 'next/link';
import Image from 'next/image';
import TopNavBar from '@/shared/ui/TopNavBar';
import Footer from '@/shared/ui/Footer';
import { createPageMetadata } from '@/lib/seo';

export const metadata: Metadata = createPageMetadata({
  title: 'Carta de Garantía',
  description: 'Consulta la cobertura, exclusiones y proceso de reposición de la garantía de productos Lavitex del Caribe.',
  path: '/carta-garantia',
});

const exclusions = [
  'Mal almacenamiento de las piezas.',
  'Exposición a humedad.',
  'Daños ocasionados por negligencia durante el manejo o cuidado del producto.',
  'Quemaduras en general, incluidas las provocadas por cigarro.',
  'Rasgaduras y manchas.',
];

export default function CartaGarantiaPage() {
  return (
    <>
      <TopNavBar />
      <main className="flex-1 bg-[#F8FAFB]">
        <header className="relative isolate overflow-hidden border-b border-slate-200 bg-white">
          <div className="absolute inset-y-0 right-0 -z-10 w-1/2 bg-[radial-gradient(circle_at_center,_rgba(16,178,204,0.13),_transparent_68%)]" />
          <div className="absolute -right-20 -top-24 -z-10 h-72 w-72 rounded-full border-[48px] border-[#10B2CC]/5" />
          <div className="mx-auto max-w-7xl px-6 py-20 md:px-16 md:py-24 lg:px-24">
            <nav aria-label="Ruta de navegación" className="mb-10 flex items-center gap-2 text-sm text-slate-500">
              <Link href="/" className="transition-colors hover:text-[#10B2CC]">Inicio</Link>
              <span className="material-symbols-outlined text-base text-slate-300" aria-hidden="true">chevron_right</span>
              <span className="text-slate-700">Carta de Garantía</span>
            </nav>

            <div className="grid items-end gap-10 lg:grid-cols-[minmax(0,1fr)_auto]">
              <div className="max-w-3xl">
                <div className="mb-6 flex items-center gap-3">
                  <span className="flex h-11 w-11 items-center justify-center rounded-xl bg-[#10B2CC]/10 text-[#166D92]">
                    <span className="material-symbols-outlined" aria-hidden="true">verified_user</span>
                  </span>
                  <span className="text-xs font-bold uppercase tracking-[0.22em] text-[#166D92]">Respaldo Lavitex</span>
                </div>
                <h1 className="text-4xl font-semibold tracking-tight text-slate-900 md:text-5xl lg:text-[56px] lg:leading-[1.08]">
                  Carta de Garantía
                </h1>
                <p className="mt-7 max-w-2xl text-lg leading-8 text-slate-600">
                  Nuestro compromiso es respaldar las piezas que presenten fallas de origen y brindar una atención clara para su revisión y reposición.
                </p>
              </div>

              <a
                href="/docs/Carta_Garantia.pdf"
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex w-fit items-center gap-3 rounded-xl bg-[#10B2CC] px-6 py-4 font-semibold text-white shadow-[0_12px_30px_rgba(16,178,204,0.22)] transition-all hover:-translate-y-0.5 hover:bg-[#166D92]"
                aria-label="Abrir la carta de garantía en PDF en una nueva pestaña"
              >
                <span className="material-symbols-outlined" aria-hidden="true">picture_as_pdf</span>
                Abrir carta en PDF
                <span className="material-symbols-outlined text-lg" aria-hidden="true">open_in_new</span>
              </a>
            </div>
          </div>
        </header>

        <div className="mx-auto max-w-7xl px-6 py-16 md:px-16 md:py-20 lg:px-24">
          <section className="overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-[0_22px_60px_rgba(22,109,146,0.08)]">
            <div className="grid lg:grid-cols-[0.84fr_1.16fr]">
              <div className="relative flex min-h-[380px] flex-col justify-between overflow-hidden bg-[#123F53] p-8 text-white md:p-12">
                <div className="absolute -right-24 -top-24 h-64 w-64 rounded-full border-[52px] border-white/5" aria-hidden="true" />
                <div className="relative">
                  <Image
                    src="/images/logo.png"
                    alt="Lavitex del Caribe"
                    width={934}
                    height={267}
                    className="h-auto w-56 brightness-0 invert"
                  />
                  <p className="mt-12 text-xs font-bold uppercase tracking-[0.22em] text-[#7DD5E8]">Nuestra misión</p>
                  <blockquote className="mt-4 text-2xl font-medium leading-9 tracking-tight md:text-[28px]">
                    “Conseguir la plena satisfacción de todos nuestros clientes.”
                  </blockquote>
                </div>
                <div className="relative mt-12 flex flex-wrap items-center gap-3 text-sm text-slate-300">
                  <span className="rounded-full border border-white/15 px-4 py-2">Hecho en Quintana Roo</span>
                  <span className="rounded-full border border-white/15 px-4 py-2">Hecho en México</span>
                </div>
              </div>

              <div className="p-8 md:p-12 lg:p-14">
                <span className="text-xs font-bold uppercase tracking-[0.2em] text-[#166D92]">Cobertura</span>
                <h2 className="mt-3 text-2xl font-semibold tracking-tight text-slate-900 md:text-3xl">
                  ¿Qué respalda esta garantía?
                </h2>
                <p className="mt-6 text-base leading-8 text-slate-600 md:text-lg">
                  Lavitex del Caribe, S.A. de C.V. respaldará las piezas que llegaran a presentar <strong className="font-semibold text-slate-900">fallas de origen en costuras o daño de origen en el tejido de la tela</strong>.
                </p>

                <div className="mt-9 rounded-2xl border border-[#10B2CC]/20 bg-[#10B2CC]/5 p-6">
                  <div className="flex items-start gap-4">
                    <span className="material-symbols-outlined mt-0.5 text-[#10B2CC]" aria-hidden="true">sync</span>
                    <div>
                      <h3 className="font-semibold text-slate-900">Reposición sin costo</h3>
                      <p className="mt-2 leading-7 text-slate-600">
                        Cuando la reposición sea requerida conforme a esta garantía, podrá realizarse directamente en la fábrica sin costo alguno.
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>

          <section className="mt-12 grid gap-8 lg:grid-cols-[minmax(0,1fr)_360px]">
            <div className="rounded-2xl border border-slate-200 bg-white p-8 md:p-10">
              <div className="flex items-center gap-4">
                <span className="flex h-11 w-11 shrink-0 items-center justify-center rounded-xl bg-amber-50 text-amber-700">
                  <span className="material-symbols-outlined" aria-hidden="true">info</span>
                </span>
                <div>
                  <span className="text-xs font-bold uppercase tracking-[0.18em] text-slate-400">Condiciones</span>
                  <h2 className="mt-1 text-2xl font-semibold text-slate-900">Casos no cubiertos</h2>
                </div>
              </div>
              <p className="mt-7 leading-7 text-slate-600">
                De acuerdo con la carta vigente, la garantía no tiene validez cuando la falla o el daño sean consecuencia de:
              </p>
              <ul className="mt-6 grid gap-4 sm:grid-cols-2">
                {exclusions.map((exclusion) => (
                  <li key={exclusion} className="flex items-start gap-3 rounded-xl bg-slate-50 p-4 text-sm leading-6 text-slate-600">
                    <span className="material-symbols-outlined mt-0.5 text-lg text-slate-400" aria-hidden="true">close</span>
                    <span>{exclusion}</span>
                  </li>
                ))}
              </ul>
            </div>

            <aside className="rounded-2xl border border-slate-200 bg-white p-8 md:p-10">
              <span className="material-symbols-outlined text-3xl text-[#10B2CC]" aria-hidden="true">factory</span>
              <h2 className="mt-5 text-2xl font-semibold text-slate-900">Atención en fábrica</h2>
              <p className="mt-4 leading-7 text-slate-600">
                Para solicitar orientación sobre una posible falla de origen, comunícate con nuestro equipo.
              </p>
              <address className="mt-7 not-italic text-sm leading-7 text-slate-600">
                <strong className="block text-slate-900">Lavitex del Caribe</strong>
                Av. Talleres, Mz. 55, Lote 15, SM. 90<br />
                Cancún, Quintana Roo, México<br />
                C.P. 77510
              </address>
              <a
                href="tel:+529988840223"
                className="mt-6 inline-flex items-center gap-2 font-semibold text-[#166D92] transition-colors hover:text-[#10B2CC]"
              >
                <span className="material-symbols-outlined text-xl" aria-hidden="true">call</span>
                998 884 0223
              </a>
            </aside>
          </section>

          <section className="mt-12 flex flex-col items-start justify-between gap-7 rounded-2xl bg-[#EDF4F6] px-8 py-10 md:flex-row md:items-center md:px-12">
            <div className="max-w-2xl">
              <p className="text-xs font-bold uppercase tracking-[0.2em] text-[#166D92]">Documento original</p>
              <h2 className="mt-3 text-2xl font-semibold text-slate-900">Consulta la carta emitida por Lavitex</h2>
              <p className="mt-3 leading-7 text-slate-600">El archivo se abrirá en una pestaña nueva para que puedas revisarlo, descargarlo o imprimirlo.</p>
            </div>
            <a
              href="/docs/Carta_Garantia.pdf"
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex shrink-0 items-center gap-2 rounded-xl border border-[#166D92] px-6 py-3.5 font-semibold text-[#166D92] transition-colors hover:bg-white"
            >
              Ver PDF original
              <span className="material-symbols-outlined text-lg" aria-hidden="true">open_in_new</span>
            </a>
          </section>
        </div>
      </main>
      <Footer />
    </>
  );
}
