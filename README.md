## Missile Command

![missile command](https://media.giphy.com/media/3oz8xXZGdxiYkNmNCE/giphy.gif)

### Instructions

You are the commander of a rebel encampment under seige by imperial forces.  Use your turrets to repel enemy missiles and ships.  If you destroy all enemy ships, you move to the next level.  If you run out of ammo or your bunkers are destroyed, you lose the game.

Move your cursor with the arrow keys.  Use `a` to fire from the first bunker, `s` to fire from the second bunker, `d` to fire from the third, and so on.

### Background

Missile Command is [classic arcade game](https://en.wikipedia.org/wiki/Missile_Command) developed by Atari.  Using inspiration from a talk on [Gosu](https://libgosu.org), I threw together a version written in Ruby.

### Friendly Units

#### Turrets

When a turrey is struck by a missile, it is destroyed and all remaining ammunition there is depleted.  If you run out of ammo and there are still enemies, you lose.

#### Defenders

A ragtag group of rebels will sometimes fly X-Wings, Y-Wings, and A-Wings.  They will attempt to repel the oncoming assault but are vulnerable to enemy missiles.

### Enemy Units

#### TIE Bombers

Basic enemy ships.  One hit to kill.

#### Bounty Hunters, Shuttles, and TIE Interceptors

Stronger enemies.  Takes several hits to kill.

#### Death Star

Takes many hits to kill.

## Mac Installation

1)  [Download the game](https://github.com/mzemel/missile_command/blob/master/missile_command.tar.gz?raw=true)

2)  Open `Applications > Utilities > Terminal` and copy/paste the following.

```
cd ~/Downloads
gunzip missile_command.tar.gz
tar xvf missile_command.tar
rm missile_command.tar
cd missile_command
./install

```

3) Now and in the future, you can type `missile` in the terminal to launch the game.

## Linux Installation

```
git clone git@github.com:mzemel/missile_command.git
cd missile_command
./install
```

## Customization

If you want, you can build your own levels by modifying the YAML files in the `config/` directory.

```yaml
# config/easy.yml
1:
  spaceships:
    number: 3
    height: high          # Height: "high", "medium", "low"
                            # DEFAULT: "high"
    mode: easy            # Speed: "easy", "medium", "hard"
                            # DEFAULT: "easy"
    weapons: easy         # Firing rate: false, "easy", "medium", "hard", "insane"
                            # DEFAULT: false
    health: easy          # Health: "low", "medium", "high"
                            # DEFAULT: "low"
  battleships:
    # Same as above
  fortresses:
    # Same as above
  bunkers:
    number: 1
    ammo: 10              # Ammo: <<FIXNUM>>
                            # DEFAULT: 10
    health: medium        # Health: "low", "medium", "high"
                            # DEFAULT: "low"
  defenders:
    # Same as spaceships/battleships/fortresses
  planet: yavin_4         # Planet: "yavin_4", "tatooine", "hoth", "naboo", "endor"
  music: main_theme_1.mp3 # Music
```

## Resources

Thanks to [Cory Chamblin](http://twitter.com/chamblin) for giving the talk at RubyConf.

Thanks to Atari and LucasArts for not suing me.

* [Gosu Tutorial](https://github.com/gosu/gosu/wiki/Ruby-Tutorial)
* PikoPixel
* [OpenGameArt](http://opengameart.org/)
* [Free Sound Project](http://www.freesound.org/people/cydon/sounds/268557/)