pipeline {
  agent {
    node {
      label 'workstation'
    }
  }
  stages {
    stage('Docker build') {
     steps {
       sh 'docker build -t docker.io/tejaswinidockerhub/devops-schema-loading .'
       }
     }
    stage('Docker push') {
      steps {
        sh 'docker push docker.io/tejaswinidockerhub/devops-schema-loading'
      }
    }
  }
}
