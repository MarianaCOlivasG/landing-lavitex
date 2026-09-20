import type { Metadata } from 'next';
import CorporatePage, { type CorporateSection } from '@/shared/ui/CorporatePage';
import { createPageMetadata } from '@/lib/seo';

export const metadata: Metadata = createPageMetadata({
  title: 'Política de Calidad',
  description: 'Conoce los principios de calidad de Lavitex del Caribe para la fabricación, recuperación y entrega de soluciones textiles.',
  path: '/politicas-de-calidad',
});

const sections: CorporateSection[] = [
  {
    id: 'declaracion',
    title: 'Declaración de calidad',
    content: (
      <>
        <p>
          En Lavitex del Caribe nos comprometemos a fabricar y recuperar soluciones textiles que cumplan las especificaciones acordadas con cada cliente, mediante una atención cercana, procesos controlados y mejora continua.
        </p>
        <p>
          Nuestra política se aplica a las líneas de hogar, hotelería, spa, hospital y eventos, así como a artículos promocionales, serigrafía y proyectos de decoración textil dentro del alcance confirmado en cada pedido.
        </p>
      </>
    ),
  },
  {
    id: 'principios',
    title: 'Principios que guían nuestro trabajo',
    content: (
      <ul>
        <li><strong>Escuchar antes de producir:</strong> comprender uso, medidas, volumen, apariencia, mantenimiento y desempeño esperado.</li>
        <li><strong>Cumplir lo acordado:</strong> trabajar con especificaciones documentadas y comunicar oportunamente cualquier cambio relevante.</li>
        <li><strong>Prevenir errores:</strong> revisar materiales, medidas, confección, acabado e identificación durante el proceso.</li>
        <li><strong>Entregar productos funcionales:</strong> evaluar cada pieza de acuerdo con su aplicación y con los criterios aceptados para el pedido.</li>
        <li><strong>Mejorar de forma continua:</strong> analizar incidencias, comentarios y oportunidades para fortalecer nuestros métodos.</li>
      </ul>
    ),
  },
  {
    id: 'proceso',
    title: 'Control a lo largo del proceso',
    content: (
      <>
        <h3>Definición del requerimiento</h3>
        <p>
          Confirmamos la información necesaria para producir: producto, cantidad, medidas, material, color, personalización, tolerancias acordadas, presentación y fecha objetivo.
        </p>
        <h3>Revisión de insumos</h3>
        <p>
          Verificamos que los materiales recibidos correspondan a la referencia prevista y que su condición sea adecuada para entrar al proceso. Las variaciones propias de fibras, tejidos o lotes se comunican cuando puedan afectar el resultado esperado.
        </p>
        <h3>Seguimiento de producción</h3>
        <p>
          Aplicamos revisiones durante corte, confección, personalización y acabado, de acuerdo con el tipo de producto. El objetivo es detectar desviaciones antes de la entrega y evitar reprocesos.
        </p>
        <h3>Revisión final</h3>
        <p>
          Antes de liberar un pedido revisamos aspectos aplicables como cantidad, medidas, apariencia, costuras, acabado, limpieza, identificación y empaque.
        </p>
      </>
    ),
  },
  {
    id: 'recuperacion',
    title: 'Calidad en recuperación de blancos',
    content: (
      <>
        <p>
          La recuperación parte de una evaluación del estado de las piezas. Su viabilidad depende del desgaste, composición, daño, dimensión útil y función posterior. Cuando una recuperación no resulte recomendable, lo comunicaremos para evitar una solución que no cumpla su propósito.
        </p>
        <p>
          El alcance, resultado esperado y criterios de aceptación deben acordarse antes de iniciar el trabajo, considerando que una pieza recuperada conserva características propias de su uso anterior.
        </p>
      </>
    ),
  },
  {
    id: 'proveedores',
    title: 'Materiales y proveedores',
    content: (
      <>
        <p>
          Seleccionamos materiales y proveedores según su capacidad para responder a las especificaciones de cada línea. Consideramos consistencia, disponibilidad, aptitud para el uso y atención ante incidencias. Cuando un insumo cambie o no esté disponible, proponemos alternativas para aprobación del cliente antes de aplicarlas al pedido.
        </p>
      </>
    ),
  },
  {
    id: 'trazabilidad',
    title: 'Seguimiento y mejora continua',
    content: (
      <>
        <p>
          Conservamos la información comercial y técnica necesaria para dar seguimiento a los pedidos conforme a nuestras obligaciones y a nuestro aviso de privacidad. Los comentarios de clientes, incidencias de producción, devoluciones y reprocesos sirven como entrada para revisar causas y definir acciones de mejora.
        </p>
        <p>
          Evaluamos nuestro desempeño mediante criterios internos relacionados con conformidad del producto, cumplimiento de entregas, atención de incidencias y reducción de errores. Las metas específicas se revisan de acuerdo con la operación y prioridades del negocio.
        </p>
      </>
    ),
  },
  {
    id: 'atencion',
    title: 'Atención de inconformidades',
    content: (
      <>
        <p>
          Si un producto o servicio no corresponde con lo confirmado, solicitamos reportarlo tan pronto como sea razonablemente posible. Para agilizar la revisión, comparta el número o referencia del pedido, descripción de la situación, cantidad afectada y evidencia fotográfica cuando aplique.
        </p>
        <p>
          Revisaremos el caso contra las especificaciones aceptadas y comunicaremos la alternativa procedente conforme a las condiciones particulares del pedido. Puede contactarnos en <a href="mailto:ventas@lavitexdelcaribe.com">ventas@lavitexdelcaribe.com</a>, al <a href="tel:+529988840223">998 884 0223</a> o por WhatsApp al <a href="https://wa.me/529982759638">998 275 9638</a>.
        </p>
      </>
    ),
  },
  {
    id: 'responsabilidad',
    title: 'Responsabilidad compartida',
    content: (
      <>
        <p>
          La calidad final depende también de información precisa, aprobación oportuna de muestras o especificaciones y uso adecuado del producto. Recomendamos seguir las indicaciones de cuidado aplicables y comunicar desde el inicio condiciones especiales de lavado, operación, exposición o desempeño.
        </p>
        <p>
          Esta política expresa nuestros compromisos operativos y no constituye por sí sola una certificación de sistema de gestión ni sustituye las garantías o condiciones específicas acordadas en cada venta.
        </p>
      </>
    ),
  },
];

export default function PoliticasDeCalidadPage() {
  return (
    <CorporatePage
      eyebrow="Excelencia operativa"
      title="Política de Calidad"
      introduction="Criterios claros, procesos controlados y comunicación cercana para cumplir las especificaciones de cada solución textil."
      icon="verified"
      updatedAt="19 de septiembre de 2026"
      sections={sections}
      asideTitle="¿Necesitas definir una especificación textil?"
      asideText="Nuestro equipo puede ayudarte a documentar medidas, materiales, uso y criterios de aceptación para tu proyecto."
    />
  );
}
