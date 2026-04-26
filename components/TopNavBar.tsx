"use client";

import React, { useState, useEffect } from 'react';
import Link from 'next/link';

export default function TopNavBar() {
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [activeSection, setActiveSection] = useState('home');

  useEffect(() => {
    const sectionIds = ['home', 'catalog', 'about', 'contact'];
    
    const handleIntersect = (entries: IntersectionObserverEntry[]) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          setActiveSection(entry.target.id);
        }
      });
    };

    const observerOptions = {
      rootMargin: '-20% 0px -70% 0px',
      threshold: 0,
    };

    const observer = new IntersectionObserver(handleIntersect, observerOptions);

    sectionIds.forEach((id) => {
      const element = document.getElementById(id);
      if (element) observer.observe(element);
    });

    return () => observer.disconnect();
  }, []);

  const navLinkClass = (sectionId: string) => {
    const isActive = activeSection === sectionId;
    return `font-sans tracking-tight text-sm font-medium uppercase transition-all duration-300 ${
      isActive 
        ? 'text-[#10B2CC] border-b-2 border-[#10B2CC] pb-1 opacity-100' 
        : 'text-slate-500 hover:text-[#10B2CC] opacity-80'
    }`;
  };

  return (
    <>
      <nav className="bg-white full-width top-0 sticky z-50 border-b border-slate-100 shadow-[0_4px_20px_-4px_rgba(22,109,146,0.06)]">
        <div className="flex justify-between items-center w-full px-6 md:px-16 lg:px-24 py-4 max-w-7xl mx-auto">
          {/* Left: Logo */}
          <div className="flex items-center w-auto md:w-1/3">
            <Link className="flex items-center" href="/">
              <img src="/images/logo.png" alt="Lavitex del Caribe Logo" className="h-12 w-auto object-contain" />
            </Link>
          </div>

          {/* Center: Links (Desktop) */}
          <div className="hidden md:flex items-center justify-center gap-8 w-1/3">
            <Link className={navLinkClass('home')} href="/">
              Inicio
            </Link>
            <Link className={navLinkClass('about')} href="/#about">
              Nosotros
            </Link>
            <Link className={navLinkClass('catalog')} href="/#catalog">
              Catálogo
            </Link>
            <Link className={navLinkClass('contact')} href="/#contact">
              Contacto
            </Link>
          </div>

          {/* Right: Social Media & Mobile Toggle */}
          <div className="flex justify-end items-center gap-6 w-auto md:w-1/3">
            <div className="hidden sm:flex items-center gap-6">
              <a href="https://www.facebook.com/Lavitexdelcaribe/" target="_blank" rel="noopener noreferrer" className="text-slate-400 hover:text-[#10B2CC] transition-colors" aria-label="Facebook">
                <svg className="w-7 h-7" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                  <path fillRule="evenodd" d="M22 12c0-5.523-4.477-10-10-10S2 6.477 2 12c0 4.991 3.657 9.128 8.438 9.878v-6.987h-2.54V12h2.54V9.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V12h2.773l-.443 2.89h-2.33v6.988C18.343 21.128 22 16.991 22 12z" clipRule="evenodd" />
                </svg>
              </a>
              <a href="https://www.instagram.com/lavitexdelcaribe/" target="_blank" rel="noopener noreferrer" className="text-slate-400 hover:text-[#10B2CC] transition-colors" aria-label="Instagram">
                <svg className="w-7 h-7" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                  <path fillRule="evenodd" d="M12.315 2c2.43 0 2.784.013 3.808.06 1.064.049 1.791.218 2.427.465a4.902 4.902 0 011.772 1.153 4.902 4.902 0 011.153 1.772c.247.636.416 1.363.465 2.427.048 1.067.06 1.407.06 4.123v.08c0 2.643-.012 2.987-.06 4.043-.049 1.064-.218 1.791-.465 2.427a4.902 4.902 0 01-1.153 1.772 4.902 4.902 0 01-1.772 1.153c-.636.247-1.363.416-2.427.465-1.067.048-1.407.06-4.123.06h-.08c-2.643 0-2.987-.012-4.043-.06-1.064-.049-1.791-.218-2.427-.465a4.902 4.902 0 01-1.772-1.153 4.902 4.902 0 01-1.153-1.772c-.247-.636-.416-1.363-.465-2.427-.047-1.024-.06-1.379-.06-3.808v-.63c0-2.43.013-2.784.06-3.808.049-1.064.218-1.791.465-2.427a4.902 4.902 0 011.153-1.772A4.902 4.902 0 015.476 2.525c.636-.247 1.363-.416 2.427-.465C8.901 2.013 9.256 2 11.685 2h.63zm-.081 1.802h-.468c-2.456 0-2.784.011-3.807.058-.975.045-1.504.207-1.857.344-.467.182-.8.398-1.15.748-.35.35-.566.683-.748 1.15-.137.353-.3.882-.344 1.857-.047 1.023-.058 1.351-.058 3.807v.468c0 2.456.011 2.784.058 3.807.045.975.207 1.504.344 1.857.182.466.399.8.748 1.15.35.35.683.566 1.15.748.353.137.882.3 1.857.344 1.054.048 1.37.058 4.041.058h.08c2.597 0 2.917-.01 3.96-.058.976-.045 1.505-.207 1.858-.344.466-.182.8-.398 1.15-.748.35-.35.566-.683.748-1.15.137-.353.3-.882.344-1.857.048-1.055.058-1.37.058-4.041v-.08c0-2.597-.01-2.917-.058-3.96-.045-.976-.207-1.505-.344-1.858a3.097 3.097 0 00-.748-1.15 3.098 3.098 0 00-1.15-.748c-.353-.137-.882-.3-1.857-.344-1.023-.047-1.351-.058-3.807-.058zM12 6.865a5.135 5.135 0 110 10.27 5.135 5.135 0 010-10.27zm0 1.802a3.333 3.333 0 100 6.666 3.333 3.333 0 000-6.666zm5.338-3.205a1.2 1.2 0 110 2.4 1.2 1.2 0 010-2.4z" clipRule="evenodd" />
                </svg>
              </a>
            </div>
            
            <button 
              className="md:hidden p-2 text-slate-500 hover:text-[#10B2CC] focus:outline-none"
              onClick={() => setIsMobileMenuOpen(true)}
              aria-label="Abrir menú"
            >
              <span className="material-symbols-outlined" data-icon="menu">menu</span>
            </button>
          </div>
        </div>
      </nav>

      {/* Mobile Menu Backdrop */}
      {isMobileMenuOpen && (
        <div 
          className="fixed inset-0 bg-black/20 z-[60] transition-opacity md:hidden"
          onClick={() => setIsMobileMenuOpen(false)}
          aria-hidden="true"
        />
      )}

      {/* Mobile Menu Sidebar */}
      <div 
        className={`fixed top-0 right-0 h-full w-64 bg-white z-[70] shadow-2xl transform transition-transform duration-300 ease-in-out md:hidden ${
          isMobileMenuOpen ? 'translate-x-0' : 'translate-x-full'
        }`}
      >
        <div className="p-6 flex flex-col h-full">
          <div className="flex justify-end mb-8">
            <button 
              className="p-2 text-slate-500 hover:text-[#10B2CC] focus:outline-none"
              onClick={() => setIsMobileMenuOpen(false)}
              aria-label="Cerrar menú"
            >
              <span className="material-symbols-outlined text-[28px]" data-icon="close">close</span>
            </button>
          </div>
          <div className="flex flex-col gap-6">
            <Link onClick={() => setIsMobileMenuOpen(false)} className={`font-sans tracking-tight text-lg font-medium uppercase transition-colors ${activeSection === 'home' ? 'text-[#166D92]' : 'text-slate-800 hover:text-[#10B2CC]'}`} href="/#home">
              Inicio
            </Link>
            <Link onClick={() => setIsMobileMenuOpen(false)} className={`font-sans tracking-tight text-lg font-medium uppercase transition-colors ${activeSection === 'about' ? 'text-[#166D92]' : 'text-slate-800 hover:text-[#10B2CC]'}`} href="/#about">
              Nosotros
            </Link>
            <Link onClick={() => setIsMobileMenuOpen(false)} className={`font-sans tracking-tight text-lg font-medium uppercase transition-colors ${activeSection === 'catalog' ? 'text-[#166D92]' : 'text-slate-800 hover:text-[#10B2CC]'}`} href="/#catalog">
              Catálogo
            </Link>
            <Link onClick={() => setIsMobileMenuOpen(false)} className={`font-sans tracking-tight text-lg font-medium uppercase transition-colors ${activeSection === 'contact' ? 'text-[#166D92]' : 'text-slate-800 hover:text-[#10B2CC]'}`} href="/#contact">
              Contacto
            </Link>
            
            <div className="mt-8 pt-8 border-t border-slate-100 flex gap-6">
              <a href="https://www.facebook.com/Lavitexdelcaribe/" target="_blank" rel="noopener noreferrer" className="text-slate-400 hover:text-[#10B2CC] transition-colors" aria-label="Facebook">
                <svg className="w-8 h-8" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                  <path fillRule="evenodd" d="M22 12c0-5.523-4.477-10-10-10S2 6.477 2 12c0 4.991 3.657 9.128 8.438 9.878v-6.987h-2.54V12h2.54V9.797c0-2.506 1.492-3.89 3.777-3.89 1.094 0 2.238.195 2.238.195v2.46h-1.26c-1.243 0-1.63.771-1.63 1.562V12h2.773l-.443 2.89h-2.33v6.988C18.343 21.128 22 16.991 22 12z" clipRule="evenodd" />
                </svg>
              </a>
              <a href="https://www.instagram.com/lavitexdelcaribe/" target="_blank" rel="noopener noreferrer" className="text-slate-400 hover:text-[#10B2CC] transition-colors" aria-label="Instagram">
                <svg className="w-8 h-8" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                  <path fillRule="evenodd" d="M12.315 2c2.43 0 2.784.013 3.808.06 1.064.049 1.791.218 2.427.465a4.902 4.902 0 011.772 1.153 4.902 4.902 0 011.153 1.772c.247.636.416 1.363.465 2.427.048 1.067.06 1.407.06 4.123v.08c0 2.643-.012 2.987-.06 4.043-.049 1.064-.218 1.791-.465 2.427a4.902 4.902 0 01-1.153 1.772 4.902 4.902 0 01-1.772 1.153c-.636.247-1.363.416-2.427.465-1.067.048-1.407.06-4.123.06h-.08c-2.643 0-2.987-.012-4.043-.06-1.064-.049-1.791-.218-2.427-.465a4.902 4.902 0 01-1.772-1.153 4.902 4.902 0 01-1.153-1.772c-.247-.636-.416-1.363-.465-2.427-.047-1.024-.06-1.379-.06-3.808v-.63c0-2.43.013-2.784.06-3.808.049-1.064.218-1.791.465-2.427a4.902 4.902 0 011.153-1.772A4.902 4.902 0 015.476 2.525c.636-.247 1.363-.416 2.427-.465C8.901 2.013 9.256 2 11.685 2h.63zm-.081 1.802h-.468c-2.456 0-2.784.011-3.807.058-.975.045-1.504.207-1.857.344-.467.182-.8.398-1.15.748-.35.35-.566.683-.748 1.15-.137.353-.3.882-.344 1.857-.047 1.023-.058 1.351-.058 3.807v.468c0 2.456.011 2.784.058 3.807.045.975.207 1.504.344 1.857.182.466.399.8.748 1.15.35.35.683.566 1.15.748.353.137.882.3 1.857.344 1.054.048 1.37.058 4.041.058h.08c2.597 0 2.917-.01 3.96-.058.976-.045 1.505-.207 1.858-.344.466-.182.8-.398 1.15-.748.35-.35.566-.683.748-1.15.137-.353.3-.882.344-1.857.048-1.055.058-1.37.058-4.041v-.08c0-2.597-.01-2.917-.058-3.96-.045-.976-.207-1.505-.344-1.858a3.097 3.097 0 00-.748-1.15 3.098 3.098 0 00-1.15-.748c-.353-.137-.882-.3-1.857-.344-1.023-.047-1.351-.058-3.807-.058zM12 6.865a5.135 5.135 0 110 10.27 5.135 5.135 0 010-10.27zm0 1.802a3.333 3.333 0 100 6.666 3.333 3.333 0 000-6.666zm5.338-3.205a1.2 1.2 0 110 2.4 1.2 1.2 0 010-2.4z" clipRule="evenodd" />
                </svg>
              </a>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
