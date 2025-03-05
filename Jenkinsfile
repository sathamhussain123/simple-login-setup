pipeline
{
     agent any

      // agent {
      //   docker {
      //       image 'sathamdocker/jenkins-agent-kind:latest'
      //       args '-v /var/run/docker.sock:/var/run/docker.sock'

      //       image 'docker:dind' // Use Docker-in-Docker image
      //       args '-v /var/run/docker.sock:/var/run/docker.sock' // Mount Docker socket
      //       args '--privileged' // Required for DinD
      // }
      }
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
    
     stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-credentials') {
                        // echo "Pushing Docker Image: registry.hub.docker.com/sathamdocker/user-authentication-service-app:${env.BUILD_ID}"
                        echo "Pushing Docker Image: registry.hub.docker.com/sathamdocker/jenkins-agent-kind"
                        // dockerImage.push("${env.BUILD_ID}") // Push with build ID tag
                        dockerImage.push
                    }
                }
            }
      }
          stage('Check Docker Image list after push docker image stage') {
            steps {
                sh 'docker images'
            }
        }
    //     stage('Deploy') {
    //         steps {
    //             script {
    //                 echo "Deploying application with Docker Image: sathamdocker/user-authentication-service-app:${env.BUILD_ID}"
    //                 sh "docker run -d --name cont001 -p 400:80 registry.hub.docker.com/sathamdocker/user-authentication-service-app:${env.BUILD_ID}"
    //                 sh "docker run -d --name cont002 -p 401:80 registry.hub.docker.com/sathamdocker/user-authentication-service-app:${env.BUILD_ID}"
    //             }
    //         }
    //     }
        
    //     stage('Check Docker Image list after Deploy stage') {
    //         steps {
    //             sh 'docker images'
    //         }
    //     }
    // }  
post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()  // This will clean up the workspace
        }
    }
}

// pipeline {
//     agent {
//         docker {
//             image 'sathamdocker/jenkins-agent-kind:latest'  // Use custom agent with Docker, KIND, and kubectl
//             args '-v /var/run/docker.sock:/var/run/docker.sock' // Mount Docker socket (Host to container)
//         }
//     }
//     environment {
//         KIND_CLUSTER_NAME = "my-cluster"
//         APP_NAME = "user-auth-app"
//         APP_IMAGE = "sathamdocker/user-authentication-service-app"
//         GITHUB_DEPLOYMENT_FILE = "https://github.com/sathamhussain123/simple-login-setup/main/deployment.yaml"
//     }
//     stages {
//         stage('Check Tools') {
//             steps {
//                 sh 'docker --version'
//                 sh 'kubectl version --client'
//                 sh 'kind version'
//             }
//         }
        
//         stage('Create KIND Cluster (if not exists)') {
//             steps {
//                 script {
//                     def clusterExists = sh(script: "kind get clusters | grep -w ${KIND_CLUSTER_NAME} || true", returnStdout: true).trim()
//                     if (!clusterExists) {
//                         sh "kind create cluster --name ${KIND_CLUSTER_NAME}"
//                     } else {
//                         echo "KIND Cluster ${KIND_CLUSTER_NAME} already exists."
//                     }
//                 }
//             }
//         }

//         stage('Build Docker Image') {
//             steps {
//                 script {
//                     sh "docker build -t ${APP_IMAGE}:${env.BUILD_ID} ."
//                     sh "kind load docker-image ${APP_IMAGE}:${env.BUILD_ID} --name ${KIND_CLUSTER_NAME}"
//                 }
//             }
//         }

//         stage('Fetch Deployment File from GitHub') {
//             steps {
//                 sh "wget -O deployment.yaml ${GITHUB_DEPLOYMENT_FILE}"
//             }
//         }

//         stage('Deploy to KIND') {
//             steps {
//                 sh "kubectl apply -f deployment.yaml"
//             }
//         }

//         stage('Verify Deployment') {
//             steps {
//                 sh "kubectl get pods"
//                 sh "kubectl get services"
//             }
//         }
//     }
// }



