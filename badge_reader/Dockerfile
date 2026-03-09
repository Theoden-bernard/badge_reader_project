# Image of elixir
FROM elixir:1.18

RUN apt-get update \
    && apt-get install -y nodejs npm \
    && rm -rf /var/lib/apt/list/* \
    && apt-get update && apt-get install -y inotify-tools

# Working directory 
WORKDIR /app

RUN ls -a 

# Copy my file -> conteneur
COPY . .
# COPY assets config deps lib priv test .formatter.exs AGENTS.md mix.exs mix.lock ./

# Bash command
RUN set -xe \
&& mix local.hex --force \
&& mix archive.install hex phx_new --force \
&& mix deps.get \
&& mix deps.compile

RUN MIX_ENV=prod mix compile

RUN mix assets.deploy \
    && mix phx.digest

#CMD ["iex", "-S", "mix"]
CMD ["mix", "phx.server"]
#CMD ["ls", "/app"]