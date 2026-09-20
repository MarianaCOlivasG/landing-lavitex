import type { Metadata } from 'next';

const configuredSiteUrl = process.env.NEXT_PUBLIC_SITE_URL?.trim();

export const SITE_URL = new URL(
  configuredSiteUrl || 'https://lavitexdelcaribe.com'
);

export const SITE_NAME = 'Lavitex del Caribe';
export const DEFAULT_SOCIAL_IMAGE = '/images/hero-bg.png';

type PageMetadataOptions = {
  title: string;
  description: string;
  path: string;
  image?: string;
  absoluteTitle?: boolean;
  noIndex?: boolean;
};

export function createPageMetadata({
  title,
  description,
  path,
  image = DEFAULT_SOCIAL_IMAGE,
  absoluteTitle = false,
  noIndex = false,
}: PageMetadataOptions): Metadata {
  const canonicalPath = path.startsWith('/') ? path : `/${path}`;
  const socialTitle = absoluteTitle ? title : `${title} | ${SITE_NAME}`;

  return {
    title: absoluteTitle ? { absolute: title } : title,
    description,
    alternates: {
      canonical: canonicalPath,
      languages: {
        'es-MX': canonicalPath,
      },
    },
    openGraph: {
      type: 'website',
      locale: 'es_MX',
      url: canonicalPath,
      siteName: SITE_NAME,
      title: socialTitle,
      description,
      images: [
        image === DEFAULT_SOCIAL_IMAGE
          ? {
              url: image,
              width: 1024,
              height: 1024,
              alt: `${SITE_NAME} - fabricación de soluciones textiles`,
            }
          : {
              url: image,
              alt: `${title} - ${SITE_NAME}`,
            },
      ],
    },
    twitter: {
      card: 'summary_large_image',
      title: socialTitle,
      description,
      images: [image],
    },
    robots: noIndex
      ? { index: false, follow: false }
      : {
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
  };
}

export function absoluteUrl(path: string): string {
  return new URL(path, SITE_URL).toString();
}

export function serializeJsonLd(value: unknown): string {
  return JSON.stringify(value).replace(/</g, '\\u003c');
}
