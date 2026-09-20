import type { Metadata } from "next";
import { Inter } from "next/font/google";
import { absoluteUrl, DEFAULT_SOCIAL_IMAGE, serializeJsonLd, SITE_NAME, SITE_URL } from '@/lib/seo';
import "./globals.css";

const inter = Inter({
  variable: "--font-inter",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  metadataBase: SITE_URL,
  title: {
    default: 'Fabricante de blancos hoteleros en Cancún | Lavitex del Caribe',
    template: '%s | Lavitex del Caribe',
  },
  description: 'Fabricación y recuperación de blancos institucionales, textiles hoteleros, artículos promocionales, serigrafía y decoración en Cancún, Quintana Roo.',
  applicationName: SITE_NAME,
  authors: [{ name: SITE_NAME, url: SITE_URL }],
  creator: SITE_NAME,
  publisher: SITE_NAME,
  category: 'Textiles y hospitalidad',
  manifest: '/manifest.webmanifest',
  openGraph: {
    type: 'website',
    locale: 'es_MX',
    url: '/',
    siteName: SITE_NAME,
    title: 'Fabricante de blancos hoteleros en Cancún | Lavitex del Caribe',
    description: 'Soluciones textiles a la medida para hoteles, hospitales, spas, eventos, comercios y hogares en el Caribe Mexicano.',
    images: [{
      url: DEFAULT_SOCIAL_IMAGE,
      width: 1024,
      height: 1024,
      alt: 'Blancos hoteleros y soluciones textiles de Lavitex del Caribe',
    }],
  },
  twitter: {
    card: 'summary_large_image',
    title: 'Fabricante de blancos hoteleros en Cancún | Lavitex del Caribe',
    description: 'Soluciones textiles a la medida para hotelería y comercios en el Caribe Mexicano.',
    images: [DEFAULT_SOCIAL_IMAGE],
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      'max-image-preview': 'large',
      'max-snippet': -1,
      'max-video-preview': -1,
    },
  },
  verification: process.env.GOOGLE_SITE_VERIFICATION
    ? { google: process.env.GOOGLE_SITE_VERIFICATION }
    : undefined,
};

const organizationJsonLd = {
  '@context': 'https://schema.org',
  '@graph': [
    {
      '@type': ['Organization', 'LocalBusiness'],
      '@id': `${SITE_URL.origin}/#organization`,
      name: SITE_NAME,
      legalName: 'Lavitex del Caribe, S.A. de C.V.',
      url: SITE_URL.origin,
      logo: absoluteUrl('/images/logo.png'),
      image: absoluteUrl('/images/quienes_somos.png'),
      description: 'Fabricante y proveedor de blancos institucionales y soluciones textiles a la medida para el sector hotelero y comercial.',
      telephone: '+52 998 884 0223',
      email: 'ventas@lavitexdelcaribe.com',
      address: {
        '@type': 'PostalAddress',
        streetAddress: 'Av. Talleres, Región 90, Manzana 55, Lote 15',
        addressLocality: 'Cancún',
        addressRegion: 'Quintana Roo',
        postalCode: '77510',
        addressCountry: 'MX',
      },
      geo: {
        '@type': 'GeoCoordinates',
        latitude: 21.17948980868,
        longitude: -86.837375164032,
      },
      openingHoursSpecification: [
        {
          '@type': 'OpeningHoursSpecification',
          dayOfWeek: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'],
          opens: '09:00',
          closes: '17:00',
        },
        {
          '@type': 'OpeningHoursSpecification',
          dayOfWeek: 'Saturday',
          opens: '09:00',
          closes: '15:00',
        },
      ],
      areaServed: {
        '@type': 'AdministrativeArea',
        name: 'Caribe Mexicano',
      },
      sameAs: [
        'https://www.facebook.com/Lavitexdelcaribe/',
        'https://www.instagram.com/lavitexdelcaribe/',
      ],
      contactPoint: {
        '@type': 'ContactPoint',
        contactType: 'sales',
        telephone: '+52 998 884 0223',
        email: 'ventas@lavitexdelcaribe.com',
        availableLanguage: 'Spanish',
        areaServed: 'MX',
      },
    },
    {
      '@type': 'WebSite',
      '@id': `${SITE_URL.origin}/#website`,
      url: SITE_URL.origin,
      name: SITE_NAME,
      inLanguage: 'es-MX',
      publisher: { '@id': `${SITE_URL.origin}/#organization` },
    },
  ],
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html
      lang="es-MX"
      className={`${inter.variable} light scroll-smooth`}
    >
      <head>
        <meta name="theme-color" content="#10B2CC" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="anonymous" />
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: serializeJsonLd(organizationJsonLd) }}
        />
      </head>
      <body className="bg-background text-on-background font-body-md text-body-md antialiased min-h-screen flex flex-col">
        {children}
      </body>
    </html>
  );
}
