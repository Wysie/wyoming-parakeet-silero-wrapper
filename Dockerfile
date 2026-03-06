FROM python:3.13

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

RUN apt-get update && apt-get -y install ffmpeg

COPY pyproject.toml uv.lock ./
RUN --mount=type=cache,target=/root/.cache/uv uv sync --frozen --no-dev

COPY . .

VOLUME [ "/root/.cache/huggingface" ]

ENTRYPOINT ["uv", "run", "python3", "wyoming_vad_asr_server.py"]
