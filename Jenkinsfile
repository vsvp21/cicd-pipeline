def app
pipeline {
    agent any

    environment {
        registryCredential = 'docker.registry'
    }

    stages {
        stage('build') {
            steps {
                script {
                    app = docker.build("release_${env.BUILD_NUMBER}", ".")
                }
            }
        }
        stage('Docker publish') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                        echo "Pushed!"
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
