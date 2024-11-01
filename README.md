# README

### Ruby version: 
##### ruby-3.3.5

### Database creation/initialize
##### Run the command: `rails db:prepare` to create database and run migrations.

### How to run the test suite
##### The main spec is for WeatherForecastsController as this is the focus of this exercise. This can be run with the usual `rspec spec/controllers/weather_forecasts_controller_spec.rb` or just simply type `rspec` to run.

### Installation
- run `bundle install` to install gems
- run `rails db:prepare` to prepare the database (create and run migrations)
- run `rails s` to start the development server
- run foreman to compile CSS assets with `foreman start -f Procfile.dev`
