function command_exists {
    command -v $1 > /dev/null;
}

echo $(dirname $0)

# change dir to this script dir.
cd `dirname $0`

if [ -d app ];then
    exit 1;
fi

if [ ! command_exists pyenv ];then
    echo <<EOF
Warning: pyenv has not installed.
         Please install pyenv and pyenv-virtualenv.
         https://github.com/pyenv/pyenv
         https://github.com/pyenv/pyenv-virtualenv

EOF
    exit 1;
fi

mkdir app
cd app;

pyenv versions | grep 3.5.6

if [ $? -eq 1 ];then
    pyenv install 3.5.6
fi

pyenv virtualenv 3.5.6 django-p
pyenv local django-p

pip install --upgrade pip
pip install Django

django-admin startproject mysite

cd ..
cp django.ini app/mysite/django.ini
