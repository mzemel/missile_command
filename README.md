#### Installation

```
gem install gosu
ruby missile_command.rb
```

#### Resources

* [Gosu](https://github.com/gosu/gosu/wiki/Ruby-Tutorial)
* PikoPixel
* [OpenGameArt](http://opengameart.org/)
* [Free Sound Project](http://www.freesound.org/people/cydon/sounds/268557/)

#### Customizations

```yaml
# config/levels.yml
one:
  enemies:
    number: 3       # Number of spaceships
    height: high    # Starting height: "high", "medium", "low"
    mode: easy      # Speed: "easy", "medium", "hard"
    weapons: insane # Firing rate: "easy", "medium", "hard", "insane"
    delay: false
  bunkers:
    number: 1       # Number of bunkers
    ammo: 10        # Shots per bunker

two:
  enemies:
    # ...
```