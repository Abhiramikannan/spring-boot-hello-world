pipeline {
    agent any
 
    stages {
        stage('Git Cloning') {
            steps {
                // Clone code from the GitHub repository
                git branch: 'Feature', url: 'https://github.com/Abhiramikannan/spring-boot-hello-world.git'
            }
        }
 
        stage('Build JAR File') {
            steps {
                // Download dependencies
                sh 'mvn dependency:go-offline'
                // Build the project, skipping tests
                sh 'mvn clean package -DskipTests'
            }
        }
    }
