node('testslave') {
  checkout scm
  env.PATH = "${tool 'Maven3'}/bin:${env.PATH}"
  stage('Package') {
    sh 'mvn clean package -DskipTests'
  }
}
