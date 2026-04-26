import React from 'react';

export default function CertificationsSection() {
  // Approximate CSS filter to achieve color #AAB8C9
  const logoFilter = "grayscale(100%) brightness(1.2) contrast(0.8) sepia(1) hue-rotate(180deg) saturate(0.5)";

  return (
    <section className="w-full py-12 bg-white border-b border-slate-50">
      <div className="max-w-container-max mx-auto px-gutter md:px-16 lg:px-24 text-center">
        <span className="font-label-caps text-label-caps text-slate-400 uppercase tracking-[0.2em] mb-3 block">
          Excelencia y Origen
        </span>
        <h2 className="font-headline-sm text-headline-sm text-slate-500 mb-10">
          HECHO EN QUINTANA ROO · HECHO EN MÉXICO
        </h2>

        <div className="flex flex-wrap justify-center items-center gap-12 md:gap-24 opacity-80">
          <img
            src="/images/hecho_quintanaroo.png"
            alt="Hecho en Quintana Roo"
            className="h-16 md:h-20 w-auto object-contain transition-all duration-500 hover:opacity-100"
          />
          <img
            src="/images/hecho_mexico.png"
            alt="Hecho en México"
            className="h-16 md:h-20 w-auto object-contain transition-all duration-500 hover:opacity-100"
          />
        </div>
      </div>
    </section>
  );
}
