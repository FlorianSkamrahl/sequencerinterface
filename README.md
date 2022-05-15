# Sequencerinterface

To start your Phoenix server:

  * Install Elixir `https://elixir-lang.org/install.html` 
  * Install PostgreSQL `https://www.postgresql.org/download/` with Username: postgres and Password:postgres

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * add some data to the database `mix run priv/repo/seeds.exs`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`127.0.0.1:4000/sequencerpad`](http://127.0.0.1:4000/sequencerpad) from your browser.


Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## via Docker-Compose
alternatively you can also work directly with docker-compose
  
  * build the image with `docker-compose build`
  * run with `docker-compose up`
  * create migrate and seed the database `docker-compose run elixir /app/bin/sequencerinterface eval "Sequencerinterface.Release.setup"` 
  * (optional) to create initial database for the app run the folowing script `docker-compose run elixir /app/bin/sequencerinterface eval "Sequencerinterface.Release.create"`
  * (optional) alternatively you can also log into the database via psql in a second terminal `psql -h localhost -p 6000 -d postgres -U postgres --password`
  * (optional) then migrate with `docker-compose run elixir /app/bin/sequencerinterface eval "Sequencerinterface.Release.migrate"`

if you want to jump inside the elixir debian-buster distro run

  * `docker-compose run elixir /bin/sh` 
## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


