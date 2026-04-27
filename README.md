# 🧺 Lavitex - Landing Page & Dashboard

![Lavitex Banner](https://images.unsplash.com/photo-1545173168-9f1947eebb7f?auto=format&fit=crop&q=80&w=1200&h=400)

Lavitex is a modern web application designed for laundry services, featuring a sleek landing page and an integrated product/service catalog. Built with performance and scalability in mind.

## 🚀 Tech Stack

- **Framework:** [Next.js 15+](https://nextjs.org/) (App Router)
- **Styling:** [Tailwind CSS 4](https://tailwindcss.com/)
- **Backend/Auth:** [Supabase](https://supabase.com/)
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
   Copy the example file and fill in your Supabase credentials:
   ```bash
   cp .env.example .env.local
   ```

4. **Run the development server:**
   ```bash
   npm run dev
   ```

Open [http://localhost:3000](http://localhost:3000) to see the result.

## 🐳 Docker Deployment

To build and run the application using Docker:

1. **Build the image:**
   ```bash
   docker build -t lavitex-app .
   ```

2. **Run the container:**
   ```bash
   docker run -p 3000:3000 --env-file .env.local lavitex-app
   ```

## 🏗️ Project Structure

- `/app`: Next.js App Router pages and layouts.
- `/components`: Reusable UI components.
- `/lib`: Utility functions and external service configurations (Supabase client).
- `/public`: Static assets (images, icons).
- `/data`: Static data or mockups.

## 📝 Scripts

- `npm run dev`: Starts the development server.
- `npm run build`: Builds the application for production.
- `npm run start`: Starts the production server.
- `npm run lint`: Runs ESLint to check for code quality issues.

---

Built with ❤️ for Lavitex.
