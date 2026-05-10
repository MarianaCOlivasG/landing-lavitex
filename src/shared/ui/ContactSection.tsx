'use client';

import React, { useState } from 'react';
import { useFormik } from 'formik';
import * as Yup from 'yup';

export default function ContactSection() {
  const [submitted, setSubmitted] = useState(false);

  const validationSchema = Yup.object({
    nombreCompleto: Yup.string()
      .required('El nombre completo es obligatorio'),
    telefono: Yup.string()
      .matches(/^[0-9]{10}$/, 'El teléfono debe tener exactamente 10 dígitos')
      .required('El número de teléfono es obligatorio'),
    email: Yup.string()
      .email('Ingresa un correo electrónico válido')
      .required('El correo electrónico es obligatorio'),
    mensaje: Yup.string()
      .required('El mensaje es obligatorio'),
  });

  const formik = useFormik({
    initialValues: {
      nombreCompleto: '',
      telefono: '',
      email: '',
      mensaje: '',
    },
    validationSchema,
    onSubmit: async (values, { setSubmitting, resetForm }) => {
      try {
        const response = await fetch('/api/contact', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(values),
        });

        if (response.ok) {
          setSubmitted(true);
          resetForm();
          setTimeout(() => setSubmitted(false), 5000);
        } else {
          const errorData = await response.json();
          alert(`Error al enviar el mensaje: ${errorData.error || 'Inténtalo de nuevo más tarde.'}`);
        }
      } catch (error) {
        console.error('Error de red:', error);
        alert('Error de red. Por favor verifica tu conexión.');
      } finally {
        setSubmitting(false);
      }
    },

  });

  return (
    <section id="contact" className="w-full py-section-gap bg-gradient-to-b from-slate-100 to-slate-200 border-t border-slate-200">
      <div className="max-w-container-max mx-auto px-gutter md:px-16 lg:px-24 grid grid-cols-1 lg:grid-cols-2 gap-16">
        {/* Contact Form */}
        <div className="premium-card p-10">
          <div className="mb-8">
            <h2 className="font-headline-md text-headline-md text-slate-900 mb-2">Solicita una Consulta</h2>
            <p className="font-body-md text-body-md text-slate-600">Conecta con nuestros gerentes de cuenta comerciales para precios al por mayor y especificaciones técnicas.</p>
          </div>

          {submitted ? (
            <div className="bg-emerald-50 border border-emerald-200 rounded-lg p-6 text-center animate-in fade-in zoom-in duration-300">
              <span className="material-symbols-outlined text-emerald-500 text-4xl mb-2" data-icon="check_circle">check_circle</span>
              <h3 className="text-emerald-900 font-headline-sm mb-1">¡Consulta Enviada!</h3>
              <p className="text-emerald-700 font-body-md">Gracias por contactarnos. Un ejecutivo se comunicará contigo pronto.</p>
              <button 
                onClick={() => setSubmitted(false)}
                className="mt-4 text-emerald-600 hover:text-emerald-700 font-label-caps uppercase text-xs font-bold tracking-wider"
              >
                Enviar otro mensaje
              </button>
            </div>
          ) : (
            <form onSubmit={formik.handleSubmit} className="space-y-6">
              <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                  <label className="block font-label-caps text-label-caps text-slate-500 mb-1 uppercase">Nombre Completo</label>
                  <input 
                    {...formik.getFieldProps('nombreCompleto')}
                    className={`w-full border-0 border-b-2 ${formik.touched.nombreCompleto && formik.errors.nombreCompleto ? 'border-red-400' : 'border-slate-200'} focus:border-[#10B2CC] focus:ring-0 px-0 py-3 text-slate-900 font-body-md text-body-md transition-colors bg-transparent`} 
                    placeholder="Juan Pérez" 
                    type="text" 
                  />
                  {formik.touched.nombreCompleto && formik.errors.nombreCompleto ? (
                    <div className="text-red-500 text-[10px] font-medium mt-1 uppercase tracking-wider">{formik.errors.nombreCompleto}</div>
                  ) : null}
                </div>
                <div>
                  <label className="block font-label-caps text-label-caps text-slate-500 mb-1 uppercase">Número de Teléfono</label>
                  <input 
                    {...formik.getFieldProps('telefono')}
                    className={`w-full border-0 border-b-2 ${formik.touched.telefono && formik.errors.telefono ? 'border-red-400' : 'border-slate-200'} focus:border-[#10B2CC] focus:ring-0 px-0 py-3 text-slate-900 font-body-md text-body-md transition-colors bg-transparent`} 
                    placeholder="10 dígitos (ej. 9981234567)" 
                    type="tel" 
                  />
                  {formik.touched.telefono && formik.errors.telefono ? (
                    <div className="text-red-500 text-[10px] font-medium mt-1 uppercase tracking-wider">{formik.errors.telefono}</div>
                  ) : null}
                </div>
              </div>
              <div>
                <label className="block font-label-caps text-label-caps text-slate-500 mb-1 uppercase">Correo</label>
                <input 
                  {...formik.getFieldProps('email')}
                  className={`w-full border-0 border-b-2 ${formik.touched.email && formik.errors.email ? 'border-red-400' : 'border-slate-200'} focus:border-[#10B2CC] focus:ring-0 px-0 py-3 text-slate-900 font-body-md text-body-md transition-colors bg-transparent`} 
                  placeholder="ejemplo@correo.com" 
                  type="email" 
                />
                {formik.touched.email && formik.errors.email ? (
                  <div className="text-red-500 text-[10px] font-medium mt-1 uppercase tracking-wider">{formik.errors.email}</div>
                ) : null}
              </div>
              <div>
                <label className="block font-label-caps text-label-caps text-slate-500 mb-1 uppercase">Mensaje</label>
                <textarea 
                  {...formik.getFieldProps('mensaje')}
                  className={`w-full border-0 border-b-2 ${formik.touched.mensaje && formik.errors.mensaje ? 'border-red-400' : 'border-slate-200'} focus:border-[#10B2CC] focus:ring-0 px-0 py-3 text-slate-900 font-body-md text-body-md transition-colors bg-transparent resize-none`} 
                  placeholder="Describe tus necesidades de textiles comerciales..." 
                  rows={4}
                />
                {formik.touched.mensaje && formik.errors.mensaje ? (
                  <div className="text-red-500 text-[10px] font-medium mt-1 uppercase tracking-wider">{formik.errors.mensaje}</div>
                ) : null}
              </div>
              <button 
                className="btn-primary text-white px-8 py-4 rounded-DEFAULT font-headline-sm text-headline-sm hover:-translate-y-0.5 transition-all duration-300 w-full md:w-auto flex items-center justify-center gap-2 shadow-md disabled:opacity-50 disabled:cursor-not-allowed" 
                type="submit"
                disabled={formik.isSubmitting}
              >
                {formik.isSubmitting ? 'Enviando...' : 'Enviar Consulta'}
                <span className="material-symbols-outlined" data-icon="send">send</span>
              </button>
            </form>
          )}
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

