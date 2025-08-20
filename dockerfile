# Step 1: Build Angular app
FROM node:20-alpine AS build
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source and build Angular app
COPY . .
RUN npm run build --prod

# Step 2: Serve with NGINX
FROM nginx:alpine

# Copy built Angular app
COPY --from=build /app/dist /usr/share/nginx/html

# Keep nginx default config (listens on 80)
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]