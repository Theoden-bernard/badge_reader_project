# test of prog elixir
FROM elixir:1.18 AS validator

RUN apt-get update \
    && apt-get install -y nodejs npm \
    && rm -rf /var/lib/apt/list/* \
    && apt-get update && apt-get install -y inotify-tools

# Working directory 
WORKDIR /app

# Copy my file -> conteneur
COPY . .

ENV MIX_ENV="test"


# Bash command
RUN set -xe \
&& mix local.hex --force \
&& mix archive.install hex phx_new --force \
&& mix deps.get \
&& mix deps.compile

RUN mix compile

RUN mix quality

# Image of elixir
FROM elixir:1.18 AS runner

RUN apt-get update \
    && apt-get install -y nodejs npm \
    && rm -rf /var/lib/apt/list/* \
    && apt-get update && apt-get install -y inotify-tools

# Working directory 
WORKDIR /app

# Copy my file -> conteneur
COPY . .

ENV MIX_ENV="prod"


# Bash command
RUN set -xe \
&& mix local.hex --force \
&& mix archive.install hex phx_new --force \
&& mix deps.get \
&& mix deps.compile

RUN mix compile

RUN cd assets && npm install

RUN mix assets.deploy \
    && mix phx.digest

CMD ["mix", "phx.server"]

