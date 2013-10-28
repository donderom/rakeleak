# Rakeleak [![Build Status](https://travis-ci.org/donderom/rakeleak.png?branch=master)](https://travis-ci.org/donderom/rakeleak) [![Gem Version](https://badge.fury.io/rb/rakeleak.png)](http://badge.fury.io/rb/rakeleak) [![Code Climate](https://codeclimate.com/github/donderom/rakeleak.png)](https://codeclimate.com/github/donderom/rakeleak)

Helps you search & run your Rake tasks from Rails (3.2+) application. It:

* Shows all the available Rake tasks;
* Allows you to search by task name and description;
* And run any task you want;
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
![Rakeleak in Action](http://f.cl.ly/items/3x0i252W2f0A2j0r3M3w/rakeleak_0.4.0_colored.png)

## License

MIT License.
