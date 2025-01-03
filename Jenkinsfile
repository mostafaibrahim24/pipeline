pipeline {
    agent any
    tools {
        maven 'maven-399'
        jdk 'jdk11'
    }
    environment{
        SONARQUBE_TOKEN = credentials('sonarqube-token')
        SONARQUBE_PROJECT = "pipelineProject"
        SONARQUBE_URL = credentials('sonarqube-url')
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
        stage ('Check secrets') {
            steps {
                sh 'docker run  gesellix/trufflehog --json https://github.com/mostafaibrahim24/pipeline.git > trufflehog.json'

                script {
                    def jsonReport = readFile('trufflehog.json')
                    
                    def htmlReport = """
                    <html>
                    <head>
                        <title>Trufflehog Scan Report</title>
                    </head>
                    <body>
                        <h1>Trufflehog Scan Report</h1>
                        <pre>${jsonReport}</pre>
                    </body>
                    </html>
                    """
                    
                    writeFile file: 'scanresults/trufflehog-report.html', text: htmlReport
                }
                
                archiveArtifacts artifacts: 'scanresults/trufflehog-report.html', allowEmptyArchive: true
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
        stage("SAST and Quality checks using Sonarqube"){
            steps{
                sh '''
                    mvn sonar:sonar -Dsonar.url=$SONARQUBE_URL \
                                    -Dsonar.login=$SONARQUBE_TOKEN \
                                    -Dsonar.projectName=$SONARQUBE_PROJECT -Dsonar.java.binaries=. -Dsonar.projectKey=$SONARQUBE_PROJECT'''
            }
        }


    }
}