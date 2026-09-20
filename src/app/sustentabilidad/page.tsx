import type { Metadata } from 'next';
import CorporatePage, { type CorporateSection } from '@/shared/ui/CorporatePage';
import { createPageMetadata } from '@/lib/seo';

export const metadata: Metadata = createPageMetadata({
  title: 'Sustentabilidad',
  description: 'Conoce el enfoque de Lavitex del Caribe para extender la vida útil de los textiles, optimizar materiales y fortalecer la producción local.',
  path: '/sustentabilidad',
});

const sections: CorporateSection[] = [
  {
    id: 'enfoque',
    title: 'Nuestro enfoque',
    content: (
      <>
        <p>
          En Lavitex del Caribe entendemos la sustentabilidad como una forma responsable de diseñar, fabricar, usar y recuperar textiles. Nuestro trabajo se concentra en soluciones durables para hotelería, hospitales, spas, eventos, comercios y hogares, con decisiones orientadas a aprovechar mejor cada material.
        </p>
        <p>
          Este enfoque parte de tres principios: <strong>durabilidad, aprovechamiento y producción cercana</strong>. No presentamos estos compromisos como una certificación ambiental; son criterios de trabajo que buscamos fortalecer de manera continua junto con clientes y proveedores.
        </p>
      </>
    ),
  },
  {
    id: 'vida-util',
    title: 'Extender la vida útil',
    content: (
      <>
        <p>
          La recuperación de blancos institucionales es una parte central de nuestra actividad. Cuando las condiciones de la pieza lo permiten, evaluamos alternativas de ajuste, reparación o reaprovechamiento antes de sustituirla por completo.
        </p>
        <ul>
          <li>Revisión del estado, medidas y uso previsto de cada pieza.</li>
          <li>Recomendaciones de recuperación cuando sean técnica y funcionalmente viables.</li>
          <li>Fabricación a la medida para evitar excedentes innecesarios y mejorar el desempeño en operación.</li>
          <li>Orientación sobre cuidados que ayudan a conservar la apariencia y funcionalidad del textil.</li>
        </ul>
      </>
    ),
  },
  {
    id: 'produccion-local',
    title: 'Producción local y responsable',
    content: (
      <>
        <p>
          Fabricamos en Quintana Roo para atender de forma cercana las necesidades del Caribe Mexicano. La proximidad facilita especificaciones a la medida, comunicación directa y una planeación de entregas acorde con la operación de nuestros clientes.
        </p>
        <p>
          Trabajamos con materiales y procesos seleccionados según el uso final del producto. En cada proyecto buscamos equilibrar calidad, resistencia, mantenimiento y aprovechamiento, sin comprometer las especificaciones acordadas.
        </p>
      </>
    ),
  },
  {
    id: 'eficiencia',
    title: 'Uso eficiente de materiales',
    content: (
      <>
        <p>
          La planeación de cortes y la producción contra especificación ayudan a reducir sobrantes. Cuando se generan remanentes aprovechables, procuramos identificar usos compatibles dentro de nuestras líneas de confección, muestras o desarrollos de menor formato.
        </p>
        <p>
          También promovemos pedidos con información completa —medidas, composición, color, cantidad y desempeño esperado— para disminuir reprocesos y asegurar que cada producto responda a una necesidad real.
        </p>
      </>
    ),
  },
  {
    id: 'colaboracion',
    title: 'Una responsabilidad compartida',
    content: (
      <>
        <p>
          El desempeño ambiental de un textil continúa después de su entrega. Invitamos a nuestros clientes a aplicar rutinas de lavado adecuadas, dosificar correctamente los insumos, evitar temperaturas o procesos más intensivos de lo necesario y separar oportunamente las piezas que puedan recuperarse.
        </p>
        <p>
          Si deseas evaluar una solución a la medida o la recuperación de blancos de tu operación, nuestro equipo puede revisar el caso y proponer una alternativa con base en el estado y uso de las piezas.
        </p>
      </>
    ),
  },
  {
    id: 'mejora',
    title: 'Compromiso de mejora continua',
    content: (
      <>
        <p>
          Revisamos nuestras prácticas conforme evolucionan los materiales, las necesidades del sector y las posibilidades técnicas. Nuestras prioridades son mejorar el aprovechamiento de insumos, prevenir defectos y reprocesos, favorecer productos durables y mantener una comunicación transparente sobre el alcance de cada solución.
        </p>
      </>
    ),
  },
];

export default function SustentabilidadPage() {
  return (
    <CorporatePage
      eyebrow="Responsabilidad corporativa"
      title="Sustentabilidad"
      introduction="Textiles pensados para durar, procesos orientados al aprovechamiento y una operación cercana a nuestros clientes del Caribe Mexicano."
      icon="eco"
      updatedAt="19 de septiembre de 2026"
      sections={sections}
      asideTitle="¿Tienes textiles que podrían recuperarse?"
      asideText="Cuéntanos las características de tus blancos institucionales y evaluaremos contigo las opciones técnicamente viables."
    />
  );
}
