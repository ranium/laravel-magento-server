server {
       listen 80;
       listen [::]:80;
       # SSL CONFIGS
       # listen 443 ssl;
       # listen [::]:443 ssl;
       # include snippets/self-signed.conf;
       # include snippets/ssl-params.conf;

        server_name ~^(?<subdomain>\w+)\.php72\.com$;
        root /var/www/$subdomain;
        index index.php;


        location ~* \.php$ {
                # With php-fpm unix sockets
                fastcgi_pass    unix:/run/php/php7.2-fpm.sock;
                include         fastcgi_params;
                fastcgi_param   SCRIPT_FILENAME    $document_root$fastcgi_script_name;
                fastcgi_param   SCRIPT_NAME        $fastcgi_script_name;
        }
}

