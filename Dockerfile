FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1

WORKDIR /app
COPY requirements.txt .

# +++ ez a rész a fontos +++
RUN apt-get update && apt-get install -y --no-install-recommends \
  gcc python3-dev && \
  pip install --no-cache-dir -r requirements.txt && \
  apt-get remove -y gcc python3-dev && apt-get autoremove -y && \
  rm -rf /var/lib/apt/lists/*
# ++++++++++++++++++++++++++

COPY app.py .

RUN useradd -m appuser
USER appuser

EXPOSE 8080
CMD ["python", "app.py"]
