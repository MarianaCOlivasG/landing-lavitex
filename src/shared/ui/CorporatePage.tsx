import type { ReactNode } from 'react';
import Link from 'next/link';
import TopNavBar from '@/shared/ui/TopNavBar';
import Footer from '@/shared/ui/Footer';

export type CorporateSection = {
  id: string;
  title: string;
  content: ReactNode;
};

type CorporatePageProps = {
  eyebrow: string;
  title: string;
  introduction: string;
  icon: string;
  updatedAt: string;
  sections: CorporateSection[];
  asideTitle?: string;
  asideText?: string;
};

export default function CorporatePage({
  eyebrow,
  title,
  introduction,
  icon,
  updatedAt,
  sections,
  asideTitle = '¿Necesitas más información?',
  asideText = 'Nuestro equipo está disponible para resolver tus dudas y orientarte de manera personal.',
}: CorporatePageProps) {
  return (
    <>
      <TopNavBar />
      <main className="flex-1 bg-[#F8FAFB]">
        <header className="relative isolate overflow-hidden border-b border-slate-200 bg-white">
          <div className="absolute inset-y-0 right-0 -z-10 w-1/2 bg-[radial-gradient(circle_at_center,_rgba(16,178,204,0.12),_transparent_68%)]" />
          <div className="absolute -right-20 -top-24 -z-10 h-72 w-72 rounded-full border-[48px] border-[#10B2CC]/5" />
          <div className="max-w-7xl mx-auto px-6 md:px-16 lg:px-24 py-20 md:py-28">
            <nav aria-label="Ruta de navegación" className="mb-10 flex items-center gap-2 text-sm text-slate-500">
              <Link href="/" className="transition-colors hover:text-[#10B2CC]">Inicio</Link>
              <span className="material-symbols-outlined text-base text-slate-300" aria-hidden="true">chevron_right</span>
              <span className="text-slate-700">Corporativo</span>
            </nav>
            <div className="max-w-3xl">
              <div className="mb-6 flex items-center gap-3">
                <span className="flex h-11 w-11 items-center justify-center rounded-xl bg-[#10B2CC]/10 text-[#166D92]">
                  <span className="material-symbols-outlined" aria-hidden="true">{icon}</span>
                </span>
                <span className="text-xs font-bold uppercase tracking-[0.22em] text-[#166D92]">{eyebrow}</span>
              </div>
              <h1 className="text-4xl font-semibold tracking-tight text-slate-900 md:text-5xl lg:text-[56px] lg:leading-[1.08]">
                {title}
              </h1>
              <p className="mt-7 max-w-2xl text-lg leading-8 text-slate-600">{introduction}</p>
              <p className="mt-6 text-sm font-medium text-slate-400">Última actualización: {updatedAt}</p>
            </div>
          </div>
        </header>

        <div className="max-w-7xl mx-auto px-6 md:px-16 lg:px-24 py-16 md:py-20">
          <div className="grid grid-cols-1 gap-12 lg:grid-cols-[260px_minmax(0,1fr)] lg:gap-16">
            <aside className="lg:sticky lg:top-28 lg:self-start">
              <p className="mb-5 text-xs font-bold uppercase tracking-[0.18em] text-slate-400">En esta página</p>
              <nav aria-label={`Contenido de ${title}`} className="border-l border-slate-200">
                {sections.map((section, index) => (
                  <a
                    key={section.id}
                    href={`#${section.id}`}
                    className="group flex gap-3 border-l-2 border-transparent py-2.5 pl-4 text-sm leading-5 text-slate-500 transition-colors hover:border-[#10B2CC] hover:text-[#166D92]"
                  >
                    <span className="text-slate-300 group-hover:text-[#10B2CC]">{String(index + 1).padStart(2, '0')}</span>
                    <span>{section.title}</span>
                  </a>
                ))}
              </nav>
            </aside>

            <article className="min-w-0 rounded-2xl border border-slate-200/80 bg-white px-6 py-4 shadow-[0_18px_55px_rgba(22,109,146,0.06)] sm:px-10 md:px-14">
              {sections.map((section, index) => (
                <section
                  key={section.id}
                  id={section.id}
                  className={`scroll-mt-28 py-10 md:py-12 ${index !== sections.length - 1 ? 'border-b border-slate-100' : ''}`}
                >
                  <div className="mb-6 flex items-start gap-4">
                    <span className="mt-1 text-sm font-semibold text-[#10B2CC]">{String(index + 1).padStart(2, '0')}</span>
                    <h2 className="text-2xl font-semibold tracking-tight text-slate-900 md:text-[28px]">{section.title}</h2>
                  </div>
                  <div className="corporate-copy pl-0 md:pl-10">{section.content}</div>
                </section>
              ))}
            </article>
          </div>

          <section className="mt-16 overflow-hidden rounded-2xl bg-[#123F53] px-7 py-10 text-white md:flex md:items-center md:justify-between md:px-12">
            <div className="max-w-2xl">
              <p className="text-xs font-bold uppercase tracking-[0.2em] text-[#7DD5E8]">Atención personalizada</p>
              <h2 className="mt-3 text-2xl font-semibold">{asideTitle}</h2>
              <p className="mt-3 leading-7 text-slate-200">{asideText}</p>
            </div>
            <Link
              href="/#contact"
              className="mt-7 inline-flex items-center gap-2 rounded-xl bg-[#10B2CC] px-6 py-3.5 font-semibold text-white transition-all hover:-translate-y-0.5 hover:bg-[#17bfd9] md:mt-0 md:ml-10"
            >
              Contactar a Lavitex
              <span className="material-symbols-outlined text-xl" aria-hidden="true">arrow_forward</span>
            </Link>
          </section>
        </div>
      </main>
      <Footer />
    </>
  );
}
