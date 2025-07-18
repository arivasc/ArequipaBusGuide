FROM ghcr.io/osgeo/gdal:ubuntu-full-3.8.4

# Instala Python 3.12, pip y dependencias del sistema
RUN apt-get update && apt-get install -y \
    python3.10 python3.10-dev python3-pip \
    libpq-dev build-essential \
    && ln -s /usr/bin/python3.10 /usr/local/bin/python \
    && python -m pip install --upgrade pip

# Establece directorio de trabajo
WORKDIR /app

# Copia e instala tus dependencias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia el código fuente de tu proyecto
COPY . .

# Expone el puerto 
EXPOSE 8000

# Comando para producción: gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "ArequipaBusGuide.wsgi:application"]
