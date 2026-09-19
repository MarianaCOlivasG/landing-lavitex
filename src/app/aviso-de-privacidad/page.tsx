import type { Metadata } from 'next';
import CorporatePage, { type CorporateSection } from '@/shared/ui/CorporatePage';

export const metadata: Metadata = {
  title: 'Aviso de Privacidad | Lavitex del Caribe',
  description: 'Aviso de privacidad integral de Lavitex del Caribe para visitantes, prospectos, clientes y personas usuarias de sus canales de contacto.',
};

const sections: CorporateSection[] = [
  {
    id: 'responsable',
    title: 'Identidad y domicilio del responsable',
    content: (
      <>
        <p>
          <strong>Lavitex del Caribe</strong>, con domicilio en Av. Talleres, Región 90, Manzana 55, Lote 15, Cancún, Quintana Roo, México, es responsable del tratamiento de los datos personales que recaba a través de este sitio web y de sus canales de atención.
        </p>
        <p>
          Para asuntos relacionados con privacidad y protección de datos puede escribir a <a href="mailto:ventas@lavitexdelcaribe.com">ventas@lavitexdelcaribe.com</a> o comunicarse al <a href="tel:+529988840223">998 884 0223</a>.
        </p>
      </>
    ),
  },
  {
    id: 'datos',
    title: 'Datos personales que tratamos',
    content: (
      <>
        <p>Podemos recabar los siguientes datos cuando usted solicita información o se comunica con nosotros:</p>
        <ul>
          <li>Datos de identificación y contacto: nombre, teléfono y correo electrónico.</li>
          <li>Información contenida en el mensaje o solicitud que usted decide compartir.</li>
          <li>Datos comerciales o de la organización necesarios para preparar una atención o cotización, cuando usted los proporcione.</li>
          <li>Datos técnicos básicos asociados a la navegación y a la seguridad del sitio, como dirección IP, tipo de dispositivo, navegador y registros de acceso, cuando sean generados por la infraestructura tecnológica.</li>
        </ul>
        <p>
          Este sitio no solicita datos personales sensibles, información financiera ni datos patrimoniales mediante su formulario de contacto. Le pedimos no incluir esa información en el campo de mensaje.
        </p>
      </>
    ),
  },
  {
    id: 'finalidades',
    title: 'Finalidades del tratamiento',
    content: (
      <>
        <p>Utilizamos sus datos personales para finalidades necesarias vinculadas con nuestra relación con usted:</p>
        <ul>
          <li>Recibir, atender y dar seguimiento a consultas, solicitudes y comentarios.</li>
          <li>Contactarle por correo o teléfono para ampliar información sobre su requerimiento.</li>
          <li>Preparar cotizaciones, propuestas o especificaciones de productos y servicios.</li>
          <li>Gestionar la relación comercial y brindar atención posterior a la entrega.</li>
          <li>Conservar evidencia de comunicaciones y cumplir obligaciones legales, contractuales, fiscales o de seguridad.</li>
          <li>Proteger la disponibilidad, integridad y seguridad del sitio y de nuestros sistemas.</li>
        </ul>
        <p>
          No utilizamos la información enviada mediante el formulario para campañas publicitarias ajenas a su solicitud. Si en el futuro se propone una finalidad secundaria, se informará y se solicitará el consentimiento correspondiente cuando resulte necesario.
        </p>
      </>
    ),
  },
  {
    id: 'transferencias',
    title: 'Transferencias y encargados',
    content: (
      <>
        <p>
          Podemos apoyarnos en proveedores que operan infraestructura, alojamiento web, correo electrónico o servicios tecnológicos. Dichos proveedores actúan por cuenta de Lavitex del Caribe y deben tratar la información conforme a nuestras instrucciones y a las obligaciones aplicables de confidencialidad y seguridad.
        </p>
        <p>
          No vendemos sus datos personales. Podremos comunicar información a autoridades competentes cuando exista una obligación legal o requerimiento debidamente fundado, así como en los demás supuestos permitidos por la legislación mexicana que no requieren consentimiento. Si se llegara a plantear una transferencia que sí lo requiera, se solicitará previamente su autorización.
        </p>
      </>
    ),
  },
  {
    id: 'arco',
    title: 'Derechos ARCO y revocación del consentimiento',
    content: (
      <>
        <p>
          Usted puede solicitar el <strong>acceso, rectificación, cancelación u oposición</strong> al tratamiento de sus datos personales (derechos ARCO), revocar su consentimiento cuando el tratamiento se base en éste o pedir la limitación de uso y divulgación de su información.
        </p>
        <p>
          Envíe su solicitud a <a href="mailto:ventas@lavitexdelcaribe.com">ventas@lavitexdelcaribe.com</a> con el asunto “Solicitud de datos personales” e incluya:
        </p>
        <ol>
          <li>Nombre de la persona titular y medio para comunicar la respuesta.</li>
          <li>Documento que permita acreditar su identidad o, en su caso, la representación legal.</li>
          <li>Descripción clara del derecho que desea ejercer y de los datos involucrados.</li>
          <li>Elementos que faciliten localizar la información y, para rectificación, documentos que sustenten el cambio.</li>
        </ol>
        <p>
          Daremos trámite a la solicitud dentro de los plazos previstos por la Ley Federal de Protección de Datos Personales en Posesión de los Particulares. La revocación no tendrá efectos retroactivos ni procederá cuando debamos conservar o tratar la información por una obligación legal.
        </p>
      </>
    ),
  },
  {
    id: 'conservacion',
    title: 'Conservación y seguridad',
    content: (
      <>
        <p>
          Conservamos los datos únicamente durante el tiempo razonablemente necesario para atender la finalidad informada, mantener la relación correspondiente y cumplir obligaciones o plazos legales. Después se aplicarán medidas de bloqueo, supresión o anonimización, según corresponda.
        </p>
        <p>
          Mantenemos medidas administrativas, técnicas y físicas razonables para reducir riesgos de pérdida, alteración, acceso, uso o divulgación no autorizados. Ningún sistema es completamente infalible; por ello revisamos y ajustamos nuestras medidas de protección de manera periódica.
        </p>
      </>
    ),
  },
  {
    id: 'tecnologias',
    title: 'Tecnologías y servicios de terceros',
    content: (
      <>
        <p>
          Este sitio puede utilizar elementos técnicos necesarios para su operación y puede integrar contenidos de terceros, como el mapa de ubicación. Al interactuar con estos servicios, el tercero podría recibir datos técnicos y aplicar sus propias políticas de privacidad. También encontrará enlaces a redes sociales que sólo se activan cuando usted decide visitarlas.
        </p>
        <p>
          Puede configurar su navegador para limitar determinadas tecnologías; hacerlo podría afectar algunas funciones del sitio.
        </p>
      </>
    ),
  },
  {
    id: 'cambios',
    title: 'Cambios al aviso de privacidad',
    content: (
      <>
        <p>
          Las modificaciones a este aviso se publicarán en esta misma página, indicando la fecha de actualización. Cuando un cambio requiera un nuevo consentimiento, pondremos a disposición el mecanismo correspondiente antes de aplicar la nueva finalidad.
        </p>
        <p>
          Este aviso se interpreta conforme a la Ley Federal de Protección de Datos Personales en Posesión de los Particulares y demás disposiciones aplicables en México.
        </p>
      </>
    ),
  },
];

export default function AvisoDePrivacidadPage() {
  return (
    <CorporatePage
      eyebrow="Información legal"
      title="Aviso de Privacidad"
      introduction="Transparencia sobre los datos que recibimos, para qué los usamos y cómo puede ejercer sus derechos."
      icon="shield_lock"
      updatedAt="19 de septiembre de 2026"
      sections={sections}
      asideTitle="¿Deseas ejercer tus derechos sobre datos personales?"
      asideText="Envíanos tu solicitud y te orientaremos sobre el proceso de acceso, rectificación, cancelación u oposición."
    />
  );
}
