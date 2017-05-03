node('testslave') {
  checkout scm
  env.PATH = "${tool 'Maven3'}/bin:${env.PATH}"
  stage('Package') {
    sh 'mvn clean package -DskipTests'
  }

  stage ('Docker Build') {
    //Make sure Jenkins master has a Docker global tool defined named 'default'
    docker.withTool('default') {
      withDockerServer([credentialsId: "docker-host-certificate-authentication", uri: "tcp://192.168.40.188:2376"]) {
        //Print out the current environment variables
        sh "printenv" 
        //Print out which images are available
        sh "docker images" 
        //The next command will build the Dockerfile in the current directory which is the workspace.
        image = docker.build("helloworld") 
        //Run the image and map port in parameter hostPort to the containers 8080 port
        image.run("-p ${env.hostPort}:8080")
      }
    }
  }
}
