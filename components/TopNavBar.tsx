import React from 'react';

export default function TopNavBar() {
  return (
    <nav className="bg-white/90 backdrop-blur-md docked full-width top-0 sticky z-50 border-b border-slate-100 shadow-[0_4px_20px_-4px_rgba(22,109,146,0.06)]">
      <div className="flex justify-between items-center w-full px-8 md:px-16 lg:px-24 py-4 max-w-7xl mx-auto">
        <div className="flex items-center gap-12">
          <a className="text-xl font-black tracking-tighter text-slate-900 flex items-center gap-2" href="#">
            <span className="material-symbols-outlined text-cyan-500" data-icon="waves">waves</span>
            Lavitex del Caribe
          </a>
          <div className="hidden md:flex items-center gap-8">
            {/* Active Link */}
            <a className="font-sans tracking-tight text-sm font-medium uppercase text-cyan-500 border-b-2 border-cyan-500 pb-1 hover:bg-slate-50 transition-all duration-300 opacity-80 transition-opacity" href="#">
              Home
            </a>
            {/* Inactive Links */}
            <a className="font-sans tracking-tight text-sm font-medium uppercase text-slate-500 hover:text-cyan-500 transition-colors hover:bg-slate-50 transition-all duration-300" href="#">
              Catalog
            </a>
            <a className="font-sans tracking-tight text-sm font-medium uppercase text-slate-500 hover:text-cyan-500 transition-colors hover:bg-slate-50 transition-all duration-300" href="#">
              About
            </a>
            <a className="font-sans tracking-tight text-sm font-medium uppercase text-slate-500 hover:text-cyan-500 transition-colors hover:bg-slate-50 transition-all duration-300" href="#">
              Contact
            </a>
          </div>
        </div>
        <div className="flex items-center gap-6">
          {/* Search on right */}
          <div className="hidden lg:flex items-center bg-surface-container-low rounded-full px-4 py-2 border-b-2 border-transparent focus-within:border-primary-container transition-all">
            <span className="material-symbols-outlined text-outline mr-2 text-[20px]" data-icon="search">search</span>
            <input className="bg-transparent border-none outline-none focus:ring-0 text-sm w-48 text-on-surface" placeholder="Search..." type="text"/>
          </div>
          <a className="font-sans tracking-tight text-sm font-medium uppercase text-cyan-500 border border-cyan-500 rounded-DEFAULT px-6 py-2 hover:bg-slate-50 transition-all duration-300" href="#">
            Admin Login
          </a>
        </div>
      </div>
    </nav>
  );
}
