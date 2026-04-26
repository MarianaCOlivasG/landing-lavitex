export interface Product {
  id: string;
  name: string;
  description: string;
  badge?: string;
  specs: string;
  icon: string;
  image: string;
  alt: string;
}

export const mockProducts: Product[] = [
  {
    id: "1",
    name: "Resort Spa Towel Collection",
    description: "Ultra-absorbent 100% ring-spun cotton loops engineered to withstand heavy commercial laundering cycles.",
    badge: "In Stock",
    specs: "800 GSM",
    icon: "straighten",
    image: "https://lh3.googleusercontent.com/aida-public/AB6AXuA3ETT1tAnjL1zWGg34KZKKL0kvJyYESFVN8I-VrmxX0orXve6bF31cigxqgCR_FdZ1ijOCr4xbaTX8RoYLa8jDUP-1uRsDfkTLImBkEEKA3QhZAJqtkpvpg1mi5BY9R-ETmgj5azDpFScVfdI7MBLeYa-p_fE5xAln6B9ylHMWoM2RX_hdfzk7vivgmJrvubulj7ZO_REla--yN1Xa6nxLn7UsPyc51hvKMKHzWrWdBWtbdVF_5uQBJhwWh-ln-8azfYoTXta9diIu",
    alt: "Crisp, folded stack of premium white hotel towels on a clean minimalist surface with soft natural lighting",
  },
  {
    id: "2",
    name: "Executive Percale Linens",
    description: "Crisp, cool percale weave providing exceptional durability and a classic matte finish for premium suites.",
    specs: "400 Thread Count",
    icon: "layers",
    image: "https://lh3.googleusercontent.com/aida-public/AB6AXuBNjHX_p5UjRt-YOZFzQa8qb96as-va_6jEf1oXob9_EkxsUdCo7i7h15QYRjXgXE9-ndg5SPy6rzQoAtTf7odrSNjgm3DBULvRYckz1o_BilVgrzQUrjsAO_V6DNlNDBN-6JBQ2HXe72o1PHksuVbRAPSJIiJils2XeywNfeNmDwmuTbzL1QbBUATbJ1WAzBXbj9vx69pqpExpH4wSz5c3Fj2zPU4euHii3S8-2QseLBSoA2p_uh-pHoIvWgMZy4BmpptqqbMXekrQ",
    alt: "Immaculately made premium hotel bed with taut, crisp white high-thread-count sheets and minimalist lighting",
  },
  {
    id: "3",
    name: "Banquet Damask Tablecloths",
    description: "Stain-resistant poly-cotton blend featuring a subtle, elegant woven pattern designed for high-traffic dining.",
    specs: "Stain-Repellent",
    icon: "restaurant",
    image: "https://lh3.googleusercontent.com/aida-public/AB6AXuC1U6sUZ9De2-LFNBK7GaWFJnp2zWFU7NN1_oDs9RPp4Dh80rsrUVO9E3BsOWcpP6t9vpY57g42Sg-WlrLJ8ZU72Ckd2MCfEagOYsjVaX7ZO6v4_XEAZoZEW7CK-WOw_gmjFEzANXtWDnnV6hIxGYbdOk1fHCzyfzawxBtGjk9BSqjHfMMq6P16yibMxp8vM0tjdF8kwfztcJb6TJik6YZ05WhJmY0QJTW1PeWW4nLAmMc4YeI9-7P_fH-Tv1zOVPKu4QKGNqasRgnD",
    alt: "Close-up texture of heavy-duty white damask tablecloth fabric showing intricate subtle woven patterns under directional light",
  },
  {
    id: "4",
    name: "Waffle-Weave Spa Robes",
    description: "Lightweight, quick-drying poly-cotton blend offering an upscale aesthetic with low operational laundering costs.",
    specs: "Quick-Dry Blend",
    icon: "spa",
    image: "https://lh3.googleusercontent.com/aida-public/AB6AXuB9PEcHv2IUye-8JGju12toYO5XadMT_5PAGn0fQ4LyTrKeS3ylMsonA7VtYDCptX22wu390SUvwCvhn7q-Ns9235nTY3KD9-mpx9QUc8cdh5znnkV9KkD3qJOsbdWGTylGioDED74djoKcK83_xRYswNq1Vvr7UiSjCflHLE9cqHZ6mh0Sdb9ADDDEinke30v5PWZlrC9lAD8J4dMhC3fnnuHZludM1LfNc53TH44P2wUWtzzDJNYc8i_ZU2x-KvfvFSPgVZ_rdMWX",
    alt: "Neatly folded pile of luxurious white waffle-weave spa bathrobes on a minimal wooden shelf",
  },
  {
    id: "5",
    name: "Reinforced Hospitality Pillows",
    description: "Hypoallergenic down-alternative fill with double-needle stitching to prevent core migration during washing.",
    specs: "Double-Stitched",
    icon: "bed",
    image: "https://lh3.googleusercontent.com/aida-public/AB6AXuBgd6TtggY5d-6iCPhdmLV3HmGmqrgs-aRico0_L8Q64ufs3zW5x4zcO-Hnn0kVpvturpChHdQKD1J0GBy5Z4vxMALII8R87BIuICtlRsOZ2X7DwjbWx0bwvmk79kBWZgFL8eezHiwjSbN9buNdAzngVdL1D5fGOSfuas8dK5ZKF-hKUBV5YoRVjlHuj9dRpGx1S-f1RkN8zqB4qlokoaGphyKggYgWXPvI6bQs_dE7R2jbf55G_5HOtxDWdxjhXBs-IFLDJ_4_JDtl",
    alt: "Detail shot of a pristine white pillow showing reinforced industrial double stitching along the edge",
  },
  {
    id: "6",
    name: "Commercial Kitchen Utility",
    description: "Heavy-weight spun polyester aprons and rigorous bar mops designed for extreme kitchen environments.",
    badge: "High Volume",
    specs: "Spun Polyester",
    icon: "local_dining",
    image: "https://lh3.googleusercontent.com/aida-public/AB6AXuB8tZFs39HpHYFvPZKXWQ09hK8Aj8o2iWXxaCfoCQpoZxLgVBtwBENTc5rxLK9spkHnd-M_qUhBRYH_K4jDAmXlotuZHqgbE5XVwac0nI_3BPX98xPi9U26p5Q6395G42CGTRDRMwcpmxr0mNtCILQhOnZOn9iA7aby4XvS9paWkCUBtCUW_xyaYuzk8cHlMETTF8jBhR33D-86Jut4jPaiJ8Cq5GQUfS2sI05rVrTOmuj9mGZzdDYFtGOqF4zoP0kvQP5gqPhwGAvR",
    alt: "Stack of durable white commercial kitchen aprons and heavy-duty wiping cloths on a stainless steel industrial table",
  }
];
