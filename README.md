# Laravel|Magento server
A simple script which helps you quickly setup Laravel and Magento environment on your **local machine**. 
No need to run your project on Homestead's virtual environment, which is Tedious and Exhaustive.

## Developed By :computer:
[![N|Ranium](https://d1vxlv5w7jsf3o.cloudfront.net/wp-content/uploads/2018/10/24121043/ranium-logo-black.png)](https://ranium.in/)

##
### Features

  - Relatively fast than homestead environment 
  - No need to add virtual host, it's already done
  - Supports PHP &nbsp; *5.6 &nbsp; 7.0 &nbsp; 7.1 &nbsp; 7.2 &nbsp; 7.3*
  - Clone project, run laravel/magento commands and That's all!


### Installation :rocket:

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
| 5.6 | {project-name}.backendphp56.com | {project-name}.frontendphp56.co.uk
| 7.0 | {project-name}.backendphp70.com | {project-name}.frontendphp70.co.uk
| 7.1 | {project-name}.backendphp71.com | {project-name}.frontendphp71.co.uk
| 7.2 | {project-name}.backendphp72.com | {project-name}.frontendphp72.co.uk
| 7.3 | {project-name}.backendphp73.com | {project-name}.frontendphp73.co.uk



### Libraries & Packages :books:
Following is the list of Libraries & Packages which gets install along with environment setup.

* [Nginx]
* [Node]
* [SQLite]
* [MySQL]
* [PostgreSQL]
* [Blackfire]
* [Zend Z-Ray]
* [Memcached]
* [MailHog]
* [Supervisor]
* [Ngrok]
* [FlyWay]
* [Ruby]
* [Postfix]
* [GoLang]

### Contributing 

If you have any issue or idea which you want to share, [please open an issue].
If you'd like to contribute, please fork the repository. Pull requests are warmly welcome.

### Contributors :stars:

This script is heavily inspired by [Laravel-Settler], most of the script content is copied from that only.
 
### License







   [Nginx]: <https://www.nginx.com/>
   [Node]: <https://nodejs.org/en/>
   [SQLite]: <https://www.sqlite.org/index.html>
   [MySQL]: <https://www.mysql.com/>
   [PostgreSQL]: <https://www.postgresql.org/>
   [Blackfire]: <https://blackfire.io/>
   [Zend Z-Ray]: <http://www.zend.com/en/products/server/z-ray>
   [Memcached]: <https://memcached.org/>
   [MailHog]: <https://github.com/mailhog/MailHog>
   [Supervisor]: <http://supervisord.org/>
   [Ngrok]: <https://ngrok.com/>
   [FlyWay]: <https://flywaydb.org/>
   [Ruby]: <https://www.ruby-lang.org/en/>
   [Postfix]: <http://www.postfix.org/>
   [GoLang]: <https://golang.org/>
   [please open an issue]: <https://github.com/ranium/laravel-magento-server/issues>
   [Laravel-Settler]: <https://github.com/laravel/settler>



