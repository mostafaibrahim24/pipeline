pipeline {
    agent any
    tools {
        maven 'maven-399'
    }
    stages {
        stage("Checkout SCM"){
            steps{
                git branch: 'main', url: 'https://github.com/mostafaibrahim24/pipeline.git'
            }
        }
        stage("Build"){
            steps{
                sh 'mvn clean package'
            }
        }
        stage("Check Dependencies"){
            steps{
                dependencyCheck additionalArguments: '', odcInstallation: 'owasp-dc'
            }
        }
        stage("Run Tests"){
            steps{
                sh 'mvn test'
            }
        }
        stage("Coverage"){
            steps{
                jacoco( 
                    execPattern: 'target/*.exec',
                    classPattern: 'target/classes',
                    sourcePattern: 'src/main/java',
                    exclusionPattern: 'src/test*'
                )
            }
        }
        


    }
}