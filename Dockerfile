# Stage 1: Build the application
FROM node:18-alpine AS builder  # ✅ Define the "builder" stage

# Set working directory
WORKDIR /pinterest-app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire application
COPY . .

# Build the app
RUN npm run build

# Stage 2: Serve the app with Nginx
FROM nginx:alpine

# Copy the built app from the "builder" stage
COPY --from=builder /pinterest-app/dist /usr/share/nginx/html  # ✅ Corrected path

# Expose port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
