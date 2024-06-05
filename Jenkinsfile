pipeline {
    agent any
    tools {
        maven 'Maven'
    }   
    stages {
        
        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
                
            }
        }
        stage('Build Docker image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                 
                  sh 'docker login -u $USERNAME -p $PASSWORD'
    // Your Docker commands using the environment variables
                    
                  // Access JAR file path dynamically (if environment variable not set)
                   //jarFilePath = 'target/*.jar'   
                   // def pomFile = readMavenPom project: '.'
                    //def appName = pomFile.getName()
                  
                  sh "docker build -t wordapi:latest -f Dockerfile --build-arg JAR_FILE=target/wordapi.jar ."
                
                 //sh 'docker build -t wordapi:${BUILD_NUMBER} .'
                  sh 'docker tag wordapi:latest dkfolefac/wordapi:${BUILD_NUMBER}'
                  sh 'docker push dkfolefac/wordapi:${BUILD_NUMBER}'
                     
                     
                }
            }     
        }
    }
}    
