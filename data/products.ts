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
    name: "Colección de Toallas para Spa y Resort",
    description: "Rizos de algodón 100% hilado en anillo ultra absorbentes diseñados para soportar ciclos de lavado comercial pesados.",
    badge: "En Stock",
    specs: "800 GSM",
    icon: "straighten",
    image: "https://lh3.googleusercontent.com/aida-public/AB6AXuA3ETT1tAnjL1zWGg34KZKKL0kvJyYESFVN8I-VrmxX0orXve6bF31cigxqgCR_FdZ1ijOCr4xbaTX8RoYLa8jDUP-1uRsDfkTLImBkEEKA3QhZAJqtkpvpg1mi5BY9R-ETmgj5azDpFScVfdI7MBLeYa-p_fE5xAln6B9ylHMWoM2RX_hdfzk7vivgmJrvubulj7ZO_REla--yN1Xa6nxLn7UsPyc51hvKMKHzWrWdBWtbdVF_5uQBJhwWh-ln-8azfYoTXta9diIu",
    alt: "Crisp, folded stack of premium white hotel towels on a clean minimalist surface with soft natural lighting",
  },
  {
    id: "2",
    name: "Sábanas de Percale Ejecutivas",
    description: "Tejido de percale fresco y crujiente que proporciona una durabilidad excepcional y un acabado mate clásico para suites premium.",
    specs: "400 Hilos",
    icon: "layers",
    image: "https://lh3.googleusercontent.com/aida-public/AB6AXuBNjHX_p5UjRt-YOZFzQa8qb96as-va_6jEf1oXob9_EkxsUdCo7i7h15QYRjXgXE9-ndg5SPy6rzQoAtTf7odrSNjgm3DBULvRYckz1o_BilVgrzQUrjsAO_V6DNlNDBN-6JBQ2HXe72o1PHksuVbRAPSJIiJils2XeywNfeNmDwmuTbzL1QbBUATbJ1WAzBXbj9vx69pqpExpH4wSz5c3Fj2zPU4euHii3S8-2QseLBSoA2p_uh-pHoIvWgMZy4BmpptqqbMXekrQ",
    alt: "Immaculately made premium hotel bed with taut, crisp white high-thread-count sheets and minimalist lighting",
  },
  {
    id: "3",
    name: "Manteles de Damasco para Banquetes",
    description: "Mezcla de polialgodón resistente a las manchas con un sutil y elegante patrón tejido diseñado para comedores de alto tráfico.",
    specs: "Repelente a manchas",
    icon: "restaurant",
    image: "https://lh3.googleusercontent.com/aida-public/AB6AXuC1U6sUZ9De2-LFNBK7GaWFJnp2zWFU7NN1_oDs9RPp4Dh80rsrUVO9E3BsOWcpP6t9vpY57g42Sg-WlrLJ8ZU72Ckd2MCfEagOYsjVaX7ZO6v4_XEAZoZEW7CK-WOw_gmjFEzANXtWDnnV6hIxGYbdOk1fHCzyfzawxBtGjk9BSqjHfMMq6P16yibMxp8vM0tjdF8kwfztcJb6TJik6YZ05WhJmY0QJTW1PeWW4nLAmMc4YeI9-7P_fH-Tv1zOVPKu4QKGNqasRgnD",
    alt: "Close-up texture of heavy-duty white damask tablecloth fabric showing intricate subtle woven patterns under directional light",
  },
  {
    id: "4",
    name: "Batas de Spa Tejido Waffle",
    description: "Mezcla ligera de polialgodón de secado rápido que ofrece una estética exclusiva con bajos costos operativos de lavado.",
    specs: "Mezcla Secado Rápido",
    icon: "spa",
    image: "https://lh3.googleusercontent.com/aida-public/AB6AXuB9PEcHv2IUye-8JGju12toYO5XadMT_5PAGn0fQ4LyTrKeS3ylMsonA7VtYDCptX22wu390SUvwCvhn7q-Ns9235nTY3KD9-mpx9QUc8cdh5znnkV9KkD3qJOsbdWGTylGioDED74djoKcK83_xRYswNq1Vvr7UiSjCflHLE9cqHZ6mh0Sdb9ADDDEinke30v5PWZlrC9lAD8J4dMhC3fnnuHZludM1LfNc53TH44P2wUWtzzDJNYc8i_ZU2x-KvfvFSPgVZ_rdMWX",
    alt: "Neatly folded pile of luxurious white waffle-weave spa bathrobes on a minimal wooden shelf",
  },
  {
    id: "5",
    name: "Almohadas Reforzadas para Hotelería",
    description: "Relleno alternativo al plumón hipoalergénico con costura de doble aguja para evitar la migración del núcleo durante el lavado.",
    specs: "Doble Costura",
    icon: "bed",
    image: "https://lh3.googleusercontent.com/aida-public/AB6AXuBgd6TtggY5d-6iCPhdmLV3HmGmqrgs-aRico0_L8Q64ufs3zW5x4zcO-Hnn0kVpvturpChHdQKD1J0GBy5Z4vxMALII8R87BIuICtlRsOZ2X7DwjbWx0bwvmk79kBWZgFL8eezHiwjSbN9buNdAzngVdL1D5fGOSfuas8dK5ZKF-hKUBV5YoRVjlHuj9dRpGx1S-f1RkN8zqB4qlokoaGphyKggYgWXPvI6bQs_dE7R2jbf55G_5HOtxDWdxjhXBs-IFLDJ_4_JDtl",
    alt: "Detail shot of a pristine white pillow showing reinforced industrial double stitching along the edge",
  },
  {
    id: "6",
    name: "Utilitarios para Cocina Comercial",
    description: "Delantales de poliéster hilado de alto gramaje y trapos de bar rigurosos diseñados para entornos de cocina extremos.",
    badge: "Alto Volumen",
    specs: "Poliéster Hilado",
    icon: "local_dining",
    image: "https://lh3.googleusercontent.com/aida-public/AB6AXuB8tZFs39HpHYFvPZKXWQ09hK8Aj8o2iWXxaCfoCQpoZxLgVBtwBENTc5rxLK9spkHnd-M_qUhBRYH_K4jDAmXlotuZHqgbE5XVwac0nI_3BPX98xPi9U26p5Q6395G42CGTRDRMwcpmxr0mNtCILQhOnZOn9iA7aby4XvS9paWkCUBtCUW_xyaYuzk8cHlMETTF8jBhR33D-86Jut4jPaiJ8Cq5GQUfS2sI05rVrTOmuj9mGZzdDYFtGOqF4zoP0kvQP5gqPhwGAvR",
    alt: "Stack of durable white commercial kitchen aprons and heavy-duty wiping cloths on a stainless steel industrial table",
  }
];
