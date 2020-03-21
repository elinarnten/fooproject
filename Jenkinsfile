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
                sh 'newman run Restful_Booker_Facit.postman_collection.json --environment Restful_Booker.postman_environment.json --reporters junit'
            }
            post {
                always {
                        junit '**/*xml'
                    }
                }
        }