import React from 'react';

export default function ContactSection() {
  return (
    <section className="w-full py-section-gap bg-surface-container-lowest border-t border-surface-container-low">
      <div className="max-w-container-max mx-auto px-gutter md:px-16 lg:px-24 grid grid-cols-1 lg:grid-cols-2 gap-16">
        {/* Contact Form */}
        <div className="bg-surface p-10 rounded-DEFAULT shadow-[0_4px_20px_-4px_rgba(22,109,146,0.03)] border border-surface-container-low">
          <div className="mb-8">
            <h2 className="font-headline-md text-headline-md text-on-surface mb-2">Request a Consultation</h2>
            <p className="font-body-md text-body-md text-on-surface-variant">Connect with our commercial account managers for wholesale pricing and technical specifications.</p>
          </div>
          <form className="space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <label className="block font-label-caps text-label-caps text-on-surface-variant mb-2 uppercase">Full Name</label>
                <input className="w-full bg-surface-container-lowest border-0 border-b-2 border-outline-variant focus:border-primary focus:ring-0 px-0 py-3 text-on-surface font-body-md text-body-md transition-colors bg-transparent" placeholder="John Doe" type="text"/>
              </div>
              <div>
                <label className="block font-label-caps text-label-caps text-on-surface-variant mb-2 uppercase">Phone Number</label>
                <input className="w-full bg-surface-container-lowest border-0 border-b-2 border-outline-variant focus:border-primary focus:ring-0 px-0 py-3 text-on-surface font-body-md text-body-md transition-colors bg-transparent" placeholder="+52 (55) 1234-5678" type="tel"/>
              </div>
            </div>
            <div>
              <label className="block font-label-caps text-label-caps text-on-surface-variant mb-2 uppercase">Business Email</label>
              <input className="w-full bg-surface-container-lowest border-0 border-b-2 border-outline-variant focus:border-primary focus:ring-0 px-0 py-3 text-on-surface font-body-md text-body-md transition-colors bg-transparent" placeholder="procurement@hotel.com" type="email"/>
            </div>
            <div>
              <label className="block font-label-caps text-label-caps text-on-surface-variant mb-2 uppercase">Message</label>
              <textarea className="w-full bg-surface-container-lowest border-0 border-b-2 border-outline-variant focus:border-primary focus:ring-0 px-0 py-3 text-on-surface font-body-md text-body-md transition-colors bg-transparent resize-none" placeholder="Describe your commercial textile needs..." rows={4}></textarea>
            </div>
            <button className="bg-primary text-on-primary px-8 py-4 rounded-DEFAULT font-headline-sm text-headline-sm hover:bg-primary-container transition-colors duration-300 w-full md:w-auto flex items-center justify-center gap-2" type="submit">
              Submit Inquiry
              <span className="material-symbols-outlined" data-icon="send">send</span>
            </button>
          </form>
        </div>
        {/* Map & Info */}
        <div className="flex flex-col h-full">
          <div className="mb-8">
            <h2 className="font-headline-md text-headline-md text-on-surface mb-2">Regional Headquarters</h2>
            <p className="font-body-md text-body-md text-on-surface-variant">Strategically located to serve the Caribbean hospitality corridor.</p>
          </div>
          <div className="flex-1 min-h-[300px] w-full bg-surface-container rounded-DEFAULT overflow-hidden relative mb-8 border border-surface-container-highest">
            {/* Placeholder for Map Image */}
            <img 
              alt="Clean minimalist map interface showing the coastal region of Cancun Mexico with a subtle blue color palette" 
              className="w-full h-full object-cover" 
              data-alt="Clean minimalist map interface showing the coastal region of Cancun Mexico with a subtle blue color palette" 
              data-location="Cancun, Mexico" 
              src="https://lh3.googleusercontent.com/aida-public/AB6AXuBFFPqTB7IWwSX2_APbnrPWk6A8zJqyqlZwmT04eL7SC8EYtsCPOC2neOolIpSNpDo1eNRg7OstNsolejQ27J0vjWMbAqDHUfj-si5XGaU9Cah1JyjOnxUUl2p_arXTYWA_iTzehqfHk_vIPsEDs19-GgukC-m7MbSmxyu2SfSH3NQbyJxO66AYlZCKXL0V0nRG2-pBFSfcnZ9Ff1KqY6qIDAMm_gnStHZylTpmEyxr_RBNvKJnuN1XF9Nae9BNFDRDNE0R8z3Tk9Kd"
            />
            <div className="absolute inset-0 bg-primary/5 pointer-events-none"></div>
            <div className="absolute top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-white p-3 rounded-full shadow-lg flex items-center justify-center">
              <span className="material-symbols-outlined text-primary text-[32px]" data-icon="location_on">location_on</span>
            </div>
          </div>
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-8">
            <div className="flex items-start gap-4">
              <span className="material-symbols-outlined text-primary mt-1" data-icon="map">map</span>
              <div>
                <h4 className="font-headline-sm text-headline-sm text-on-surface mb-1">Facility Location</h4>
                <p className="font-body-md text-body-md text-on-surface-variant">Blvd. Luis Donaldo Colosio Km 12<br/>Cancun, Q.R. 77560<br/>Mexico</p>
              </div>
            </div>
            <div className="flex items-start gap-4">
              <span className="material-symbols-outlined text-primary mt-1" data-icon="support_agent">support_agent</span>
              <div>
                <h4 className="font-headline-sm text-headline-sm text-on-surface mb-1">Direct Contact</h4>
                <p className="font-body-md text-body-md text-on-surface-variant">Sales: +52 998 123 4567<br/>Support: +52 998 765 4321<br/>info@lavitexcaribe.com</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
