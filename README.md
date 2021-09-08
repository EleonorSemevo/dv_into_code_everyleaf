# README

Model: Task

* id : integer
* name : string

* content : text

* limit_date : date

* status : string

* priority : string

##To deploy on heroku, here are the steps
* Create a new application on heroku
* Precompile asset with the command  rails assets:precompile RAILS_ENV=production
* Commit 
* Add heroku buildpack to your app: nodejs and ruby
* Deploy to heroku

Gem version: 3.0.3
