pipeline {
    agent any

    stages {
        stage('Build Docker image') {
            steps {
                sh 'docker build -t weather_app:v1.2 .' 
            }
        }

        stage('Run Docker container') {
            steps {
                script {
                    dockerImage.run("-p 5000:5000")
                }
            }
        }
    }
}
