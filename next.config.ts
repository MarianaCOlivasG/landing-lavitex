import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Only use 'export' for production builds
  output: process.env.NODE_ENV === 'production' ? 'export' : undefined,
  
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
