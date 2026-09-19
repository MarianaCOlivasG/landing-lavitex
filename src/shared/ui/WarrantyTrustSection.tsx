import Link from 'next/link';

export default function WarrantyTrustSection() {
  return (
    <section aria-labelledby="warranty-title" className="w-full bg-white px-6 pb-12 md:px-16 lg:px-24">
      <div className="mx-auto max-w-7xl overflow-hidden rounded-2xl bg-[#123F53] shadow-[0_18px_45px_rgba(18,63,83,0.16)]">
        <div className="relative flex flex-col gap-7 px-7 py-8 md:flex-row md:items-center md:justify-between md:px-10 lg:px-12">
          <div className="absolute -right-16 -top-20 h-48 w-48 rounded-full border-[38px] border-white/5" aria-hidden="true" />

          <div className="relative flex max-w-3xl items-start gap-5">
            <span className="flex h-12 w-12 shrink-0 items-center justify-center rounded-xl bg-[#10B2CC] text-white shadow-lg shadow-[#10B2CC]/20">
              <span className="material-symbols-outlined" aria-hidden="true">verified_user</span>
            </span>
            <div>
              <p className="text-xs font-bold uppercase tracking-[0.2em] text-[#7DD5E8]">Garantía directa Lavitex</p>
              <h2 id="warranty-title" className="mt-2 text-2xl font-semibold tracking-tight text-white">
                Tu compra está respaldada
              </h2>
              <p className="mt-2 leading-7 text-slate-200">
                Conoce la cobertura por fallas de origen y nuestro proceso de reposición en fábrica.
              </p>
            </div>
          </div>

          <Link
            href="/carta-garantia"
            className="relative inline-flex w-fit shrink-0 items-center gap-2 rounded-xl bg-white px-6 py-3.5 font-semibold text-[#123F53] transition-all hover:-translate-y-0.5 hover:bg-[#EDF4F6] focus-visible:outline-2 focus-visible:outline-offset-4 focus-visible:outline-white"
          >
            Consultar garantía
            <span className="material-symbols-outlined text-xl" aria-hidden="true">arrow_forward</span>
          </Link>
        </div>
      </div>
    </section>
  );
}
