# Use Node LTS
FROM node:20-slim AS build
WORKDIR /app

COPY svelte-app/package*.json ./
RUN npm ci

COPY svelte-app ./
RUN npm run build

# Production
FROM node:20-slim
WORKDIR /app
COPY --from=build /app/build ./
COPY svelte-app/package*.json ./
RUN npm ci --omit=dev

EXPOSE 8080
CMD ["node", "index.js"]