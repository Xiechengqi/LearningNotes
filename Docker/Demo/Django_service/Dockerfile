``` yaml
FROM python:3
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt -i https://pypi.douban.com/simple
COPY . /code/
```

