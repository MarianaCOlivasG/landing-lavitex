import React from 'react';

export default function Footer() {
  return (
    <footer className="bg-slate-200 full-width py-12 flex flex-col md:flex-row justify-between items-center gap-6 w-full px-8 md:px-16 lg:px-24">
      <div className="font-sans text-xs uppercase tracking-widest text-slate-500">
        © 2024 Lavitex del Caribe. Excelencia Industrial.
      </div>
      <div className="flex flex-wrap items-center gap-6">
        <a className="font-sans text-xs uppercase tracking-widest text-slate-500 hover:text-slate-900 hover:underline decoration-slate-900 underline-offset-4 ease-in-out transition-all duration-200" href="#">
          Sustentabilidad
        </a>
        <a className="font-sans text-xs uppercase tracking-widest text-slate-500 hover:text-slate-900 hover:underline decoration-slate-900 underline-offset-4 ease-in-out transition-all duration-200" href="#">
          Especificaciones Técnicas
        </a>
        <a className="font-sans text-xs uppercase tracking-widest text-slate-500 hover:text-slate-900 hover:underline decoration-slate-900 underline-offset-4 ease-in-out transition-all duration-200" href="#">
          Aviso de Privacidad
        </a>
        <a className="font-sans text-xs uppercase tracking-widest text-slate-500 hover:text-slate-900 hover:underline decoration-slate-900 underline-offset-4 ease-in-out transition-all duration-200" href="#">
          Términos de Servicio
        </a>
      </div>
    </footer>
  );
}
