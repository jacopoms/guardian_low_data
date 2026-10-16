# Agent instructions for `guardian_low_data`

## Commands

- Install dependencies: `bundle install`
- Run the app locally: `bundle exec thin -R config.ru start -p 4000 -e development`
- Run the test suite: `bundle exec rspec`
- Run one spec file: `bundle exec rspec spec/app/controllers/application_controller_spec.rb`
- Run one example by line number: `bundle exec rspec spec/app/controllers/application_controller_spec.rb:58`
- Lint Ruby: `bundle exec rubocop`
- Run code quality checks: `bundle exec reek`
- Build the Docker image: `docker build -t guardian-low-data .`

## Architecture

- This is a Sinatra app, not Rails. `config.ru` loads `dotenv`, Bundler, and `config/app.rb`, which defines `GuardianLowDataApp`.
- `config/app.rb` wires the environment-specific settings, cache middleware, and error handling. `ApplicationController` holds the routes and shared request flow.
- The app is a thin UI over the `guardian-content` gem. `Helpers#search_articles` performs the Guardian API search, paginates results with `will_paginate`, and the Haml views render home, search, and article pages.
- Pagination links are customized through `CustomLinkRenderer` so they route to `/page/:number`.
- Search state is kept in `session[:query]` and the current page path is stored in `session[:request_path]` so article pages can link back correctly.
- Tests are RSpec request/controller specs with VCR + WebMock cassettes under `spec/fixtures/vcr_cassettes`.

## Conventions

- Use frozen string literals and keep changes in the existing Ruby/Haml style.
- Preserve the session-driven search flow: `GET /` and `GET /page/:page` reuse the stored query, and `POST /search` updates it.
- Keep cache headers on the GET routes; `POST /search` is intentionally uncached.
- `Helpers#path_info` special-cases `/search` to `/` so the back link and stored request path stay stable.
- Empty search results should continue to render the `EmptyResult` struct with the "No Articles" title and without pagination.
- Guard API access through the existing `GuardianContent` setup in `config/app.rb` and `spec/spec_helper.rb`; local runs expect `GUARDIAN_CONTENT_API_KEY` in `.env`.
