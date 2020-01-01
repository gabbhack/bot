FROM python:3.7-slim-buster as production
LABEL maintainer="Alex Root Junior <jroot.junior@gmail.com>" \
      description="Telegram Bot"

ENV PYTHONPATH "${PYTHONPATH}:/app"
ENV PATH "/app/scripts:${PATH}"

EXPOSE 80
WORKDIR /app

COPY poetry.lock /app/
COPY pyproject.toml /app/
RUN pip install poetry && \
    poetry install --no-dev
ADD . /app/
RUN chmod +x scripts/* && \
    poetry run pybabel compile -d locales -D bot

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["run-webhook"]
