# Eco-Guardian: A simulation of environmental stewardship

## WHAT IS IT?

This NetLogo simulation, "Eco-Guardian," models the actions of a person character who cleans up garbage and plants trees and plants to restore the environment. The goal is to collect all garbage items (bottles, foods, and bananas) and plant trees and plants. The simulation stops when all garbage is collected, signifying the restoration of the environment.

## HOW IT WORKS

The model follows these rules:
- The person character moves around the environment, collecting garbage items.
- Each time a piece of garbage is collected, the garbage count increases.
- After collecting a certain amount of garbage (multiples of 4 and 3), the character plants trees and plants.
- The simulation stops when all garbage is collected, and the label on the person character changes to "Environment Restored!".

## HOW TO USE IT

1. **Setup**: Press the `Setup` button to initialize the environment. This creates garbage bins, factories, and garbage items, and places the person character in the center of the world.
2. **Go**: Press the `Go` button to start the simulation. The person character will begin moving and collecting garbage.
3. **Movement Buttons**: Use the `Move-Up`, `Move-Down`, `Move-Left`, and `Move-Right` buttons to manually control the movement of the person character. Or use your keyboard keys `W`, `A`, `S`, and `D` to manually control the movement of the person character.

## THINGS TO NOTICE

- Observe how the person character moves and collects garbage.
- Notice the garbage picked count increase as the character collects garbage items.
- Watch for the planting of trees and plants as specific amounts of garbage are collected.
- See the label on the person character change to "Environment Restored!" when all garbage is collected, and the simulation stops.

## THINGS TO TRY

- Try manually controlling the person character using the movement buttons to collect garbage more efficiently.
- Experiment with changing the number of garbage items or the positions of bins and factories to see how it affects the simulation.
- Adjust the `move-speed` to see how the speed of the person character affects the rate of garbage collection.

## EXTENDING THE MODEL

- Add more types of garbage or other items for the person character to collect.
- Implement obstacles that the person character must navigate around to collect garbage.
- Create different levels or scenarios with varying amounts of garbage and different environmental layouts.
- Introduce more characters, each with different behaviors and tasks.

## NETLOGO FEATURES

- The model uses breeds to differentiate between the person character, trees, plants, and garbage.
- It utilizes the `sprout` function to dynamically create trees and plants at random locations.
- The model employs `ask` commands and conditional statements to control agent behavior and environmental changes.
- The use of global variables helps track the counts of garbage, trees, and plants efficiently.

## CREDITS AND REFERENCES

Author: [Hemant Ramphul](https://github.com/hemantramphul/)<br/>
Date: June 28, 2024  
Project: Eco-Guardian - A simulation of environmental stewardship

For more information and updates, visit the project's URL: [Eco-Guardian](https://github.com/hemantramphul/eco-guardian/)

Feel free to reference this model in your projects and studies, giving appropriate credit to the author.
