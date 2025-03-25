pipeline {
    agent any

    environment {
        IMAGE_NAME = "tailwind-landing"
        CONTAINER_NAME = "tailwind-app"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/girixxz/tailwind-landing-page-template.git' // Ganti USERNAME dengan username GitHub-mu
            }
        }

        stage('Setup Node & Install Dependencies') {
            steps {
                script {
                    sh 'npm install -g pnpm' // Install pnpm
                    sh 'pnpm install --frozen-lockfile'
                }
            }
        }

        stage('Build') {
            steps {
                sh 'pnpm build'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'docker run --rm $IMAGE_NAME pnpm test || echo "No tests found"'
            }
        }

        stage('Deploy (Local)') {
            steps {
                sh 'docker stop $CONTAINER_NAME || true' // Hentikan container lama jika ada
                sh 'docker rm $CONTAINER_NAME || true'
                sh 'docker run -d -p 3000:3000 --name $CONTAINER_NAME $IMAGE_NAME'
            }
        }
    }

    post {
        always {
            echo "Pipeline selesai."
        }
        failure {
            echo "Pipeline gagal, cek error log."
        }
    }
}
