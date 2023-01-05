#!/bin/bash
set -e

package_manager="apt-get"
package_sysname="r7-office";
package_manager_update_cmd="install";
DS_COMMON_NAME="ds";	

RES_APP_INSTALLED="уже проинсталлирован";
RES_APP_CHECK_PORTS="используют порты";
RES_CHECK_PORTS="пожалуйста, убедитесь, что данные порты свободны.";
RES_INSTALL_SUCCESS="Спасибо за инсталляцию Р7-Офис. Сервер";
RES_PROPOSAL="Вы можете сконфигурировать ваш портал используя Р7-Офис. Панель управления.";
RES_QUESTIONS="Если у вас есть какие-либо вопросы вы можете связаться с нами через http://wwww.r7-office.ru"

ELASTICSEARCH_REPOSITORY="https://download.r7-office.ru/repo/centos/main/noarch/"

while [ "$1" != "" ]; do
	case $1 in	

		-u | --update )
			if [ "$2" != "" ]; then
				UPDATE=$2
				shift
			fi
		;;

		-skiphc | --skiphardwarecheck )
			if [ "$2" != "" ]; then
				SKIP_HARDWARE_CHECK=$2
				shift
			fi
		;;

		-? | -h | --help )
			echo "  Используйте $0 [PARAMETER] [[PARAMETER], ...]"
			echo "    Параметры:"
			echo "      -u, --update                      используйте для обновления существующих компонентов (true|false)"
			echo "      -?, -h, --help                    эта справка"
			echo
			exit 0
		;;

	esac
	shift
done

if [ -z "${UPDATE}" ]; then
   UPDATE="false";
fi

if [ -z "${INSTALLATION_TYPE}" ]; then
   INSTALLATION_TYPE="WORKSPACE_ENTERPRISE";
fi

if [ -z "${SKIP_HARDWARE_CHECK}" ]; then
   SKIP_HARDWARE_CHECK="false";
fi

apt-repo add "rpm http://download.r7-office.ru/repo/ALTLinux/p9 noarch r7-office"

DOWNLOAD_URL_PREFIX="https://download.r7-office.ru/repo/install-AltLinux"

curl -O ${DOWNLOAD_URL_PREFIX}/tools.sh && source tools.sh && rm tools.sh
curl -O ${DOWNLOAD_URL_PREFIX}/bootstrap.sh && source bootstrap.sh && rm bootstrap.sh
curl -O ${DOWNLOAD_URL_PREFIX}/check-ports.sh && source check-ports.sh && rm check-ports.sh
curl -O ${DOWNLOAD_URL_PREFIX}/install-preq-alt.sh && source install-preq-alt.sh && rm install-preq-alt.sh
curl -O ${DOWNLOAD_URL_PREFIX}/install-app.sh && source install-app.sh && rm install-app.sh