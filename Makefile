# This will kick off the gqlgen codegen
gen: models schema helpers

models:
	- sqlboiler mysql --no-back-referencing -d

schema:
	-  go run github.com/web-ridge/sqlboiler-graphql-schema --output=schema.graphql --skip-input-fields=userId --directives=isAuthenticated --pagination=no

helpers:
	- go run convert_plugin.go

gql:
	- go run github.com/99designs/gqlgen generate

db:
	- docker-compose up --build -d

destroy-db:
	- docker-compose down -v

start:
	- go run server.go resolver.go database.go

.PHONY: gen models schema helpers gql db destroy-db start