# Rakeleak [![Build Status](https://travis-ci.org/donderom/rakeleak.png?branch=master)](https://travis-ci.org/donderom/rakeleak) [![Gem Version](https://badge.fury.io/rb/rakeleak.png)](http://badge.fury.io/rb/rakeleak)

Helps you search & run your Rake tasks from Rails (3.2+) application. It:

* Shows all the available Rake tasks;
* Allows you to search by task name and description;
* And run any task you want (see TODO for more details);
* Shows the task output if any;
* Shows the error message and even stacktrace if the task was failed.

## Getting Started

Rakeleak works only with Rails 3.2 and higher. You can add it to the development group in your Gemfile like this:
```ruby
group :development do
  gem 'rakeleak'
end
```
Run ```bundle install``` to install it.
Then mount it adding the following to your application's ```config/routes.rb```:
```ruby
mount Rakeleak::Engine, at: "/rakeleak"
```

## In Action

Just go to ```http://localhost:3000/rakeleak/tasks```.

This is how it feels in action:
![Rakeleak in Action](http://f.cl.ly/items/2C0C2A3r0a2c2L0F162K/rakeleak.png)
![Rakeleak in Action](http://f.cl.ly/items/1z1y3y1d3E2i1x3l3C1O/rakeleak2.png)

## TODO

* Passing parameters (now it's useful only for tasks without arguments)
* Remove explicit mounting?

## License

MIT License.
