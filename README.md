## Missile Command

Missile Command is [classic arcade game](https://en.wikipedia.org/wiki/Missile_Command) developed by Atari that I discovered last night at a bar after RubyConf 2016.

Using inspiration from a talk on [Gosu](https://libgosu.org), I threw together a version written in Ruby.

![missile command](https://media.giphy.com/media/l2JhuuelwxIrx5b3i/giphy.gif)

### Elements

#### Bunkers

Bunkers represent your forces.  When a bunker is struck by a missile, it is destroyed and all remaining ammunition there is depleted.  If you run out of ammo and there are still spaceships flying around, you lose.

#### Bullets

Called "missiles" in the game lore, I accidentally named them "bullets" in my code and differentiate between 'good guy missiles' ("bullets") and 'bad guy missiles' ("missiles").  You start off the level with a number of bullets in each bunker.  Scoring a hit on an enemy spaceship or a missle will destroy it.  Destroy all spaceships to complete the level.

#### Spaceships

Enemy ships that fly around at variable speeds and altitudes.  They fire missiles every so often.

## Installation

```
git clone git@github.com:mzemel/missile_command.git
cd missile_command
gem install gosu
ruby missile_command.rb
```

Move cursor with arrow keys.  Fire bullets from first bunker with `a`, second with `s`, etc.

## Customizations

Build your own levels by modifying the `config/levels.yml` file.

```yaml
# config/levels.yml
one:
  enemies:
    number: 3       # Number of spaceships
    height: high    # Starting height: "high", "medium", "low"
    mode: easy      # Speed: "easy", "medium", "hard"
    weapons: insane # Firing rate: "easy", "medium", "hard", "insane"
  bunkers:
    number: 1       # Number of bunkers
    ammo: 10        # Shots per bunker

two:
  enemies:
    # ...
```

## Resources

Thanks to [Cory Chamblin](http://twitter.com/chamblin) for giving the talk at RubyConf.

Thanks to Atari for not suing me.

* [Gosu Tutorial](https://github.com/gosu/gosu/wiki/Ruby-Tutorial)
* PikoPixel
* [OpenGameArt](http://opengameart.org/)
* [Free Sound Project](http://www.freesound.org/people/cydon/sounds/268557/)