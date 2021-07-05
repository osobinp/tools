#!/bin/bash

ENV_NAME=env

BASE_PATH=`basename $0`

if [ "echo $0 | cut -c1" = "/" ]; then
 TOOLS_PATH=`dirname $0`
else
 TOOLS_PATH=`pwd`/`echo $0 | sed -e s/$BASE_PATH//`
fi

cp $TOOLS_PATH/.bashrc $HOME
cp $TOOLS_PATH/.vimrc $HOME
cp -R $TOOLS_PATH/.atom $HOME

virtualenv $ENV_NAME

if [ $? -eq 0 ]; then
    source $PWD/$ENV_NAME/bin/activate
    python -m pip install --upgrade pip
    pip install -r $TOOLS_PATH/requirements.txt

    ansible-playbook $TOOLS_PATH/hashicorp.yml 

    echo "-----------------"
    echo "Run: source $PWD/$ENV_NAME/bin/activate"
    echo "-----------------"
else
    echo "Install python-pip && pip install virtualenv"
fi
 