import TopNavBar from '@/components/TopNavBar';
import HeroSection from '@/components/HeroSection';
import WhoWeAreSection from '@/components/WhoWeAreSection';
import ProductsSection from '@/components/ProductsSection';
import ContactSection from '@/components/ContactSection';
import Footer from '@/components/Footer';

export default function Home() {
  return (
    <>
      <TopNavBar />
      <main className="flex-1 w-full">
        <HeroSection />
        <WhoWeAreSection />
        <ProductsSection />
        <ContactSection />
      </main>
      <Footer />
    </>
  );
}
