# Step 1: Build Angular app
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

# Step 2: Serve with NGINX
FROM nginx:alpine
COPY --from=build /app/dist/<your-angular-project-name> /usr/share/nginx/html

# Expose Render's default port
EXPOSE 10000
CMD ["nginx", "-g", "daemon off;"]