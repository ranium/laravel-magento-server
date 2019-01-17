# Laravel|Magento server
A simple script which helps you quickly setup Laravel and Magento environment on your **native local server**. 
No need to run your project on Homestead's virtual environment, which is Tedious and Exhaustive.
## Developed By 
[![N|Ranium](https://d1vxlv5w7jsf3o.cloudfront.net/wp-content/uploads/2018/10/24121043/ranium-logo-black.png)](https://ranium.in/)
##
# New Features!

  - Relatively fast than homestead environment 
  - No need to add virtual host, it's already done.
  - Supports PHP &nbsp; *5.6 &nbsp; 7.0 &nbsp; 7.1 &nbsp; 7.2 &nbsp; 7.3*
  - Clone project, run laravel/magento commands and Done!


### Installation

First, clone the project from github, then 

```sh
$ cd laravel-magento-server
$ sudo sh scripts/provision.sh <sample_project_name_to_test>
```
Let the script install all the packages for you which are required to start working with Laravel/Magento.

### Project setup

Drop your Laravel/Magento project in */var/www/<project>*
Run commands with any php version you want, like if 7.1  
*php7.1 composer install*
.
.
```sh 
$ phpx.x composer install
$ phpx.x bin/magento ....
```

But wait, what about the **domain name** we have to enter. 
Guess what, your project name is your domain name !!

Lets say if you've setup laravel project with php7.2 version, then your domain name will be - 
```
<project-name>.frontendphp72.co.uk
```
and if you've setup magento project with php7.1, then domain name will be - 
```
<project-name>.backendphp71.com
```
You'll get the idea by referring following table:-

| PHP Version | Magento Domain | Laravel Domain | 
| ------ | ------ | ----- |
| 5.6 | <project-name>.backendphp56.com | <project-name>.frontendphp56.co.uk
| 7.0 | <project-name>.backendphp70.com | <project-name>.frontendphp70.co.uk
| 7.1 | <project-name>.backendphp71.com | <project-name>.frontendphp71.co.uk
| 7.2 | <project-name>.backendphp72.com | <project-name>.frontendphp72.co.uk
| 7.3 | <project-name>.backendphp73.com | <project-name>.frontendphp73.co.uk
