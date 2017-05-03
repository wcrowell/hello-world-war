node('testslave') {
  checkout scm
  env.PATH = "${tool 'Maven3'}/bin:${env.PATH}"
  stage('Package') {
    sh 'mvn clean package -DskipTests'
  }

  stage ('Docker Build') {
    // prepare docker build context
    sh "cp target/hello-world.war ./tmp-docker-build-context"

    docker.withTool('default') {
        withDockerServer([credentialsId: "docker-host-certificate-authentication", uri: "tcp://192.168.40.188:2376"]) {
	   sh "printenv" 
	   sh "docker images" 
	   //image = docker.build("williamcrowell/helloworld") 
	   //image.push("tmp-fromjenkins") 
           //image.run('-p 5000:8080')
	   //image.stop()
	}
    }

    // Build and push image with Jenkins' docker-plugin
    //docker.withServer([uri: "tcp://192.168.40.188:2376"],) {
        // we give the image the same version as the .war package
        //def image = docker.build("williamcrowell/helloworld:1.0", "--build-arg PACKAGE_VERSION=1.0 ./tmp-docker-build-context")
        //image.run()
    //}
  }
}
