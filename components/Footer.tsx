import React from 'react';

export default function Footer() {
  return (
    <footer className="bg-white full-width py-12 border-t mt-20 border-slate-100 flat max-w-7xl mx-auto px-8 md:px-16 lg:px-24 flex flex-col md:flex-row justify-between items-center gap-6 w-full">
      <div className="font-sans text-xs uppercase tracking-widest text-slate-400">
        © 2024 Lavitex del Caribe. Excelencia Industrial.
      </div>
      <div className="flex flex-wrap items-center gap-6">
        <a className="font-sans text-xs uppercase tracking-widest text-slate-400 hover:text-cyan-500 hover:underline decoration-cyan-500 underline-offset-4 ease-in-out transition-all duration-200" href="#">
          Sustentabilidad
        </a>
        <a className="font-sans text-xs uppercase tracking-widest text-slate-400 hover:text-cyan-500 hover:underline decoration-cyan-500 underline-offset-4 ease-in-out transition-all duration-200" href="#">
          Especificaciones Técnicas
        </a>
        <a className="font-sans text-xs uppercase tracking-widest text-slate-400 hover:text-cyan-500 hover:underline decoration-cyan-500 underline-offset-4 ease-in-out transition-all duration-200" href="#">
          Aviso de Privacidad
        </a>
        <a className="font-sans text-xs uppercase tracking-widest text-slate-400 hover:text-cyan-500 hover:underline decoration-cyan-500 underline-offset-4 ease-in-out transition-all duration-200" href="#">
          Términos de Servicio
        </a>
      </div>
    </footer>
  );
}
