pipeline {
    agent any

    stages {
        stage('Build Docker image') {
            steps {
                sh 'docker build . -t weather_app:v1.2 ' 
            }
        }

        stage('Run Docker container') {
            steps {
                script {
                    echo "hello"
                }
            }
        }
    }
}
