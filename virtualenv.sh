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
cp $TOOLS_PATH/.gitconfig $HOME
cp -R $TOOLS_PATH/.atom $HOME

virtualenv $ENV_NAME

if [ $? -eq 0 ]; then
    source $PWD/$ENV_NAME/bin/activate
    python3 -m pip install --upgrade pip
    pip3 install -r $TOOLS_PATH/requirements.txt

    ansible-playbook $TOOLS_PATH/hashicorp.yml 

    echo "-----------------"
    echo "Run: source $PWD/$ENV_NAME/bin/activate"
    echo "-----------------"
    grep -qxF "source $PWD/$ENV_NAME/bin/activate" $HOME/.bashrc || echo "source $PWD/$ENV_NAME/bin/activate" >> $HOME/.bashrc
    
else
    echo "Install python3-pip && pip3 install virtualenv"
fi
 