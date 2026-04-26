import React from 'react';

export default function HeroSection() {
  return (
    <header id="home" className="relative w-full h-[870px] flex items-center justify-center overflow-hidden bg-on-surface">
      <div className="absolute inset-0 z-0">
        <img 
          alt="High-scale industrial textile manufacturing facility with pristine white linens on automated rollers, dramatic warehouse lighting, premium and clean aesthetic" 
          className="w-full h-full object-cover opacity-30" 
          data-alt="High-scale industrial textile manufacturing facility with pristine white linens on automated rollers, dramatic warehouse lighting, premium and clean aesthetic" 
          src="https://lh3.googleusercontent.com/aida-public/AB6AXuArzZs1nnMeCA2ipvboTa3P7OmRz_uOlBSICcRNgvtYun2JNwqotGtrn3wJVFF_xa85m-yDvmp_-UxFjatP7_SUNY_GYspCUoaTBe_SpzgisIuNxlKxjKN5Ah9IXrNBo1OkJQCpwEDRwjk6Dy_4MqubbGtEfrvD7X-qZv0C1PW9-4U1ywqD1U21qUY7LR2hTaezQaUSUEI8JMHNq6JW80CMNJ4J4gweYcyCqGyXetOEa29_5dtrRNbM-K7MoGFA9X7gzfhXz8GEDVFT"
        />
        <div className="absolute inset-0 bg-gradient-to-t from-on-surface via-transparent to-transparent opacity-80"></div>
      </div>
      <div className="relative z-10 max-w-container-max mx-auto px-gutter md:px-16 lg:px-24 text-center flex flex-col items-center">
        <span className="font-label-caps text-label-caps text-primary-fixed tracking-[0.2em] mb-6 uppercase">Excelencia Industrial</span>
        <h1 className="font-display-lg text-display-lg text-on-primary mb-8 max-w-4xl text-balance">
          Tejido de Precisión para Durabilidad Comercial
        </h1>
        <p className="font-body-lg text-body-lg text-surface-container-highest max-w-2xl mb-12">
          Ofreciendo lencería de lujo táctil y de alto rendimiento diseñada específicamente para el sector hotelero y comercial en todo el Caribe.
        </p>
        <div className="flex flex-col sm:flex-row gap-6">
          <button className="bg-primary-container text-on-primary px-8 py-4 rounded-DEFAULT font-headline-sm text-headline-sm hover:bg-primary transition-colors duration-300 flex items-center gap-2">
            Explorar Catálogo
            <span className="material-symbols-outlined text-[20px]" data-icon="arrow_forward">arrow_forward</span>
          </button>
          <button className="bg-transparent border border-surface-container-highest text-surface-container-highest px-8 py-4 rounded-DEFAULT font-headline-sm text-headline-sm hover:bg-white/10 transition-colors duration-300">
            Especificaciones Técnicas
          </button>
        </div>
      </div>
    </header>
  );
}
