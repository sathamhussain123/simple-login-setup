pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    ============== echo "Build Docker Image started" ==============
                    dockerImage = docker.build("simple-login-app:${env.BUILD_ID}")
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing application...'
                // Add testing steps here, e.g., HTTP checks
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-credentials') {
                        dockerImage.push('latest')
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                sh 'docker run -d -p 80:80 simple-login-app:latest'
            }
        }
    }
}

