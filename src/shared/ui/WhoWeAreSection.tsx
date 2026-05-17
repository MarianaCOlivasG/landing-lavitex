import React from 'react';

export default function WhoWeAreSection() {
  return (
    <section id="about" className="w-full py-section-gap bg-gradient-to-b from-white to-slate-50">
      <div className="max-w-container-max mx-auto px-gutter md:px-16 lg:px-24 grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
        <div className="flex flex-col space-y-8">
          <div>
            <span className="font-label-caps text-label-caps text-secondary uppercase tracking-[0.2em] mb-4 block">Quiénes Somos</span>
            <h2 className="font-headline-md text-headline-md text-on-surface">Fabricantes y Expertos en Textiles</h2>
          </div>
          <div className="w-16 h-1 bg-primary-container"></div>
          <p className="font-body-lg text-body-lg text-on-surface-variant">
            Lavitex del Caribe es tu aliado estratégico en la industria hotelera y comercial. Nos especializamos en la fabricación a la medida y recuperación de blancos, garantizando siempre la máxima calidad y durabilidad en cada uno de nuestros productos reduciendo tiempos y costos de entrega.
          </p>
          <p className="font-body-lg text-body-lg text-on-surface-variant">
            Además de la lencería institucional, ofrecemos una amplia gama de artículos promocionales, servicios de serigrafía y soluciones de decoración textil. Todo orgullosamente hecho en Quintana Roo y hecho en México, manteniendo los estándares más exigentes del mercado.
          </p>
          <div className="pt-4">
            <a className="font-headline-sm text-headline-sm text-primary flex items-center gap-2 hover:text-primary-container transition-colors" href="#">
              Descubre Nuestro Proceso
              <span className="material-symbols-outlined" data-icon="east">east</span>
            </a>
          </div>
        </div>
        <div className="relative h-[600px] w-full rounded-DEFAULT overflow-hidden group shadow-lg border border-white/20">
          <img
            alt="Quiénes Somos - Lavitex del Caribe"
            className="w-full h-full object-cover grayscale-[20%] group-hover:grayscale-0 transition-all duration-700 transform group-hover:scale-105"
            data-alt="Quiénes Somos - Lavitex del Caribe"
            src="/images/quienes_somos.png"
          />
        </div>
      </div>
    </section>
  );
}
