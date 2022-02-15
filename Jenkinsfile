pipeline {
    agent { label 'jenkins-slave' }
    stages {
        stage('Build') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-login', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                        sh """
                            docker build -t abdelrahman58/final-project-iti .
                            docker login -u '${USERNAME}' -p '${PASSWORD}'
                            docker push abdelrahman58/final-project-iti
                        """
                    }

                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'k8s', variable: 'Secretfile')]) {
                        sh """
                            kubectl apply -f Backend.yaml --namespace=jenkins --kubeconfig=$Secretfile
                        """
                    }
                }
                }
            }
        }
}
