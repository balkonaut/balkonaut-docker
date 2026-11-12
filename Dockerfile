# Docker-App. Kern (core/) und Handbuch (docs/) kommen aus github.com/balkonaut/balkonaut, ausgecheckt im Ordner kern/
# mit demselben Tag wie dieses Repository (siehe README).
FROM python:3.12-slim AS docs
WORKDIR /build
COPY kern/pyproject.toml kern/LICENSE kern/mkdocs.yml ./
COPY kern/core core
RUN pip install --no-cache-dir ".[docs]"
COPY kern/docs docs
RUN mkdocs build --strict -d /site

FROM python:3.12-slim AS base
WORKDIR /srv
COPY kern/pyproject.toml kern/LICENSE ./
COPY kern/core core
COPY requirements.txt ./
RUN pip install --no-cache-dir . -r requirements.txt
COPY app app

FROM base AS test
RUN pip install --no-cache-dir "pytest>=9.1" "httpx2>=2.15"
COPY tests tests
RUN python -m pytest -q tests

FROM base
COPY --from=docs /site handbuch

ENV BALKONAUT_DATA=/data
VOLUME /data

EXPOSE 8000
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
