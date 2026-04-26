import React from 'react';

export default function WhoWeAreSection() {
  return (
    <section className="w-full py-section-gap bg-surface-container-lowest">
      <div className="max-w-container-max mx-auto px-gutter md:px-16 lg:px-24 grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
        <div className="flex flex-col space-y-8">
          <div>
            <span className="font-label-caps text-label-caps text-secondary uppercase tracking-[0.2em] mb-4 block">Who We Are</span>
            <h2 className="font-headline-md text-headline-md text-on-surface">The Fabric of Professional Hospitality</h2>
          </div>
          <div className="w-16 h-1 bg-primary-container"></div>
          <p className="font-body-lg text-body-lg text-on-surface-variant">
            Lavitex del Caribe bridges the critical gap between high-scale industrial manufacturing and the tactile luxury demanded by premium hospitality brands. Our facilities operate with exacting precision, ensuring every thread meets rigorous commercial durability standards without compromising the breathable comfort of fine cotton and linen.
          </p>
          <p className="font-body-lg text-body-lg text-on-surface-variant">
            We believe in an aesthetic that is &quot;pressed and folded&quot;—where organization, cleanliness, and enduring quality are woven into every product. From high-thread-count beddings designed for repeated laundering to resilient banquet textiles, our solutions are engineered for decision-makers who cannot afford compromise.
          </p>
          <div className="pt-4">
            <a className="font-headline-sm text-headline-sm text-primary flex items-center gap-2 hover:text-primary-container transition-colors" href="#">
              Discover Our Process
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
