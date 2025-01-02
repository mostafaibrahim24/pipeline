pipeline {
    agent any
    stages {
        stage("Install Dependencies"){
            steps{
                dir("solar-system-app"){
                    sh 'npm install'
                }
            }
        }
        stage("Run Unit Tests"){
            steps{
                dir("solar-system-app"){
                    sh 'npm run test'
                }
            }
        }
        stage("Code Coverage"){
            steps{
                dir("solar-system-app"){
                    sh 'npm run coverage'
                }
            }
        }

    }
}