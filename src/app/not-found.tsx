import React from 'react';
import Link from 'next/link';
import TopNavBar from '@/shared/ui/TopNavBar';
import Footer from '@/shared/ui/Footer';

export default function NotFound() {
  return (
    <>
      <TopNavBar />
      <main className="min-h-screen flex items-center justify-center pt-20 bg-gradient-to-b from-white to-slate-50 relative overflow-hidden">
        {/* Decorative elements */}
        <div className="absolute top-1/4 -left-20 w-80 h-80 bg-primary/5 rounded-full blur-3xl animate-pulse" />
        <div className="absolute bottom-1/4 -right-20 w-96 h-96 bg-primary-dark/5 rounded-full blur-3xl animate-pulse delay-700" />
        
        <div className="max-w-container-max mx-auto px-gutter text-center relative z-10">
          <div className="mb-8">
            <span className="text-[120px] md:text-[180px] font-black leading-none bg-gradient-to-r from-primary via-primary-dark to-primary bg-clip-text text-transparent select-none opacity-20">
              404
            </span>
          </div>
          
          <h1 className="font-display-lg text-display-lg text-on-surface mb-6 font-bold">
            Página no encontrada
          </h1>
          
          <p className="font-body-lg text-body-lg text-on-surface-variant max-w-xl mx-auto mb-12">
            Lo sentimos, el recurso que buscas no existe o ha sido movido. 
            Te invitamos a seguir explorando nuestra colección de blancos premium.
          </p>
          
          <div className="flex flex-col sm:flex-row gap-6 justify-center items-center">
            <Link 
              href="/" 
              className="btn-primary px-8 py-4 rounded-DEFAULT font-headline-sm text-headline-sm shadow-lg hover:shadow-xl transition-all"
            >
              Volver al Inicio
            </Link>
            
            <Link 
              href="/productos" 
              className="px-8 py-4 rounded-DEFAULT border border-primary text-primary font-headline-sm text-headline-sm hover:bg-primary/5 transition-all flex items-center gap-2"
            >
              Ver Catálogo
              <span className="material-symbols-outlined text-[20px]">arrow_forward</span>
            </Link>
          </div>
          
          {/* Subtle textile-like pattern overlay */}
          <div className="mt-20 opacity-30">
            <div className="flex justify-center gap-4">
              <div className="w-1 h-20 bg-slate-200 rounded-full" />
              <div className="w-1 h-32 bg-slate-200 rounded-full" />
              <div className="w-1 h-24 bg-slate-200 rounded-full" />
              <div className="w-1 h-16 bg-slate-200 rounded-full" />
              <div className="w-1 h-28 bg-slate-200 rounded-full" />
            </div>
          </div>
        </div>
      </main>
      <Footer />
    </>
  );
}
