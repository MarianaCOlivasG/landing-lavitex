import React from 'react';

export default function HeroSection() {
  return (
    <header id="home" className="relative w-full h-[870px] flex items-center justify-center overflow-hidden bg-slate-50">
      <div className="absolute inset-0 z-0">
        <img
          alt="Bright and clean white hotel linens"
          className="w-full h-full object-cover"
          src="/images/hero-bg.png"
        />
        <div className="absolute inset-0 bg-white/40"></div>
      </div>
      <div className="relative z-10 max-w-container-max mx-auto px-gutter md:px-16 lg:px-24 text-center flex flex-col items-center">
        <h1 className="font-display-lg text-display-lg text-slate-900 mb-8 max-w-4xl text-balance font-black">
          Fabricante de Blancos y Edredones a la Medida
        </h1>
        <p className="font-body-lg text-body-lg text-slate-700 max-w-2xl mb-12 text-lg">
          Expertos en recuperación y fabricación de blancos institucionales, artículos promocionales, serigrafía y decoración para tu hogar y el sector de la hospitalidad.
        </p>
        <div className="flex flex-col sm:flex-row gap-6">
          <a
            href="/docs/Catalogo-2026.pdf"
            target="_blank"
            rel="noopener noreferrer"
            className="btn-primary text-white px-8 py-4 rounded-DEFAULT font-headline-sm text-headline-sm hover:-translate-y-0.5 transition-all duration-300 flex items-center justify-center gap-2 shadow-md"
          >
            Explorar Catálogo
            <span className="material-symbols-outlined text-[20px]" data-icon="arrow_forward">arrow_forward</span>
          </a>
        </div>
      </div>
    </header>
  );
}
