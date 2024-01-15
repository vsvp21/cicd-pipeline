pipeline {  
  agent any

  stages {
    stage('Git checkout') {
      steps {
        sh '${scm}'
      }
    }

    stage('app build') {
      agent {
        docker {
          image 'node:lts-alpine'
        }
      }
      steps {
        sh '''chmod +x scripts/build.sh
sh scripts/build.sh'''
      }
    }

    stage('app tests') {
      agent {
        docker {
          image 'node:lts-alpine'
        }
      }
      steps {
        sh '''chmod +x scripts/test.sh
scripts/test.sh'''
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
          docker.withRegistry('https://registry.hub.docker.com') {
            def image = docker.image("${repositoryName}");
            image.push()
          }
        }

      }
    }

  }
  environment {
    registryCredential = 'docker.registry'
  }
  post {
    success {
      echo 'Image built and pushed successfully!'
    }

  }
  options {
    skipDefaultCheckout(true)
  }
}
