#!/bin/bash

# @author  persi@sixsir.com
# @version 1.0.0
# @date    2016-12-28
# @description Used to switch the PHP version

# Switch version list  (version,php base path)
PHP_VERSION_PATH=("php7" "/usr/local/php7" "dev" "/usr/local/php7dev" "php56" "/usr/local/Cellar/php56/5.6.27_4")

CheckFile()
{
    FILE_LIST=($1 $2 $3)
    for FILE in "${FILE_LIST}"; do
        if [ ! -e ${FILE} ];
            then
                echo -e ${FILE}" file does not exist ！\\n"
                exit 0
        fi
        if [ ! -x ${FILE} ];
            then
                echo -e ${FILE}" No running rights ！\\n"
                exit 0
        fi
    done
}

ReconstructionLink()
{
    rm -rf "/usr/local/bin/php"
    rm -rf "/usr/local/bin/phpize"
    rm -rf "/usr/local/bin/php-config"
    ln -s $1 "/usr/local/bin/php"
    ln -s $2 "/usr/local/bin/phpize"
    ln -s $3 "/usr/local/bin/php-config"
    echo "PHP version switch is successful, the current version is "
    echo -e `/usr/local/bin/php -v`"\\n"
    exit 0
}

PHP_VERSION=$1

if [ ! ${PHP_VERSION} ];
    then
        echo -e "Please enter the PHP version you need to switch .\\n"
        exit 0
fi

PHP_VERSION_EXIST=

for PHP_PATH in "${!PHP_VERSION_PATH[@]}"; do
    if [ "${PHP_VERSION_PATH[$PHP_PATH]}" = "${PHP_VERSION}" ];
        then
            PHP_VERSION=1
            PHPBIN_PATH=${PHP_VERSION_PATH[$PHP_PATH+1]}"/bin/php"
            PHPIZE_PATH=${PHP_VERSION_PATH[$PHP_PATH+1]}"/bin/phpize"
            PHPCONFIG_PATH=${PHP_VERSION_PATH[$PHP_PATH+1]}"/bin/php-config"
            CheckFile ${PHPBIN_PATH} ${PHPIZE_PATH} ${PHPCONFIG_PATH}
            ReconstructionLink ${PHPBIN_PATH} ${PHPIZE_PATH} ${PHPCONFIG_PATH}
    fi
done

if [ ! ${PHP_VERSION_EXIST} ];
    then
        echo -e "The PHP ${PHP_VERSION} version you entered does not exist.\\n"
        exit 0
fi
