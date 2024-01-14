pipeline {
    agent any

    environment {
        registryCredential = 'docker.registry'
    }

    stages {
        stage('Image build and Push') {
            steps {
                script {
                    docker.withCredentials('https://hub.docker.com', registryCredential) {
                      def appBuild = docker.build("app:${env.BUILD_ID}")
                      appBuild.push()
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
