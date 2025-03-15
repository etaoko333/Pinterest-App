# Use Node.js official image
FROM node:18-alpine 

# Set working directory
WORKDIR /Pinterest-App

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire application
COPY . .

# Build the app
RUN npm run build

# Use Nginx for serving the app
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
