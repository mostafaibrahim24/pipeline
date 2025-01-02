pipeline {
    agent any
    tools {
        nodejs 'nodejs-21'
    }
    stages {
        stage("Checkout SCM"){
            steps{
                git branch: 'main', url: 'https://github.com/mostafaibrahim24/pipeline.git'
            }
        }
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