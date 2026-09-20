import type { MetadataRoute } from 'next';

export default function manifest(): MetadataRoute.Manifest {
  return {
    name: 'Lavitex del Caribe',
    short_name: 'Lavitex',
    description: 'Fabricación y recuperación de blancos institucionales y soluciones textiles en Cancún.',
    start_url: '/',
    display: 'standalone',
    background_color: '#F8FAFB',
    theme_color: '#10B2CC',
    lang: 'es-MX',
    icons: [
      {
        src: '/favicon.ico',
        sizes: 'any',
        type: 'image/x-icon',
      },
    ],
  };
}
