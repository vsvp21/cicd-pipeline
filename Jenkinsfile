pipeline {
    agent any

    options {
        skipDefaultCheckout true
    }
    
    environment {
        registryCredential = 'docker.registry'
    }

    stages {
        stage('git checkout') {
            steps {
                checkout scm
            }
        }
        stage('app build') {
            agent {
                docker { image 'node:20.10.0-alpine3.19' }
            }
            steps {
                script {
                    sh 'chmod +x scripts/build.sh'
                    sh 'ls -l'
                    sh 'pwd'
                    sh "./scripts/build.sh"
                }
            }
        }
        stage('tests') {
            agent {
                docker { image 'node:20.10.0-alpine3.19' }
            }
            steps {
                script {
                    sh 'chmod +x scripts/test.sh'        
                    sh './scripts/test.sh'
                }
            }
        }
        stage('docker image build') {
            steps {
                script {
                    docker.build("release:${env.BUILD_NUMBER}", ".")
                }
            }
        }
        stage('docker image push') {
            steps {
                script {
                    echo "Pushing the image to docker hub"
                    def localImage = "release:${env.BUILD_NUMBER}"
                    def repositoryName = "kimyuri/${localImage}"
                  
                    // Create a tag that going to push into DockerHub
                    sh "docker tag ${localImage} ${repositoryName} "
                    docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                      def image = docker.image("${repositoryName}");
                      image.push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Image built and pushed successfully!'
        }
    }
}
