import { NextResponse } from 'next/server';
import nodemailer from 'nodemailer';
import path from 'path';
import fs from 'fs';

export async function POST(request: Request) {
  try {
    const { nombreCompleto, telefono, email, mensaje } = await request.json();

    // Basic validation
    if (!nombreCompleto || !telefono || !email || !mensaje) {
      return NextResponse.json(
        { error: 'Todos los campos son obligatorios' },
        { status: 400 }
      );
    }

    // SMTP Configuration
    const transporter = nodemailer.createTransport({
      host: process.env.SMTP_HOST,
      port: Number(process.env.SMTP_PORT) || 587,
      secure: Number(process.env.SMTP_PORT) === 465,
      auth: {
        user: process.env.SMTP_USER,
        pass: process.env.SMTP_PASS,
      },
    });

    const destination = process.env.CONTACT_EMAIL_DESTINATION || 'susanamayen@lavitexdelcaribe.com';

    // Path to the logo
    const logoPath = path.join(process.cwd(), 'public/images/logo.png');
    const logoExists = fs.existsSync(logoPath);

    // Email content
    const mailOptions: any = {
      from: `"Lavitex Landing" <${process.env.SMTP_USER}>`,
      to: destination,
      subject: `Nuevo Lead: ${nombreCompleto}`,
      text: `Tienes un nuevo mensaje desde el formulario de contacto:
      
Nombre: ${nombreCompleto}
Teléfono: ${telefono}
Email: ${email}
Mensaje: ${mensaje}`,
      html: `
        <div style="font-family: Arial, sans-serif; max-width: 600px; margin: auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 10px;">
          <div style="text-align: center; margin-bottom: 20px;">
            ${logoExists ? '<img src="cid:logo" alt="Lavitex Logo" style="max-width: 150px;" />' : '<h1 style="color: #10B2CC; margin: 0;">Lavitex</h1>'}
          </div>
          <h2 style="color: #166D92; text-align: center;">Nuevo Lead de Contacto</h2>
          <p>Has recibido una nueva consulta desde la landing page de Lavitex.</p>
          <hr style="border: 0; border-top: 1px solid #eeeeee;" />
          <div style="padding: 10px 0;">
            <p><strong>Nombre:</strong> ${nombreCompleto}</p>
            <p><strong>Teléfono:</strong> ${telefono}</p>
            <p><strong>Email:</strong> ${email}</p>
            <p><strong>Mensaje:</strong></p>
            <div style="background-color: #f9f9f9; padding: 15px; border-radius: 5px; color: #333; line-height: 1.5;">
              ${mensaje.replace(/\n/g, '<br/>')}
            </div>
          </div>
          <hr style="border: 0; border-top: 1px solid #eeeeee;" />
          <p style="font-size: 12px; color: #888888; text-align: center;">
            Este correo fue enviado automáticamente desde el sistema de Lavitex.
          </p>
        </div>
      `,
    };

    // Attach logo if it exists
    if (logoExists) {
      mailOptions.attachments = [
        {
          filename: 'logo.png',
          path: logoPath,
          cid: 'logo', // same cid value as in the html img src
        },
      ];
    }

    // Send email
    await transporter.sendMail(mailOptions);

    return NextResponse.json({ message: 'Email enviado correctamente' }, { status: 200 });
  } catch (error: any) {
    console.error('Error enviando email:', error);
    return NextResponse.json(
      { error: 'Error al enviar el email', details: error.message },
      { status: 500 }
    );
  }
}

