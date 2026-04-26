import React from 'react';

export default function WhoWeAreSection() {
  return (
    <section id="about" className="w-full py-section-gap bg-surface-container-lowest">
      <div className="max-w-container-max mx-auto px-gutter md:px-16 lg:px-24 grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
        <div className="flex flex-col space-y-8">
          <div>
            <span className="font-label-caps text-label-caps text-secondary uppercase tracking-[0.2em] mb-4 block">Quiénes Somos</span>
            <h2 className="font-headline-md text-headline-md text-on-surface">El Tejido de la Hospitalidad Profesional</h2>
          </div>
          <div className="w-16 h-1 bg-primary-container"></div>
          <p className="font-body-lg text-body-lg text-on-surface-variant">
            Lavitex del Caribe cierra la brecha crítica entre la fabricación industrial a gran escala y el lujo táctil que exigen las marcas de hospitalidad premium. Nuestras instalaciones operan con precisión exigente, asegurando que cada hilo cumpla con los rigurosos estándares de durabilidad comercial sin comprometer la comodidad y transpirabilidad del algodón y el lino finos.
          </p>
          <p className="font-body-lg text-body-lg text-on-surface-variant">
            Creemos en una estética de &quot;planchado y doblado&quot;, donde la organización, la limpieza y la calidad perdurable se entrelazan en cada producto. Desde ropa de cama de alto número de hilos diseñada para lavados repetidos hasta textiles resistentes para banquetes, nuestras soluciones están diseñadas para quienes no pueden permitirse comprometer la calidad.
          </p>
          <div className="pt-4">
            <a className="font-headline-sm text-headline-sm text-primary flex items-center gap-2 hover:text-primary-container transition-colors" href="#">
              Descubre Nuestro Proceso
              <span className="material-symbols-outlined" data-icon="east">east</span>
            </a>
          </div>
        </div>
        <div className="relative h-[600px] w-full rounded-DEFAULT overflow-hidden group">
          <div className="absolute inset-0 bg-secondary/10 group-hover:bg-transparent transition-colors duration-700 z-10"></div>
          <img 
            alt="Close-up of precise industrial textile weaving machinery working with pristine white cotton threads under bright, clean factory lighting" 
            className="w-full h-full object-cover grayscale-[20%] group-hover:grayscale-0 transition-all duration-700 transform group-hover:scale-105" 
            data-alt="Close-up of precise industrial textile weaving machinery working with pristine white cotton threads under bright, clean factory lighting" 
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuDGQDo7mAJ-K5EBUcTuY3BocFNhwMMha76qBH0lg56nNQ9Mv84GSn94l8FKFQQTfdhY1xjC4UVmVHHKqShh-Tf_zM6gjrEc4br04SsszM1FYk4RTOSHqsqZk_SqFpFiVtzCrVr3UILEFsnymIUhavFlRMVME4OtdRQYyq-no1GR4E_zcJn7yZTSg3rTdUcHGE7vV493zeXa9JiHcG5M0-1JEMOLLn0fCvikybdQGycaDW5i0_V2iXlOgIb94gjY8SqQEEZSjLrZRWae"
          />
        </div>
      </div>
    </section>
  );
}
