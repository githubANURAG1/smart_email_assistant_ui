# Step 1: Build Angular app
FROM node:20-alpine AS build
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source code and build Angular app
COPY . .
RUN npm run build --prod

# Step 2: Serve with NGINX
FROM nginx:alpine

# Copy built Angular app (copies everything inside dist/)
COPY --from=build /app/dist /usr/share/nginx/html

# Render sets $PORT dynamically; configure nginx to use it
RUN sed -i "s/listen       80;/listen       \$PORT;/" /etc/nginx/conf.d/default.conf

# Start nginx
CMD ["nginx", "-g", "daemon off;"]