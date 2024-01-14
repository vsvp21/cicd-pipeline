pipeline {
  agent any
  stages {
    stage('build') {
      steps {
        sh 'scripts/build.sh'
      }
    }

    stage('test') {
      steps {
        sh 'scripts/test.sh'
      }
    }

  }
}