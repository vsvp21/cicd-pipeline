pipeline {
    agent any

    environment {
        registryCredential = 'docker.registry'
    }

    def app
    stages {
        stage('build') {
            steps {
                app = docker.build("release_${env.BUILD_NUMBER}", ".")
            }
        }
        stage('Docker publish') {
            steps {
                docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    echo "Pushed!"
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
