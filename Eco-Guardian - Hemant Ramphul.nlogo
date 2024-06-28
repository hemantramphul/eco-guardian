; Author: Hemant Ramphul
; Date: June 28, 2024
; Project: Eco-Guardian - A simulation of environmental stewardship
; Description: This NetLogo simulation involves collecting garbage and planting trees and plants.
;              The simulation stops when all garbage is collected.

breed [people person]  ; Define a breed for people
breed [trees tree]  ; Define a breed for trees
breed [plants plant]  ; Define a breed for plants
breed [garbages garbage]  ; Define a breed for garbage

globals [
  move-speed  ; Speed at which people move
  start-collect  ; Flag to indicate the start of garbage collection
  garbage-picked  ; Counter for garbage picked
  trees-planted  ; Counter for trees planted
  plants-planted  ; Counter for plants planted
  num-of-garbages  ; Total number of garbage items
  factory-y-coordinates  ; List of y-coordinates of factories
]

; Setup procedure initializes the simulation environment
to setup
  clear-all
  set move-speed 1
  setup-world  ; Setup the world patches
  setup-bins  ; Setup garbage bins
  setup-factories  ; Setup factories
  setup-garbages  ; Setup garbage items
  setup-character  ; Setup the person character
  set start-collect false
  set garbage-picked 0
  set trees-planted 0
  set plants-planted 0
  reset-timer
  reset-ticks
end

; Go procedure runs each tick of the simulation
to go
  set start-collect true  ; Start collecting garbage
  move-character  ; Move the character
  tick
end

; Setup-world procedure colors the patches
to setup-world
  ask patches [
    set pcolor lime + 1
  ]
end

; Setup-bins procedure creates garbage bins
to setup-bins
  let starting-xcor max-pxcor - 2
  let starting-ycor min-pycor + 2

  repeat 4 [
    create-turtles 1 [
      set shape "garbage can"
      set color brown
      set size 3
      setxy starting-xcor starting-ycor  ; Set position
    ]
    set starting-xcor starting-xcor - 2  ; Adjust horizontal spacing between bins
  ]
end

; Setup-factories procedure creates factories and stores their y-coordinates
to setup-factories
  set factory-y-coordinates []  ; Initialize factory y-coordinates list
  create-turtles num-factories [
    set shape "factory"
    set color gray
    set size 7  ;
    setxy random-xcor max-pycor - 3  ; Set position
    set factory-y-coordinates lput ycor factory-y-coordinates  ; Add y-coordinate to list
  ]
end

; Setup-garbages procedure sets up different types of garbage items
to setup-garbages
  setup-garbage num-bottles garbages "bottle" blue  ; Setup bottles
  setup-garbage num-food garbages "food" orange  ; Setup food items
  setup-garbage num-bananas garbages "banana" yellow  ; Setup bananas
  set num-of-garbages count garbages  ; Calculate total number of garbage items
end

; Setup-item procedure creates garbage items of a specific type
to setup-garbage [num-items type-breed name-of-shape name-of-color]
  let min-factory-y min factory-y-coordinates  ; Get the minimum y-coordinate of factories
  create-turtles num-items [
    set breed type-breed
    set shape name-of-shape
    set color name-of-color
    set size 1
    setxy random-xcor (min-factory-y - random 20 - 5)  ; Place items below the factories
  ]
end

; Setup-character procedure creates the person character
to setup-character
  create-people 1 [
    set shape "person"
    set color pink + 3
    set size 2
    setxy 0 0
  ]
end

; Move-character procedure moves the person character and collects garbage
to move-character
  ask people [
    forward move-speed
    collect-garbage  ; Collect garbage
  ]
end

; Move-up procedure moves the person character upwards
to move-up
  if start-collect [
    ask people [
      set heading 0  ; Set heading to 0 degrees (upwards)
      forward move-speed
      collect-garbage  ; Collect garbage
    ]
  ]
end

; Move-down procedure moves the person character downwards
to move-down
  if start-collect [
    ask people [
      set heading 180  ; Set heading to 180 degrees (downwards)
      forward move-speed
      collect-garbage  ; Collect garbage
    ]
  ]
end

; Move-left procedure moves the person character leftwards
to move-left
  if start-collect [
    ask people [
      set heading 270  ; Set heading to 270 degrees (leftwards)
      forward move-speed
      collect-garbage  ; Collect garbage
    ]
  ]
end

; Move-right procedure moves the person character rightwards
to move-right
  if start-collect [
    ask people [
      set heading 90  ; Set heading to 90 degrees (rightwards)
      forward move-speed
      collect-garbage  ; Collect garbage
    ]
  ]
end

; Collect-garbage procedure allows the person character to collect nearby garbage
to collect-garbage
  ask people [
    let nearby-garbage min-one-of other turtles-here with [breed = garbages] [distance myself]  ; Find nearest garbage
    if nearby-garbage != nobody [
      set garbage-picked garbage-picked + 1  ; Increment garbage-picked counter
      ask nearby-garbage [die]  ; Remove the garbage item
      update-label  ; Update the label
      if garbage-picked mod 4 = 0 [
        plant-trees  ; Plant trees every 4 garbage picked
      ]
      if garbage-picked mod 3 = 0 [
        plant-plants  ; Plant plants every 3 garbage picked
      ]
    ]
  ]
end

; Plant-trees procedure plants trees on random patches
to plant-trees
  ask n-of 2 patches with [not any? turtles-here] [
    sprout-trees 1 [
      set shape "tree"
      set color lime - 3
      set size 3
    ]
  ]
  set trees-planted trees-planted + 2  ; Increment trees planted counter
end

; Plant-plants procedure plants plants on random patches
to plant-plants
  ask n-of 4 patches with [not any? turtles-here] [
    sprout-plants 1 [
      set shape "plant"
      set color lime - 2
      set size 1
    ]
  ]
  set plants-planted plants-planted + 4  ; Increment plants planted counter
end

; Update-label procedure updates the label of the person character
to update-label
  ask people [
    ifelse num-of-garbages = garbage-picked [
      set label "Environment Restored!"  ; Set label to "Environment Restored!" if all garbage is collected
      stop  ; Stop the simulation
    ] [
      set label garbage-picked  ; Otherwise, display the garbage picked count
    ]
  ]
end

; Wiggle procedure makes the person character wiggle randomly
to wiggle
  right random 90
  left random 90
end
@#$#@#$#@
GRAPHICS-WINDOW
9
10
523
525
-1
-1
15.33333333333334
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

SLIDER
539
11
758
44
num-factories
num-factories
1
5
4.0
1
1
NIL
HORIZONTAL

SLIDER
539
58
758
91
num-bottles
num-bottles
1
25
5.0
1
1
NIL
HORIZONTAL

SLIDER
540
105
757
138
num-food
num-food
1
25
5.0
1
1
NIL
HORIZONTAL

SLIDER
541
151
757
184
num-bananas
num-bananas
1
25
5.0
1
1
NIL
HORIZONTAL

BUTTON
542
197
637
230
SETUP
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
662
197
757
230
BEGIN
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

BUTTON
613
378
685
411
UP
move-up
NIL
1
T
OBSERVER
NIL
W
NIL
NIL
0

BUTTON
685
423
757
456
RIGHT
move-right
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
0

BUTTON
543
422
615
455
LEFT
move-left
NIL
1
T
OBSERVER
NIL
A
NIL
NIL
0

BUTTON
613
468
685
501
DOWN
move-down
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
0

TEXTBOX
544
336
758
362
Use keyboard \"W\", \"A\", \"D\" and \"D\", to clean the world.
10
55.0
1

MONITOR
601
270
699
315
NIL
garbage-picked
17
1
11

@#$#@#$#@
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

Author: Hemant Ramphul  
Date: June 28, 2024  
Project: Eco-Guardian - A Simulation of Environmental Stewardship

For more information and updates, visit the project's URL: [URL to be added]

Feel free to reference this model in your projects and studies, giving appropriate credit to the author.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

banana
false
0
Polygon -7500403 false true 25 78 29 86 30 95 27 103 17 122 12 151 18 181 39 211 61 234 96 247 155 259 203 257 243 245 275 229 288 205 284 192 260 188 249 187 214 187 188 188 181 189 144 189 122 183 107 175 89 158 69 126 56 95 50 83 38 68
Polygon -7500403 true true 39 69 26 77 30 88 29 103 17 124 12 152 18 179 34 205 60 233 99 249 155 260 196 259 237 248 272 230 289 205 284 194 264 190 244 188 221 188 185 191 170 191 145 190 123 186 108 178 87 157 68 126 59 103 52 88
Line -16777216 false 54 169 81 195
Line -16777216 false 75 193 82 199
Line -16777216 false 99 211 118 217
Line -16777216 false 241 211 254 210
Line -16777216 false 261 224 276 214
Polygon -16777216 true false 283 196 273 204 287 208
Polygon -16777216 true false 36 114 34 129 40 136
Polygon -16777216 true false 46 146 53 161 53 152
Line -16777216 false 65 132 82 162
Line -16777216 false 156 250 199 250
Polygon -16777216 true false 26 77 30 90 50 85 39 69

bottle
false
0
Circle -7500403 true true 90 240 60
Rectangle -1 true false 135 8 165 31
Line -7500403 true 123 30 175 30
Circle -7500403 true true 150 240 60
Rectangle -7500403 true true 90 105 210 270
Rectangle -7500403 true true 120 270 180 300
Circle -7500403 true true 90 45 120
Rectangle -7500403 true true 135 27 165 51

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

factory
false
0
Rectangle -7500403 true true 76 194 285 270
Rectangle -7500403 true true 36 95 59 231
Rectangle -16777216 true false 90 210 270 240
Line -7500403 true 90 195 90 255
Line -7500403 true 120 195 120 255
Line -7500403 true 150 195 150 240
Line -7500403 true 180 195 180 255
Line -7500403 true 210 210 210 240
Line -7500403 true 240 210 240 240
Line -7500403 true 90 225 270 225
Circle -1 true false 37 73 32
Circle -1 true false 55 38 54
Circle -1 true false 96 21 42
Circle -1 true false 105 40 32
Circle -1 true false 129 19 42
Rectangle -7500403 true true 14 228 78 270

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

food
false
0
Polygon -7500403 true true 30 105 45 255 105 255 120 105
Rectangle -7500403 true true 15 90 135 105
Polygon -7500403 true true 75 90 105 15 120 15 90 90
Polygon -7500403 true true 135 225 150 240 195 255 225 255 270 240 285 225 150 225
Polygon -7500403 true true 135 180 150 165 195 150 225 150 270 165 285 180 150 180
Rectangle -7500403 true true 135 195 285 210

garbage can
false
0
Polygon -16777216 false false 60 240 66 257 90 285 134 299 164 299 209 284 234 259 240 240
Rectangle -7500403 true true 60 75 240 240
Polygon -7500403 true true 60 238 66 256 90 283 135 298 165 298 210 283 235 256 240 238
Polygon -7500403 true true 60 75 66 57 90 30 135 15 165 15 210 30 235 57 240 75
Polygon -7500403 true true 60 75 66 93 90 120 135 135 165 135 210 120 235 93 240 75
Polygon -16777216 false false 59 75 66 57 89 30 134 15 164 15 209 30 234 56 239 75 235 91 209 120 164 135 134 135 89 120 64 90
Line -16777216 false 210 120 210 285
Line -16777216 false 90 120 90 285
Line -16777216 false 125 131 125 296
Line -16777216 false 65 93 65 258
Line -16777216 false 175 131 175 296
Line -16777216 false 235 93 235 258
Polygon -16777216 false false 112 52 112 66 127 51 162 64 170 87 185 85 192 71 180 54 155 39 127 36

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
