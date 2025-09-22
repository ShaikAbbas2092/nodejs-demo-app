Node.js CI/CD Pipeline with GitHub Actions and Docker
Overview
This project automates the continuous integration and continuous deployment (CI/CD) of a Node.js web application using GitHub Actions and Docker. The pipeline automatically builds, tests, and deploys a Docker image to DockerHub on every push to the main branch.

Repository Contents
Dockerfile — Defines how to build the Docker image for the Node.js app.

.github/workflows/main.yml — GitHub Actions workflow automating build, test, and Docker image deployment.

package.json & package-lock.json — Node.js project metadata and dependencies.

Application source code — Core Node.js application files.

README.md — This documentation.

Step-by-Step Setup and Commands
1. Initialize and prepare your Node.js app repository
bash
mkdir nodejs-demo-app
cd nodejs-demo-app
npm init -y               # Create package.json
# Add your Node.js source files here, including app.js
git init                  # Initialize Git repository
2. Create and add a Dockerfile in the root directory
Example Dockerfile:

text
FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "app.js"]
Save as Dockerfile in the root.

3. Commit project files
bash
git add .
git commit -m "Initial commit with Dockerfile"
4. Create a GitHub repository and connect your local repo
bash
git remote add origin https://github.com/your-username/nodejs-demo-app.git
git branch -M main
git push -u origin main
5. Set up GitHub Secrets for DockerHub credentials
In your GitHub repo, go to:

Settings → Secrets and variables → Actions → New repository secret

Add:

DOCKER_USERNAME — Your DockerHub username.

DOCKERHUB_TOKEN — Your DockerHub personal access token.

6. Add the GitHub Actions workflow file .github/workflows/main.yml
Example workflow content:

text
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
bash
git add .github/workflows/main.yml
git commit -m "Add CI/CD workflow for Node.js + Docker"
git push
8. Monitor the pipeline execution on GitHub
Visit your repository's Actions tab.

View the latest workflow run.

Confirm the steps: checkout, Node.js setup, install, test, Docker login, build, and push succeed.

Additional Notes
The npm test script uses Jest testing framework. Install it with:

bash
npm install --save-dev jest
Add or update your package.json scripts section:

json
"scripts": {
  "test": "jest"
}
DockerHub authentication secrets are securely stored in GitHub repository secrets to protect credentials.

Dockerfile must be placed at the repository root to match the GitHub Actions build context.

Summary
This project automates Node.js app deployment using:

GitHub Actions for CI/CD workflow.

Docker for containerizing the app.

DockerHub for image hosting.

This pipeline enables continuous delivery with automatic testing and deployment triggered on code pushes, ensuring faster and reliable updates.
