# README

## Coin Jar coding test

Please follow the steps below to get this application up and running.

Unzip files and move inside the folder

```bash
cd coin_jar
bundle install
RAILS_ENV=development rails db:setup
rails s
```

Navigate to localhost:3000 on a browser

### Running spec localy

```bash
cd coin_jar
bundle install
RAILS_ENV=test rails db:create && rails db:migrate
RAILS_ENV=test rspec spec/
```

## Or you can run using docker

### Build the docker image

This will also start a postgress database instance

```bash
docker-compose run -v $(pwd)/:/coin_jar --rm -p 3000:3000 web bash
```

### Run migrations and seed products

```bash
rails db:setup
```

### Run the server

```bash
rails s -b 0.0.0.0
```

Navigate to localhost:3000 on a browser.

### Run specs

```bash
docker-compose run -v $(pwd)/:/coin_jar --rm web bash

RAILS_ENV=test rails db:create && rails db:migrate
RAILS_ENV=test rspec spec/
```

### API endpoints

Import CoinjarApi.postman_collection.json to Postman to use the API.

Obtain a token using the registration endpoint.
Use that token as a Bearer token to call other endpoints.