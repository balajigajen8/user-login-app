FROM php:8.3-fpm

# Install dependencies
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip git

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www

# Copy existing application directory
COPY . .

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd && \
    docker-php-ext-install pdo pdo_mysql

# Expose port 80
EXPOSE 80

CMD ["php-fpm"]
