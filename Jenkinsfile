pipeline {

    agent any

    environment {
        IMAGE_NAME = "abhiramikannan/javaimage"
        TAG = "latest"
        config_docker_credentials_id = "1"
    }

    stages {

        stage('Git Cloning') {
            steps {
                git branch: 'main', url: 'https://github.com/Abhiramikannan/spring-boot-hello-world.git'
            }
        }

        stage('Build JAR File') {
            steps {
                sh '''
                    mvn dependency:go-offline
                    mvn clean package -DskipTests
                '''
            }
        }

        stage('Copy JAR File to Docker Context') {
            steps {
                sh '''
                    rm -f app.jar
                    cp /root/.jenkins/workspace/springboot-multibranch_master/target/*.jar app.jar
                '''
            }
        }

        stage('Login & Push Docker Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: "${config_docker_credentials_id}",
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker build -t ${IMAGE_NAME}:${TAG} .
                        docker push ${IMAGE_NAME}:${TAG}
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    kubectl delete deployment hello-world-deployment || true
                    kubectl apply -f deployment.yaml
                    kubectl apply -f service.yaml
                '''
            }
        }
    }
}
