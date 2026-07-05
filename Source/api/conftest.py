import pytest

@pytest.fixture
def cache_path():
    return "~/.android/cache"





"""
conftest.py
------------
Este archivo es especial para pytest: NO se importa manualmente en ningún
test, pytest lo detecta solo.

Sirve para dos cosas:

1. Arreglar los imports de los tests.
   Al existir este archivo en 'source/api/', pytest agrega esa carpeta
   al path de Python. Por eso los tests pueden hacer:
       from core.algo import funcion
   sin dar "ModuleNotFoundError: No module named 'core'".

2. Definir fixtures compartidas entre varios tests.
   Una fixture es una función que prepara algo (datos, rutas, conexiones)
   y se lo pasa a un test cuando este la pide como parámetro.
   Ejemplo:

       @pytest.fixture
       def cache_path(tmp_path):
           return tmp_path

   Cualquier test que tenga un parámetro llamado 'cache_path' recibirá
   automáticamente lo que devuelva esta función. No hace falta importarla.

Regla de oro: si un test pide un parámetro que no está definido dentro
de la propia función, pytest asume que es una fixture y la busca aquí.
"""

