pipeline {
    agent any
    tools {
        maven 'Maven'
    }
    
    environment {
        APP_NAME = "usermanagement-application-image"
        DOCKER_USER = "sureshpsl"
        DOCKER_PASS = 'docker-hub-credentials'
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Git Clone') {
            steps {
                git branch: 'main', credentialsId: 'github-credentails', url: 'https://github.com/sureshdevopsaws/usermanagement.git'
            }
        }
        stage('Build Application') {
            steps {
                sh '''
                    mvn clean package -DskipTests
                '''
            }
        }
        
        stage('Build & Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }
        }
        stage('Docker-Compose Build') {
            steps {
                sh ' docker-compose build'
            }
        }
        stage('Docker-Compose Deploy') {
            steps {
                sh ' docker-compose up -d'
            }
        }
        stage('Docker-Compose Verify') {
            steps {
                sh ' docker-compose ps'
            }
        }
        stage('Clean Workspace') {
            steps {
                sh 'rm -rf *'
            }
        }
    }
}

