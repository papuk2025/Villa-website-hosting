
pipeline {
    agent { label 'vinod' }

    environment {
        IMAGE_NAME = 'villa-website'
        CONTAINER_NAME = 'villa-website-container'
        PORT = '8000'
    }

    stages {
        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Clone Repository') {
            steps {
                sh '''
                    git clone https://github.com/devilraj98/Villa-website-hosting.git
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    cd Villa-website-hosting
                    docker build -t ${IMAGE_NAME} .
                '''
            }
        }

        stage('Stop Existing Container') {
            steps {
                sh "docker rm -f ${CONTAINER_NAME} || true"
            }
        }

        stage('Run Container') {
            steps {
                sh "docker run -d --name ${CONTAINER_NAME} -p ${PORT}:80 ${IMAGE_NAME}"
            }
        }
    }

    post {
        success {
            echo "✅ Site deployed at http://<vinod-IP>:${PORT}"
        }
        failure {
            echo "❌ Deployment failed."
        }
    }

}

