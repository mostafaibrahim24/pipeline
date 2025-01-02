pipeline {
    agent any
    tools {
        maven 'maven-399'
        jdk 'jdk11'
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
                dependencyCheck additionalArguments: ''' 
                    -o './'
                    -s './'
                    -f 'ALL' 
                    --prettyPrint''', odcInstallation: 'owasp-dc'
                dependencyCheckPublisher pattern: 'dependency-check-report.xml'
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
        steps("SAST and Quality checks using Sonarqube"){
            steps{
                sh '''
                    mvn sonar:sonar -Dsonar.url=https://9000-port-t47xxkn33kiiaaah.labs.kodekloud.com \
                                    -Dsonar.login=squ_89826032f06808e6f73bd927089283feead8c74e \
                                    -Dsonar.projectName=pipelineProject -Dsonar.java.binaries=. -Dsonar.projectKey=pipelineProject'''
            }
        }


    }
}