# Use official Node.js LTS image
FROM node:20

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy application source
COPY . .

# Expose port the app runs on
EXPOSE 3000

# Run the app
CMD [ "node", "app.js" ]
