# django-starter

### Run with docker compose
```shell
docker compose up --build api
```

### Build container
```shell
docker build --progress=plain -t django-starter .
```

### Run container
```shell
docker run -p 8001:8000 django-starter
```
