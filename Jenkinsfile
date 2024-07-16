pipeline {
    agent any

    stages {
        stage('Clone repository') {
            steps {
                // Replace 'your-repo-url' with your actual repository URL
                git 'https://github.com/Weather-AP/World_Weather'
            }
        }

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
