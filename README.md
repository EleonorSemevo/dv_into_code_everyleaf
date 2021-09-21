# README

Model: Task

* id : integer
* name : string

* content : text

* limit_date : date

* status : string

* priority : string

##To deploy on heroku, here are the steps
* Create a new application on heroku with command: heroku create
* Precompile asset with the command rails assets: precompile RAILS_ENV=production
* git add .
* git commit -m "some message"
* Add heroku buildpack to your app: nodejs and ruby withe thoses commands
heroku buildpacks:set heroku/ruby
heroku buildpacks:add --index 1 heroku/nodejs

* Deploy to heroku with the command:
 git push heroku partie2

Gem version: 3.0.3

#Admin connection identifier 
email: admin@gmail.com
password: admin123

