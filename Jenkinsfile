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
                    dockerImage = docker.build("registry.hub.docker.com/sathamdocker/user-authentication-service-app:${env.BUILD_ID}")
                }
            }
        }
    
     // stage('Push Docker Image') {
     //        steps {
     //            script {
     //                docker.withRegistry('https://registry.hub.docker.com', 'docker-credentials') {
     //                    echo "Pushing Docker Image: registry.hub.docker.com/sathamdocker/user-authentication-service-app:${env.BUILD_ID}"
     //                    dockerImage.push("${env.BUILD_ID}") // Push with build ID tag
     //                }
     //            }
     //        }
     //  }
          stage('Check Docker Image list after push docker image stage') {
            steps {
                sh 'docker images'
            }
        }
        stage('Deploy') {
            steps {
                script {
                    echo "Deploying application with Docker Image: sathamdocker/user-authentication-service-app:${env.BUILD_ID}"
                    sh "docker run -d --name cont001 -p 400:80 registry.hub.docker.com/sathamdocker/user-authentication-service-app:${env.BUILD_ID}"
                    sh "docker run -d --name cont002 -p 401:80 registry.hub.docker.com/sathamdocker/user-authentication-service-app:${env.BUILD_ID}"
                }
            }
        }
        
        stage('Check Docker Image list after Deploy stage') {
            steps {
                sh 'docker images'
            }
        }
post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()  // This will clean up the workspace
        }
    }
        
    }
}

