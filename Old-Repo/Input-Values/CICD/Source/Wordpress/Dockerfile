FROM wordpress:latest

# Copying Themes and Plugins into the wordpress image
COPY ["themes","/usr/src/wordpress/wp-content/themes"]
COPY ["plugins","/usr/src/wordpress/wp-content/plugins"]

# Applying the execution right on the folders for apache
COPY entrypoint-child.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint-child.sh
ENTRYPOINT ["entrypoint-child.sh"]
CMD ["apache2-foreground"]

# Updating the configuration of wordpress image with our own
COPY ./config/uploads.ini /usr/local/etc/php/conf.d/uploads.ini