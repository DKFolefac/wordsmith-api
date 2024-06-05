pipeline {
    agent any
    tools {
        maven 'Maven'
    }   
    stages {
        
        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
                sh 'mvn help:effective-goal'
            }
        }
        stage('Build Docker image') {
            steps {
                 withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                 sh 'docker login -u $USERNAME -p $PASSWORD'
    // Your Docker commands using the environment variables
                script {     
                  // Access JAR file path dynamically (if environment variable not set)
                   jarFilePath = 'target/*.jar'    
                
                 sh 'docker build -t wordsapi:${BUILD_NUMBER} .'
                 sh 'docker tag wordsapi:${BUILD_NUMBER} dkfolefac/wordsapi:${BUILD_NUMBER}'
                 sh 'docker push dkfolefac/wordsapi:${BUILD_NUMBER}'
                }     
            }
        }
    }
    }
}
