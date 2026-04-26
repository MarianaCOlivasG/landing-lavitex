import React from 'react';
import Link from 'next/link';

export default function Footer() {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="bg-slate-200 w-full py-16 px-gutter md:px-16 lg:px-24">
      <div className="max-w-7xl mx-auto">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-12 md:gap-24 mb-16">
          {/* Column 1: Logo & Branding */}
          <div className="flex flex-col space-y-6">
            <p className="text-slate-500 text-sm leading-relaxed max-w-xs">
              Líderes en fabricación y recuperación de blancos institucionales para el sector hotelero en el Caribe Mexicano.
            </p>
          </div>

          {/* Column 2: Legal & Sustainability */}
          <div className="flex flex-col space-y-6">
            <h4 className="font-headline-sm text-sm uppercase tracking-widest text-slate-900">Corporativo</h4>
            <nav className="flex flex-col space-y-4">
              <a className="text-slate-500 text-sm hover:text-cyan-600 transition-colors" href="#">Sustentabilidad</a>
              <a className="text-slate-500 text-sm hover:text-cyan-600 transition-colors" href="#">Aviso de Privacidad</a>
              <a className="text-slate-500 text-sm hover:text-cyan-600 transition-colors" href="#">Términos de Servicio</a>
              <a className="text-slate-500 text-sm hover:text-cyan-600 transition-colors" href="#">Políticas de Calidad</a>
            </nav>
          </div>

          {/* Column 3: Site Navigation */}
          <div className="flex flex-col space-y-6">
            <h4 className="font-headline-sm text-sm uppercase tracking-widest text-slate-900">Navegación</h4>
            <nav className="flex flex-col space-y-4">
              <Link className="text-slate-500 text-sm hover:text-cyan-600 transition-colors" href="#home">Inicio</Link>
              <Link className="text-slate-500 text-sm hover:text-cyan-600 transition-colors" href="#catalog">Catálogo de Productos</Link>
              <Link className="text-slate-500 text-sm hover:text-cyan-600 transition-colors" href="#about">Nuestra Empresa</Link>
              <Link className="text-slate-500 text-sm hover:text-cyan-600 transition-colors" href="#contact">Contacto</Link>
            </nav>
          </div>
        </div>

        {/* Bottom Bar: Copyright */}
        <div className="pt-8 border-t border-slate-300 flex flex-col md:flex-row justify-between items-center gap-4">
          <p className="text-slate-400 text-xs uppercase tracking-widest">
            © {currentYear} Lavitex del Caribe. Todos los derechos reservados.
          </p>
        </div>
      </div>
    </footer>
  );
}
