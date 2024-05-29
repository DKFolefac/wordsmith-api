pipeline {
    agent any
    tools {
        maven 'maven'
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
                 sh 'docker build -t wordsapi:${BUILD_NUMBER} .'
                sh 'docker tag wordsapi:${BUILD_NUMBER} dkfolefac/wordsapi:${BUILD_NUMBER}'
                sh 'docker push dkfolefac/wordsapi:${BUILD_NUMBER}'
            }
        }
    }
    }
}
