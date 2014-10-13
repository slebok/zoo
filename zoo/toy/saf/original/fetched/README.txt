http://super-awesome-fighter.appspot.com

Super Awesome Fighter!


FDL Language Reference
----------------------

# Fighter Grammar

[Name] {
  [Personality]
  [Rule]*
}

# Personality
## Personality Structure

characteristic = {1..10}

## Characteristics

punchPower, punchReach, kickPower, kickReach : 1..10

Any characteristics that are not defined default to 5.


# Behaviour Rules
## Rule Structure

condition [ moveAction fightAction]

Rules should be indented with two spaces.

## Conditions

far, near, much_weaker, weaker, even, stronger, much_stronger

Conditions can be composed using keywords 'and' and 'or'. E.g. 'far and even'.

## Move Actions

run_towards, run_away, walk_towards, walk_away, stand, crouch

Add non-deterministic move actions using the choose keyword. Move actions should be separated using spaces. E.g. 'choose(run_towards walk_towards)'.

## Fight Actions

block_high, block_low, punch_high, punch_low, kick_high, kick_low

Add non-deterministic fight actions using the choose keyword. Fight actions should be separated using spaces. E.g. 'choose(punch_high block_low kick_high)'.

