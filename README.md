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
  * (optional) to create initial database for the app run the folowing script `docker-compose run elixir /app/bin/sequencerinterface eval "Sequencerinterface.Release.seeds"`

  Now you can visit [`http://sequencerinterface.local:4000/sequencerpad`](http://sequencerinterface.local:4000/sequencerpad) from your browser.

  

if you want to jump inside the elixir debian-buster distro run

  * `docker-compose run elixir /bin/sh` 
## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


## Websocket events
Websocket Path is `ws://sequencerinterface.local:4000/sequencersocket/websocket`
or local `ws://127.0.0.1:4000/sequencersocket/websocket` 

  `
  response = await websocket.recv()
  json_response = json.loads(response)
  `

### Subscribe to Websocket Channel with 
send this payload to the websocket to subscripe: 
  `{
                    "event":"phx_join",
                    "topic":"sequencer:lobby",
                    "payload": {},
                    "ref": "sequencers:one"}`

### Events 
* json_response["event"] == "updated_sequencerpad"
json_response["payload"] ==  {'color': ..., 'padid': ..., 'position': [x, y]} 

* json_response["event"] == "clear"
no payload 

* json_response["event"] == "calibrate"
json_response["payload"] ==  [{'color': ..., 'padid': ..., 'position': [x, y]} ... {'color': ..., 'padid': ..., 'position': [x, y]}]
List of all calibrated Fields 

* json_response["event"] == "delete_calibration"
no payload 

* json_response["event"] == "save_calibration"
no payload 

* json_response["event"] == "toggle_true_color"
no payload 


### Websocket Send events
Attention color must now be an rgb list to color the card as response!
Sequencer Feedback
json_response["payload"] == {'color': [r, g, b], 'padid': ..., 'position': [x, y]} 
`{
                    "event": "sequencer_feedback",
                    "topic": "sequencer:lobby",
                    "payload": json_response["payload"],
                    "ref": ""}`

Shout -> Show message over alert
payload == {"msg": ...msg Text as String ...} 
`{
                    "event": "shout",
                    "topic": "sequencer:lobby",
                    "payload": {"msg": "Calibration successful!!!"},
                    "ref": "sequencers:one"}`








