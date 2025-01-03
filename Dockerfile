FROM ubuntu:22.04

ENV PYTHONUNBUFFERED=1 LC_ALL=C.UTF-8 LANG=C.UTF-8 FLASK_APP=app.py

EXPOSE 5000

RUN apt update && \
    apt install -y python3 python3-distutils unzip wget

RUN wget -q https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py && \
    python3 /tmp/get-pip.py pip setuptools wheel --no-cache-dir

RUN python3 -m pip install https://github.com/Supervisor/supervisor/archive/master.zip --no-cache-dir && \
    mkdir -p /var/log/supervisor /etc/supervisor/conf.d/

RUN mkdir /app
RUN python3 -m pip install flask requests -U

ADD ./app.py /app/app.py

COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY flask.conf /etc/supervisor/conf.d/flask.conf
ENTRYPOINT ["supervisord", "-c", "/etc/supervisor/supervisord.conf"]

RUN  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
