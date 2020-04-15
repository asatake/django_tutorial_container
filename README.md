# Django Tutorial Container

## 概要

django tutorial のためのコンテナ群  
[https://docs.djangoproject.com/ja/2.1/intro/](https://docs.djangoproject.com/ja/2.1/intro/)

## 起動方法

```sh
$ ./init.sh
$ docker-compose up -d
```

多分 `http://localhost:8090` で django プロジェクトが起動できてると思う

プロジェクトの作成までを行っているので、チュートリアルはその続きからやりましょう

## Tips

### DB に関して

DB を postgresql にしているので、以下のファイルを変更しておいてください。。

- app/mysite/mysite/settings.py

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}
```

↑これを↓のようにする

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'django_p',
        'HOST': 'postgres',
        'USER': 'postgres',
        'PASSWORD': '',
        'PORT': 5432
    }
}
```

### admin 関連

多分 admin 開こうとすると static が読み込まれないやつになるので、  
作業中に以下を追加すると良い

- app/mysite/mysite/settings.py

```python
STATIC_URL = '/static/'
STATIC_ROOT = '/static/'
STATIC_DIR = os.path.join(BASE_DIR, 'static')
```

- app/mysite/mysite/urls.py

```python
from django.conf import settings
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path

urlpatterns = [
    path('admin/', admin.site.urls),
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)

```

そのうえで、

```bash
$ docker-compose exec app python manage.py collectstatic
```

をする
