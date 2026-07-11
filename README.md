# 🧺 Lavitex - Landing Page & Dashboard

![Lavitex Banner](https://images.unsplash.com/photo-1545173168-9f1947eebb7f?auto=format&fit=crop&q=80&w=1200&h=400)

Lavitex is a modern web application designed for laundry services, featuring a sleek landing page and an integrated product/service catalog. Built with performance and scalability in mind.

## 🚀 Tech Stack

- **Framework:** [Next.js 15+](https://nextjs.org/) (App Router)
- **Styling:** [Tailwind CSS 4](https://tailwindcss.com/)
- **Database:** [MySQL](https://www.mysql.com/)
- **Language:** [TypeScript](https://www.typescriptlang.org/)
- **Deployment:** [Docker](https://www.docker.com/)

## 🛠️ Getting Started

### Prerequisites

- Node.js 20+
- npm / yarn / pnpm
- Docker (optional, for containerized deployment)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/MarianaCOlivasG/landing-lavitex.git
   cd lavitex
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Set up environment variables:**
   Copy the example file and fill in your MySQL credentials:
   ```bash
   cp .env.example .env.local
   ```

4. **Run the development server:**
   ```bash
   npm run dev
   ```

Open [http://localhost:3000](http://localhost:3000) to see the result.

## 🐳 Docker Deployment

Pasa las credenciales de MySQL como argumentos de construcción para que estén disponibles en el servidor:

1. **Build the image:**
   ```bash
   docker build \
     --build-arg DB_HOST="127.0.0.1" \
     --build-arg DB_PORT="3306" \
     --build-arg DB_USER="lavitex_user" \
     --build-arg DB_PASSWORD="lavitex_password" \
     --build-arg DB_NAME="lavitex_db" \
     -t lavitex-app .
   ```

2. **Run the container:**
   ```bash
   docker run -p 3000:3000 --env-file .env.local lavitex-app
   ```

## 🏗️ Project Structure

- `/app`: Next.js App Router (Páginas y layouts).
- `/components`: Componentes UI reutilizables.
- `/lib`: Funciones de utilidad y cliente de MySQL.
- `/public`: Assets estáticos.

---

Built with ❤️ for Lavitex.
