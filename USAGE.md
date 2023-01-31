# Install

```bash
rvm install ruby-3.1.2
rvm use ruby-3.1.2

rvm gemset create part_6__class_methods_modules_and_the_ruby_object_model
rvm gemset use part_6__class_methods_modules_and_the_ruby_object_model

bundle install --full-index --local
```

## Common Commands

```bash
bundle install --binstubs
bundle exec guard
```

```bash
guard

rspec --color --require spec_helper --format Fuubar
rubocop --enable-pending-cops --format fuubar
```