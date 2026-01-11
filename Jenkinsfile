pipeline {
    agent any
    environment {
        IMAGE = 'wejdentrabelsi9/dockerjenkins2'
        TAG = "build-${env.BUILD_NUMBER}"
    }
    stages{
        stage('checkout') {
            steps {
                checkout scm 
            }
        }
        stage('build') {
            steps {
                bat 'docker version'
                bat 'docker build -t %IMAGE%:%TAG% .'
            }
        }
        stage('smoke test') {
            steps {
                bat '''
                docker rm -f myapp_test 2<null || ver>nul
                docker run -d --name myapp_test -p 8081:80 %IMAGE%:%TAG%
                ping -n 3 12.0.0.1 >nul
                curl -I http://localhost8081 |find "200 OK"
                docker rm -f monapp_test
                '''
            }
        }
        stage('push sur dockerhub') {
            steps {
                withCredentials([usernamePassword(credentialsId:'dockerhub-creds', usernameVariable:'USER', passwordVariable:'PASS')]) {
                    bat """
                    echo %PASS% | docker login -u %USER% --password-stdin
                    docker tag %IMAGE%:%TAG% %IMAGE%:latest
                    docker push %IMAGE%:%TAG%
                    docker push %IMAGE%:latest
                    """
                }
            }
        }
        post {
            success { echo 'yeehaw' }
            failure { echo 'should i call u a waambliance' }
        }



        




    }





}