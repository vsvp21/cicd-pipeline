pipeline {
    agent any

    environment {
        registryCredential = 'docker.registry'
    }

    stages {
        stage('Image build and Push') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: registryCredential, passwordVariable: 'pass', usernameVariable: 'user')]) {
                        sh "docker login -u ${user} -p ${pass}"
                        sh "docker build -t release_${env.BUILD_ID} ."
                        sh "docker push release_${env.BUILD_ID}"
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
