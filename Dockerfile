FROM python:3.12-slim AS build

RUN apt update && \
    apt upgrade && \
    apt install -y curl apt-utils libdigest-sha-perl

RUN curl -sSLO https://pdm-project.org/install-pdm.py
RUN curl -sSL https://pdm-project.org/install-pdm.py.sha256 | shasum -a 256 -c -
# Run the installer
RUN python3 install-pdm.py

RUN ~/.local/bin/pdm self add pdm-version

COPY . .
RUN ~/.local/bin/pdm version > version.txt

RUN ~/.local/bin/pdm sync
RUN ~/.local/bin/pdm build


FROM python:3.12-slim
COPY --from=build ./dist/* .
COPY --from=build version.txt .
RUN pip install django_starter-$(cat version.txt)-py3-none-any.whl

CMD ["gunicorn", "django_starter.config.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "1"]
