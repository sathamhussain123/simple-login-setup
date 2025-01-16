pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Check Docker') {
            steps {
                sh 'docker --version'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    echo "============= Build Docker Image started ============="
                    dockerImage = docker.build("sathamdocker/user-authentication-service-app:${env.BUILD_ID}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-credentials') {
                        echo "Pushing Docker Image: sathamdocker/user-authentication-service-app:${env.BUILD_ID}"
                        dockerImage.push("${env.BUILD_ID}") // Push with build ID tag
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    echo "Deploying application with Docker Image: sathamdocker/user-authentication-service-app:${env.BUILD_ID}"
                    sh "docker run -d -p 400:80 sathamdocker/user-authentication-service-app:${env.BUILD_ID}"
                }
            }
        }
    }
}
