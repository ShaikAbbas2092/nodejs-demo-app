Node.js CI/CD Pipeline with GitHub Actions and Docker


Overview

This project automates the continuous integration and continuous deployment (CI/CD) of a Node.js web application using GitHub Actions and Docker. The pipeline automatically builds, tests, and deploys a Docker image to DockerHub on every push to the main branch.

Step-by-Step Setup and Commands

1. Initialize and prepare your Node.js app repository
mkdir nodejs-demo-app
cd nodejs-demo-app
npm init -y           
git init
     
2. Create and add a Dockerfile in the root directory
FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "app.js"]

3. Commit project files
git add .git commit -m "Initial commit with Dockerfile"


4. Create a GitHub repository and connect your local repo
git remote add origin https://github.com/your-username/nodejs-demo-app.gitgit branch -M maingit push -u origin main

5. Set up GitHub Secrets for DockerHub credentials
In GitHub repo, go to:
Settings → Secrets and variables → Actions → New repository secret
Add:
DOCKER_USERNAME — abbastaher.
DOCKERHUB_TOKEN — ************.


6. Add the GitHub Actions workflow file .github/workflows/main.yml

name: CI/CD Pipeline
on:
  push:
    branches:
      - main

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Install dependencies
        run: npm install

      - name: Run tests
        run: npm test

      - name: Log in to DockerHub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Build and push Docker image
        uses: docker/build-push-action@v6
        with:
          context: .
          push: true
          tags: ${{ secrets.DOCKER_USERNAME }}/nodejs-demo-app:latest

          
7. Commit and push the workflow file
git add .github/workflows/main.yml
git commit -m "Add CI/CD workflow for Node.js + Docker"
git push


8.Monitoring the pipeline execution on GitHub

<img width="691" height="229" alt="image" src="https://github.com/user-attachments/assets/a8083441-3fb4-48bb-a944-c456ea200323" />
<img width="692" height="295" alt="image" src="https://github.com/user-attachments/assets/433a4415-4f66-41c5-acab-08e2fb97bdb8" />






