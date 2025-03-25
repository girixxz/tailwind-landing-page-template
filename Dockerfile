# Gunakan Node.js LTS untuk stabilitas
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install pnpm secara global
RUN npm install -g pnpm

# Copy file package.json dan pnpm-lock.yaml terlebih dahulu
COPY package.json pnpm-lock.yaml ./

# Install dependencies menggunakan pnpm
RUN pnpm install --frozen-lockfile

# Copy semua file proyek ke dalam container
COPY . .

# Build aplikasi
RUN pnpm build

# Expose port untuk Next.js
EXPOSE 3000

# Jalankan aplikasi
CMD ["pnpm", "start"]
