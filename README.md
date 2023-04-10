# Symfony Project Template + docker + varnish

**🚨🚨 I tried it with a docker version 20 and didn't work , then I upgraded to 23 and it worked fine 🚨🚨**

This is a template repository for bootstrapping a Symfony project with additional PHP libraries integrated. The included libraries are:

* friendsofsymfony/http-cache-bundle
* symfony/http-client
* nyholm/psr7
* guzzlehttp/promises
* webpack

The template also includes default configuration for the httpcachebundle to get the Varnish server working.

The project runs inside a Docker stack composed of 
* PHP-FPM, 
* Caddy, 
* MySQL
* Varnish. 

**💡💡 This Docker stack is based on the [dunglas/symfony-docker](https://github.com/dunglas/symfony-docker) template.**

## Getting Started

To use this template, follow these steps:

1. Define the required environment variables in the .env file.
2. Replace the PROJECT variable in the .env file to your project name in lowercase
3. Do a search and replace in the dockerfiles directory to replace ${PROJECT} with the name of your project you inserted in the .env file . For example, if your project name is MyProject, you would replace ${PROJECT} with myproject.
   * _**That is because the variable ${PROJECT} i tried to use is not working. So I have to replace it manually.**_
4. Install the symfony app using the command: 
    ````bash
   make install
   ````
5. Build the Docker images using the command:
    ````bash
   make build
   ````
6. Run the Docker containers using the command:
    ````bash
   make up
   ````
### Contributing
If you would like to contribute to this template, please open an issue or submit a pull request on GitHub.

### License
This template is licensed under the MIT License. See the LICENSE file for details.
