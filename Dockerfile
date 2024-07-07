# Use an official Node runtime as a parent image
FROM node:14 AS build

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Use a lighter image for the runtime
FROM node:14-alpine

# Set the working directory
WORKDIR /usr/src/app

# Copy the built application from the previous stage
COPY --from=build /usr/src/app .

# Expose the application port
EXPOSE 3000

# Run the application
CMD ["node", "index.js"]
