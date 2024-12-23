# Step 1: Use an official Node.js image as the base image
FROM node:16-alpine as build


# Step 2: Set the working directory inside the container
WORKDIR /app


# Step 3: Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./


# Step 4: Install the app dependencies
RUN npm install


# Step 5: Copy the rest of the application code to the working directory
COPY . .


# Step 6: Build the React app for production
RUN npm run build


# Step 7: Use a minimal nginx image to serve the build
FROM nginx:alpine


# Step 8: Copy the build output to the Nginx HTML directory
COPY --from=build /app/build /usr/share/nginx/html


# Step 9: Expose port 80 to allow the app to be served on that port
EXPOSE 80


# Step 10: Start Nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]



