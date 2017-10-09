# azurex2

This is my general purpose Azure test-kitchen wrapper cookbook for Ubuntu Linux

The important files here are
* .kitchen.yml
* metadata.rb
* Berksfile

Typically, the default recipe will simply include other recipes

At this time unit and integration testing is done here in the `default_spec.rb` and `default_test.rb` files. I am still not sure this is the right way to approach this.

Often this wrapper cookbook will call recipes from ubuntu-installation-recipes