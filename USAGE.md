# Install

```bash
rvm install ruby-3.1.2
rvm use ruby-3.1.2

rvm gemset create part_5__interfaces_inheritance_and_polymorphism
rvm gemset use part_5__interfaces_inheritance_and_polymorphism

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