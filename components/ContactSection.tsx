import React from 'react';

export default function ContactSection() {
  return (
    <section id="contact" className="w-full py-section-gap bg-gradient-to-b from-slate-100 to-slate-200 border-t border-slate-200">
      <div className="max-w-container-max mx-auto px-gutter md:px-16 lg:px-24 grid grid-cols-1 lg:grid-cols-2 gap-16">
        {/* Contact Form */}
        <div className="premium-card p-10">
          <div className="mb-8">
            <h2 className="font-headline-md text-headline-md text-slate-900 mb-2">Solicita una Consulta</h2>
            <p className="font-body-md text-body-md text-slate-600">Conecta con nuestros gerentes de cuenta comerciales para precios al por mayor y especificaciones técnicas.</p>
          </div>
          <form className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <label className="block font-label-caps text-label-caps text-slate-500 mb-2 uppercase">Nombre Completo</label>
                <input className="w-full border-0 border-b-2 border-slate-200 focus:border-[#10B2CC] focus:ring-0 px-0 py-3 text-slate-900 font-body-md text-body-md transition-colors bg-transparent" placeholder="Juan Pérez" type="text" />
              </div>
              <div>
                <label className="block font-label-caps text-label-caps text-slate-500 mb-2 uppercase">Número de Teléfono</label>
                <input className="w-full border-0 border-b-2 border-slate-200 focus:border-[#10B2CC] focus:ring-0 px-0 py-3 text-slate-900 font-body-md text-body-md transition-colors bg-transparent" placeholder="+52 (55) 1234-5678" type="tel" />
              </div>
            </div>
            <div>
              <label className="block font-label-caps text-label-caps text-slate-500 mb-2 uppercase">Correo</label>
              <input className="w-full border-0 border-b-2 border-slate-200 focus:border-[#10B2CC] focus:ring-0 px-0 py-3 text-slate-900 font-body-md text-body-md transition-colors bg-transparent" placeholder="ejemplo@correo.com" type="email" />
            </div>
            <div>
              <label className="block font-label-caps text-label-caps text-slate-500 mb-2 uppercase">Mensaje</label>
              <textarea className="w-full border-0 border-b-2 border-slate-200 focus:border-[#10B2CC] focus:ring-0 px-0 py-3 text-slate-900 font-body-md text-body-md transition-colors bg-transparent resize-none" placeholder="Describe tus necesidades de textiles comerciales..." rows={4}></textarea>
            </div>
            <button className="btn-primary text-white px-8 py-4 rounded-DEFAULT font-headline-sm text-headline-sm hover:-translate-y-0.5 transition-all duration-300 w-full md:w-auto flex items-center justify-center gap-2 shadow-md" type="submit">
              Enviar Consulta
              <span className="material-symbols-outlined" data-icon="send">send</span>
            </button>
          </form>
        </div>
        {/* Map & Info */}
        <div className="flex flex-col h-full">
          <div className="mb-8">
            <h2 className="font-headline-md text-headline-md text-slate-900 mb-2">Nuestra Ubicación</h2>
            <p className="font-body-md text-body-md text-slate-600">Encuéntranos en nuestras oficinas en Cancún, Quintana Roo.</p>
          </div>
          <div className="flex-1 min-h-[300px] w-full bg-slate-200 rounded-DEFAULT overflow-hidden relative mb-8 border border-white/50 shadow-md">
            <iframe
              src="https://maps.google.com/maps?q=21.17948980868,-86.837375164032&t=&z=15&ie=UTF8&iwloc=&output=embed"
              className="w-full h-full border-0 absolute inset-0"
              allowFullScreen
              loading="lazy"
              referrerPolicy="no-referrer-when-downgrade"
            ></iframe>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-8">
            <div className="flex items-start gap-4">
              <span className="material-symbols-outlined text-[#10B2CC] mt-1" data-icon="map">map</span>
              <div>
                <h4 className="font-headline-sm text-headline-sm text-slate-900 mb-1">Dirección Física</h4>
                <p className="font-body-md text-body-md text-slate-600 mb-4">Av. Talleres Reg 90 Mz 55 Lt15<br />Cancún, Q.R.</p>
                <h4 className="font-headline-sm text-headline-sm text-slate-900 mb-1 mt-6">Horarios de Atención</h4>
                <p className="font-body-md text-body-md text-slate-600">Lunes a Viernes de 09 a 17 hrs<br />Sábado de 09 a 15 hrs</p>
              </div>
            </div>
            <div className="flex items-start gap-4">
              <span className="material-symbols-outlined text-[#10B2CC] mt-1" data-icon="support_agent">support_agent</span>
              <div>
                <h4 className="font-headline-sm text-headline-sm text-slate-900 mb-1">Contacto Directo</h4>
                <div className="font-body-md text-body-md text-slate-600 mb-4">
                  <p><strong className="text-slate-900">Oficina:</strong> 998 884 0223</p>
                  <p><strong className="text-slate-900">WhatsApp:</strong> 998 275 9638</p>
                </div>
                <h4 className="font-headline-sm text-headline-sm text-slate-900 mb-1 mt-6">Correos Electrónicos</h4>
                <div className="font-body-md text-body-md text-slate-600">
                  <a href="mailto:ventas@lavitexdelcaribe.com" className="text-[#166D92] hover:text-[#10B2CC] hover:underline transition-colors block">ventas@lavitexdelcaribe.com</a>
                  <a href="mailto:susanamayen@lavitexdelcaribe.com" className="text-[#166D92] hover:text-[#10B2CC] hover:underline transition-colors block">susanamayen@lavitexdelcaribe.com</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
