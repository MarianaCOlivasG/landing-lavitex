import TopNavBar from '@/shared/ui/TopNavBar';
import HeroSection from '@/shared/ui/HeroSection';
import CertificationsSection from '@/shared/ui/CertificationsSection';
import WhoWeAreSection from '@/shared/ui/WhoWeAreSection';
import ProductsSection from '@/shared/ui/ProductsSection';
import ContactSection from '@/shared/ui/ContactSection';
import Footer from '@/shared/ui/Footer';

export const dynamic = 'force-dynamic';

export default function Home() {
  return (
    <>
      <TopNavBar />
      <main className="flex-1 w-full">
        <HeroSection />
        <CertificationsSection />
        <WhoWeAreSection />
        <ProductsSection />
        <ContactSection />
      </main>
      <Footer />
    </>
  );
}
