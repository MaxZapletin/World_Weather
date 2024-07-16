FROM python:3.8-alpine

COPY ./requirements.txt /app/requirements.txt
COPY ./app.py /app/app.py
COPY ./templates/ /app/templates/

WORKDIR /app

RUN pip install -r requirements.txt

ENTRYPOINT [ "python" ]

CMD ["app.py" ]

