pipeline {
         agent any
          stages {
                  
                  stage('Sonarqube') {
                   environment {
        scannerHome = tool 'SonarQubeScanner'
    }                  
        steps {
        withSonarQubeEnv('sonarqube') {
            sh "${scannerHome}/bin/sonar-scanner"
        }                                            
    }
              }
          }

node {
    def app

    stage('Clone repository') {      
        checkout scm
    }

    stage('Build image') {
        app = docker.build("xephos223/coursework_2")
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}
