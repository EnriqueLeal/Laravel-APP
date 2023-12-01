FROM aguedomeza/centos7:php-apache-openssl

WORKDIR /var/www/html

# Copia los archivos necesarios
COPY *.json ./
COPY artisan ./
COPY . .

# Instala todas las dependencias de Composer en un solo paso para reducir las capas
RUN composer install && \
    composer require \
    symfony/psr-http-message-bridge \
    nyholm/psr7 \
    firebase/php-jwt:6.4.0 \
    barryvdh/laravel-dompdf \
    maatwebsite/excel \
    ramsey/uuid:^4.7 
    #laravel/telescope

# Agrega el proveedor de servicios en config/app.php
RUN sed -i '/App\\Providers\\RouteServiceProvider::class,/a \
    Barryvdh\\DomPDF\\ServiceProvider::class,' config/app.php
# Publica los archivos de configuración y vistas de Dompdf.
RUN php artisan vendor:publish --provider="Barryvdh\DomPDF\ServiceProvider" --tag=config
RUN php artisan vendor:publish --provider="Maatwebsite\Excel\ExcelServiceProvider" --tag=config
RUN cp .env.example .env
RUN php artisan key:generate
RUN chown -R 775 public
RUN chown -R apache.apache public
RUN chown -R $USER:apache public
RUN chmod -R 775 storage
RUN chmod -R ugo+rw storage
RUN chmod -R ugo+rw bootstrap
RUN chmod -R 777 bootstrap


EXPOSE 80

CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
