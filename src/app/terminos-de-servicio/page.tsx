import type { Metadata } from 'next';
import CorporatePage, { type CorporateSection } from '@/shared/ui/CorporatePage';
import { createPageMetadata } from '@/lib/seo';

export const metadata: Metadata = createPageMetadata({
  title: 'Términos de Servicio',
  description: 'Condiciones de uso del sitio web, catálogo y canales digitales de Lavitex del Caribe.',
  path: '/terminos-de-servicio',
});

const sections: CorporateSection[] = [
  {
    id: 'aceptacion',
    title: 'Aceptación y alcance',
    content: (
      <>
        <p>
          Estos términos regulan el acceso y uso del sitio web y de los canales digitales de Lavitex del Caribe. Al navegar por el sitio o enviar una solicitud, usted reconoce haber leído y aceptado estas condiciones. Si no está de acuerdo, puede abstenerse de utilizar el sitio.
        </p>
        <p>
          El sitio está dirigido a personas que buscan información sobre textiles, blancos institucionales, artículos promocionales, serigrafía, decoración y servicios relacionados. Su contenido es informativo y no constituye por sí mismo una oferta contractual definitiva.
        </p>
      </>
    ),
  },
  {
    id: 'cotizaciones',
    title: 'Solicitudes y cotizaciones',
    content: (
      <>
        <p>
          El envío de un formulario, correo o mensaje no genera automáticamente una relación contractual ni obliga a Lavitex del Caribe a aceptar un pedido. Las cotizaciones se preparan con base en la información proporcionada y pueden estar sujetas a validación de medidas, materiales, cantidades, disponibilidad, tiempos y condiciones de entrega.
        </p>
        <p>
          La contratación de productos o servicios se regirá por la cotización, orden de compra, contrato, anticipo o confirmación comercial aplicable. En caso de diferencia, esos documentos específicos prevalecerán sobre la información general de este sitio.
        </p>
      </>
    ),
  },
  {
    id: 'catalogo',
    title: 'Catálogo y especificaciones',
    content: (
      <>
        <p>
          Procuramos mantener información clara y actualizada. Sin embargo, imágenes, colores, texturas, acabados y proporciones pueden variar según la pantalla, el lote de material o las características propias de la producción textil. Las fotografías son ilustrativas y deben confirmarse mediante muestra o especificación cuando el proyecto lo requiera.
        </p>
        <p>
          La disponibilidad, precio, composición, medida, plazo y posibilidad de personalización se confirman en cada cotización. Lavitex del Caribe puede actualizar el catálogo o descontinuar referencias sin previo aviso, respetando los pedidos previamente confirmados conforme a sus condiciones particulares.
        </p>
      </>
    ),
  },
  {
    id: 'uso',
    title: 'Uso permitido del sitio',
    content: (
      <>
        <p>Al utilizar el sitio, usted se compromete a:</p>
        <ul>
          <li>Proporcionar información verdadera y suficiente cuando solicite atención.</li>
          <li>No intentar acceder sin autorización a sistemas, cuentas, servidores o información.</li>
          <li>No introducir código malicioso, automatizar consultas abusivas ni afectar la disponibilidad del servicio.</li>
          <li>No copiar, explotar o presentar como propio el contenido protegido de Lavitex del Caribe.</li>
          <li>No utilizar el sitio para actividades ilícitas, fraudulentas o que lesionen derechos de terceros.</li>
        </ul>
      </>
    ),
  },
  {
    id: 'propiedad',
    title: 'Propiedad intelectual',
    content: (
      <>
        <p>
          Los nombres comerciales, logotipos, fotografías, textos, diseños, fichas, catálogos y demás contenidos propios del sitio pertenecen a Lavitex del Caribe o se utilizan con autorización. Su consulta no concede licencia, cesión ni derecho de explotación.
        </p>
        <p>
          Se permite descargar o imprimir información únicamente para evaluar nuestros productos o servicios, sin alterar avisos de autoría y sin uso comercial independiente. Cualquier reproducción adicional requiere autorización previa y por escrito.
        </p>
      </>
    ),
  },
  {
    id: 'disponibilidad',
    title: 'Disponibilidad y enlaces externos',
    content: (
      <>
        <p>
          Podemos realizar tareas de mantenimiento, seguridad o actualización que interrumpan temporalmente el sitio. No garantizamos disponibilidad ininterrumpida, aunque procuramos restablecer el servicio en un plazo razonable.
        </p>
        <p>
          Los enlaces o contenidos de terceros —incluidos mapas y redes sociales— se ofrecen para conveniencia. Cada tercero es responsable de su servicio, disponibilidad, contenido y prácticas de privacidad.
        </p>
      </>
    ),
  },
  {
    id: 'responsabilidad',
    title: 'Responsabilidad',
    content: (
      <>
        <p>
          La información general del sitio no sustituye una recomendación técnica basada en el uso, mantenimiento, condiciones de operación y especificaciones de cada proyecto. Lavitex del Caribe no será responsable por decisiones tomadas exclusivamente a partir de contenido general ni por un uso del producto distinto al acordado o recomendado.
        </p>
        <p>
          Nada de lo aquí previsto limita derechos irrenunciables reconocidos por la legislación mexicana de protección al consumidor ni excluye responsabilidades que legalmente no puedan limitarse.
        </p>
      </>
    ),
  },
  {
    id: 'privacidad',
    title: 'Privacidad y comunicaciones',
    content: (
      <>
        <p>
          El tratamiento de la información enviada a través del sitio se rige por nuestro <a href="/aviso-de-privacidad">Aviso de Privacidad</a>. Usted es responsable de no enviar datos sensibles o confidenciales que no sean necesarios para atender su solicitud.
        </p>
      </>
    ),
  },
  {
    id: 'ley',
    title: 'Ley aplicable y contacto',
    content: (
      <>
        <p>
          Estos términos se interpretan conforme a las leyes de los Estados Unidos Mexicanos. Cualquier situación se procurará resolver primero mediante comunicación directa y de buena fe. Cuando sea legalmente procedente, las partes se sujetarán a las autoridades competentes de Cancún, Quintana Roo, sin perjuicio de los derechos y competencias que resulten obligatorios.
        </p>
        <p>
          Para preguntas sobre estos términos puede escribir a <a href="mailto:ventas@lavitexdelcaribe.com">ventas@lavitexdelcaribe.com</a> o llamar al <a href="tel:+529988840223">998 884 0223</a>.
        </p>
      </>
    ),
  },
];

export default function TerminosDeServicioPage() {
  return (
    <CorporatePage
      eyebrow="Información legal"
      title="Términos de Servicio"
      introduction="Condiciones claras para el uso de nuestro sitio, catálogo y canales de atención digital."
      icon="contract"
      updatedAt="19 de septiembre de 2026"
      sections={sections}
      asideTitle="¿Tienes una duda sobre una cotización o servicio?"
      asideText="Nuestro equipo puede aclarar especificaciones, disponibilidad y condiciones particulares de tu proyecto."
    />
  );
}
