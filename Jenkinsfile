pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/elinarnten/fooproject.git'
            }
        }
    }

stage('newman') 
            steps {
                sh 'newman run RestfulBooker.postman_collection.json --RestfulBooker.postman_environment.json --reporters junit'
            }
            post {
                always {
                        junit '**/*xml'
                    }
                }
        }
