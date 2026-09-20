import TopNavBar from '@/shared/ui/TopNavBar';
import HeroSection from '@/shared/ui/HeroSection';
import CertificationsSection from '@/shared/ui/CertificationsSection';
import WarrantyTrustSection from '@/shared/ui/WarrantyTrustSection';
import WhoWeAreSection from '@/shared/ui/WhoWeAreSection';
import ProductsSection from '@/shared/ui/ProductsSection';
import ContactSection from '@/shared/ui/ContactSection';
import Footer from '@/shared/ui/Footer';
import { createPageMetadata } from '@/lib/seo';

export const metadata = createPageMetadata({
  title: 'Fabricante de blancos hoteleros en Cancún | Lavitex del Caribe',
  description: 'Fabricación y recuperación de blancos institucionales, textiles hoteleros, artículos promocionales, serigrafía y decoración a la medida en Cancún.',
  path: '/',
  absoluteTitle: true,
});

export const dynamic = 'force-dynamic';

export default function Home() {
  return (
    <>
      <TopNavBar />
      <main className="flex-1 w-full">
        <HeroSection />
        <CertificationsSection />
        <WarrantyTrustSection />
        <WhoWeAreSection />
        <ProductsSection />
        <ContactSection />
      </main>
      <Footer />
    </>
  );
}
