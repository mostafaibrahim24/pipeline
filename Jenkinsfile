pipeline {
    agent any
    stages {
        stage("Install Dependencies"){
            steps{
                sh 'npm install'
            }
        }
        stage("Build"){
            steps{
                sh './build-check.sh'
            }
        }
        stage("Run Unit Tests"){
            steps{
                sh 'npm run test'
            }
        }
        stage("Code Coverage"){
            steps{
                sh 'npm run coverage'
            }
        }

    }
}