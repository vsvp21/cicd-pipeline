def app
pipeline {
    agent {
        docker { image 'node:20.10.0-alpine3.19' }
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
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }
        // stage('app build') {
        //     steps {
        //         script {
        //             sh 'scripts/build.sh'
        //         }
        //     }
        // }
        // stage('tests') {
        //     steps {
        //         script {
        //             sh '/scripts/tests.sh'
        //         }
        //     }
        // }
        // stage('docker image build') {
        //     steps {
        //         script {
        //             app = docker.build("release_${env.BUILD_NUMBER}", ".")
        //         }
        //     }
        // }
        // stage('docker image push') {
        //     steps {
        //         script {
        //             docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
        //                 app.push("${env.BUILD_NUMBER}")
        //                 app.push("latest")
        //                 echo "Pushed!"
        //             }
        //         }
        //     }
        // }
    }

    post {
        success {
            echo 'Image built and pushed successfully!'
        }
    }
}
