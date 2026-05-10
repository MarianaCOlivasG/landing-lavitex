import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Use 'standalone' for Docker/Node.js production builds
  output: 'export',

  images: {
    unoptimized: true,
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'images.unsplash.com',
      },
    ],
  },
};

export default nextConfig;
