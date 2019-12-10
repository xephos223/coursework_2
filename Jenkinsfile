
pipeline {
   agent any

   stages {
      stage('Build') {
         steps {
            //Get code from the right branch of the repository
            git branch: 'MyBranch', url: 'https://github.com/xephos223/coursework_2/'
             
         }
      }
      
         
     stage('SonarQube') 
     {
        environment {
            scannerHome = tool 'SonarQube'
        }
        steps 
        {
            
            withSonarQubeEnv('SonarQube') {
                sh "${scannerHome}/bin/sonar-scanner"
            }
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
        app = docker.build("rthoms218/coursework")
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    } 
       stage("Deploying to Kubernetes") {
            steps {
                script {
                    sshPublisher (
                        continueOnError: false, 
                        failOnError: true,
                        publishers: [
                            sshPublisherDesc(
                                configName: "production_server",
                                verbose: true,
                                transfers: [
                                    sshTransfer(
                                        execCommand: "kubectl set image deployment/coursework_2 coursework_2=rthoms218/coursework_2:${env.BUILD_NUMBER}"
                                    )
                                ]
                            )
                        ]
                    )
                }
            }
        }
}
