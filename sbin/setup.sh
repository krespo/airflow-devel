#!/bin/bash

## check homebrew, direnv installed
command -v brew > /dev/null 2>&1 || { echo >&2 "Homebrew가 설치되지 않았습니다. Homebrew를 먼저 설치해 주세요."; exit 1;  }
command -v direnv > /dev/null 2>&1 || { echo >&2 "direnv가 설치되지 않았습니다. direnv를 먼저 설치해 주세요."; exit 1;  }

AIRFLOW_HOME=$( cd "$(dirname "$0")/../" ; pwd )


## create .envrc
printf 'layout python\nexport AIRFLOW_HOME='$AIRFLOW_HOME > $AIRFLOW_HOME/.envrc

direnv allow
eval "$(direnv hook bash)"

## airflow installation
echo '[Install] pip install Airflow'
pip install -r ${AIRFLOW_HOME}/requirements.txt > /dev/null
echo '[Success] pip install Airflow'

## airflow initialize
airflow initdb

echo -e "\033[0;33m##############[[[[ 설정 완료 ]]] #########################\033[0m"
echo -e "\033[0;33mairflow.cfg를 수정하고 실행하세요\033[0m"
