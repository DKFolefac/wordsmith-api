pipeline {
    agent any
    tools {
        maven 'maven'
    }   
    stages {
        
        stage('Build with Maven') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/damienmwene/wordsmith-api.git']])
                sh 'mvn clean install'
            }
        }
        stage('Build Docker image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                 
                  sh 'docker login -u $USERNAME -p $PASSWORD'
    // Your Docker commands using the environment variables
                    
                  sh "docker build -t wordapi:v1 -f Dockerfile ."
                
                 //sh 'docker build -t wordapi:${BUILD_NUMBER} .'
                  sh 'docker tag wordapi:v1 dkfolefac/wordapi:${BUILD_NUMBER}'
                  sh 'docker push dkfolefac/wordapi:${BUILD_NUMBER}'
                     
                     
                }
            }     
        }
    }
}    
