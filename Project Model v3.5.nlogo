globals [age-file distance-file term0 term1 term2 term3 index age-at-death-file]
turtles-own [age]

to setup
  ca
  reset-ticks
  ask turtles[pen-up]
  set term0 [358.4 631.4 1157.8 1598.2 315.4 982.2 1337.8 1738.6 527.4 919.2 1164.6 1412.4]
  set term1 [84.017 207.79 190.87 222.3 -78.067 -260.51 -334.38 -391.21 10.35 68.744 208.21 346.29]
  set term2 [-13.614 -31.364 -28.033 -32.161 6.2333 22.019 27.536 29.767 -7.3917 -15.55 -35.775 -55.781]
  set term3 [0.4472 1.0182 0.8111 0.9019 -0.1593 -0.5873 -0.7213 -0.7358 0.2991 0.5377 1.2133 1.8793]
  ask patches [set pcolor white]
  ask patches at-points [[-5 24] [-6 24]  [5 24] [6 24] [-5 21] [-6 21] [5 21] [6 21] [-5 15] [-6 15] [5 15] [6 15] [-5 9] [-6 9] [5 9] [6 9]] [set pcolor green]

  if record-age [
  set age-file word date-and-time "-age.txt"
  let i 0
  while [i < 2] [
    set age-file remove-item ( position ":" age-file) age-file
    set i i + 1
  ]
  set i 0
  while [i < 2] [
    set age-file replace-item ( position " " age-file) age-file "-"
    set i i + 1
  ]
  print age-file
  file-open age-file
  file-type "ticks"
  file-type "age"
  file-print ""
  file-close
]

if record-distance [
  set distance-file word date-and-time "-distance.txt"
  let i 0
  while [i < 2] [
    set distance-file remove-item (position ":" distance-file) distance-file
    set i i + 1
  ]
  set i 0
  while [i < 2] [
    set distance-file replace-item (position " " distance-file) distance-file "-"
    set i i + 1
  ]
  print distance-file
  file-open distance-file
  file-type "ticks"
  file-type " distance"
  file-print ""
  file-close
]
   if record-age-at-death [
  set age-at-death-file word date-and-time "-age-at-death.txt"
  let i 0
  while [i < 2] [
    set age-at-death-file remove-item ( position ":" age-at-death-file) age-at-death-file
    set i i + 1
  ]
  set i 0
  while [i < 2] [
    set age-at-death-file replace-item ( position " " age-at-death-file) age-at-death-file "-"
    set i i + 1
  ]
  print age-at-death-file
  file-open age-at-death-file
  file-close
]
end

to go
  if virus-tracker[
    ask turtles [
    pen-down
  ]]
  crt 20[
    set shape "star"
    set color gray
    set size 1.5
    setxy 0 25]
  ask turtles [
    let random-distance random 10
    fd random-distance
    check-boundaries
    death
    increment-age]
  tick
   if record-distance[
    file-open distance-file
    file-write ticks
    ask turtles [file-write distance (patch 0 25)]
    file-print ""
    file-close
  ]
  if record-age[
    file-open age-file
    file-write ticks
    ask turtles [file-write age]
    file-print ""
    file-close
  ]
end

to increment-age
  set age (1 + age)
end

to check-boundaries
    if xcor <= min-pxcor or xcor >= max-pxcor or ycor <= min-pycor or ycor >= max-pycor[
      die]
end


to death
  if age <= 900 and Humidity = 36 [set index 0 formula]
  if age > 900 and age <= 1800 and Humidity = 36 [set index 1 formula]
  if age > 1800 and age <= 2700 and Humidity = 36 [set index 2 formula]
  if age > 2700 and Humidity = 36 [set index 3 formula]

  if age <= 900 and Humidity = 45 [set index 4 formula]
  if age > 900 and age <= 1800 and Humidity = 45 [set index 5 formula]
  if age > 1800 and age <= 2700 and Humidity = 45 [set index 6 formula]
  if age > 2700 and  Humidity = 45 [set index 7 formula]

  if age <= 900 and Humidity = 23 [set index 8 formula]
  if age > 900 and age <= 1800 and Humidity = 23 [set index 9 formula]
  if age > 1800 and age <= 2700 and Humidity = 23 [set index 10 formula]
  if age > 2700 and Humidity = 23 [set index 11 formula]
end

to formula
  let d distance patch 0 25
  let result ((item index term3 * d ^ 3) +
               (item index term2 * d ^ 2) +
               (item index term1 * d) +
               (item index term0))
  if trouble-shooting[
  print(word "age:" age)
  print(word "index:" index)
  print(word "distance:" d)
  print (word "Result: " result)
  print (word "Random: " (random 1000))
  ]
  if Humidity = 36 and d <= 4 and result < random 1000[
    if record-age-at-death [
      file-open age-at-death-file
      file-print age
      file-print ""
      file-close]
    die]
  if Humidity = 36 and d > 4 and d <= 9 and result < random 938[
      if record-age-at-death [
      file-open age-at-death-file
      file-print age
      file-print""
      file-close]
    die]
  if Humidity = 36 and d > 9 and d <= 18 and result < random 500[
      if record-age-at-death [
      file-open age-at-death-file
      file-print age
      file-print ""
      file-close]
    die]
  if Humidity = 36 and d > 18 and result < random 65[
      if record-age-at-death [
      file-open age-at-death-file
      file-print age
      file-print ""
      file-close]
    die]

  if Humidity = 45 and d <= 4 and result <  random 750 [
    die]
      if record-age-at-death [
      file-open age-at-death-file
      file-print age
      file-print ""
      file-close]
  if Humidity = 45 and d > 4 and d <= 9 and result <  random 500 [
      if record-age-at-death [
      file-open age-at-death-file
      file-print age
      file-print ""
      file-close]
    die]
  if Humidity = 45 and d > 9 and result < random 100[
      if record-age-at-death [
      file-open age-at-death-file
      file-print age
      file-print ""
      file-close]
    die]

  if Humidity = 23 and d <= 4 and result < random 1050[
      if record-age-at-death [
      file-open age-at-death-file
      file-print age
      file-print ""
      file-close]
    die]
  if Humidity = 23 and d > 4 and d <= 9 and result < random 900[
      if record-age-at-death [
      file-open age-at-death-file
      file-print age
      file-print ""
      file-close]
    die]
  if Humidity = 23 and d > 9 and d <= 18 and result < random 400[
      if record-age-at-death [
      file-open age-at-death-file
      file-print age
      file-print ""
      file-close]
    die]
  if Humidity = 23 and d > 18 and result < random 100[
      if record-age-at-death [
      file-open age-at-death-file
      file-print age
      file-print ""
      file-close]
    die]
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
881
682
-1
-1
13.0
1
10
1
1
1
0
0
0
1
-25
25
-25
25
0
0
1
Seconds
30.0

BUTTON
11
28
74
61
NIL
setup\n\n
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
81
29
144
62
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
9
97
126
130
record-age
record-age
1
1
-1000

SWITCH
9
146
151
179
record-distance
record-distance
1
1
-1000

SWITCH
9
190
179
223
record-age-at-death
record-age-at-death
1
1
-1000

CHOOSER
8
327
146
372
Humidity
Humidity
23 36 45
1

PLOT
889
10
1089
160
Current Number of Phage
Time(seconds)
# of Phage
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -2674135 true "" "plot count turtles"

SWITCH
8
236
189
269
trouble-shooting
trouble-shooting
1
1
-1000

SWITCH
9
285
135
318
virus-tracker
virus-tracker
1
1
-1000

@#$#@#$#@
## UPDATES

This version was made while making presentation. I removed the extra 10 particles being created. I changed the number of particles being created. And I updated the slope and intercepts for the first humidity to match the updated death curves. 
- Still having issues but a little better than before. 

2/2/24
Added formulas from my experiment fount in version 3.1 as well as added back in the age at death attempt. 

Fixed indexing to start at 0.

redid formula-chat gpt rewrote-just made it more compact

changed random-float 1 to be random 100 + 1 since it is no longer based on percentages
^working on this- formula results are weird 

2/5/24
Started adding quantification output on interface, still needs some work. 

2/6/24
Changed random 100 + 1 to random 1000

added absolute value of result because I was getting negative numbers. 
Still messing with number of turtles and how far they move. 

2/8/24
3.3
got rid of absolute value
cleaned up death -> formula pipeline
changed death to check ticks not ages
still a work in progress but saving here for now 

2/9/24
changed formula to correct cumulative count totals for 36
added trouble shooting switch

2/13/24
changed starting point from 0 27 to 0 30 and number of phage at 3 and 6 ft is much better now!

2/27/24
changed random comparison number to 500 after 9 feet and data looks much better!made more edits to this as well
moved check-boundaries to before death command

3/1/24 
added virus tracker that has the turtles put pen down so you can see where there has been virus

## FORMULA INDEX
index - humidity - time 
0 - 36 - 15
1 - 36 - 30 
2 - 36 - 45
3 - 36 - 60
4 - 45 - 15
5 - 45 - 30
6 - 45 - 45
7 - 45 - 60
8 - 23 - 15
9 - 23 - 30
10 - 23 - 45
11 - 23 60
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

orbit 5
true
0
Circle -7500403 true true 116 11 67
Circle -7500403 true true 13 89 67
Circle -7500403 true true 178 206 67
Circle -7500403 true true 53 204 67
Circle -7500403 true true 220 91 67
Circle -7500403 false true 45 45 210

orbit 6
true
0

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

petals
false
0
Circle -7500403 true true 117 12 66
Circle -7500403 true true 116 221 67
Circle -7500403 true true 41 41 67
Circle -7500403 true true 11 116 67
Circle -7500403 true true 41 191 67
Circle -7500403 true true 191 191 67
Circle -7500403 true true 221 116 67
Circle -7500403 true true 191 41 67
Circle -7500403 true true 60 60 180

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
Circle -7500403 true true 75 75 150
Polygon -2674135 true false 270 150 210 150 210 165
Polygon -2674135 true false 150 30 150 90 165 90
Polygon -2674135 true false 165 270 150 210 165 210
Polygon -2674135 true false 30 165 90 150 90 165
Polygon -2674135 true false 90 195 105 210 60 240
Polygon -2674135 true false 105 105 120 90 75 60
Polygon -2674135 true false 195 90 210 105 240 60
Polygon -2674135 true false 210 195 195 210 240 240
Polygon -2674135 true false 120 135 120 120 60 105
Circle -2674135 true false 60 45 30
Circle -2674135 true false 135 15 30
Circle -2674135 true false 45 90 30
Circle -2674135 true false 15 150 30
Circle -2674135 true false 45 225 30
Circle -2674135 true false 150 255 30
Circle -2674135 true false 225 225 30
Circle -2674135 true false 240 135 30
Circle -2674135 true false 225 45 30
Polygon -2674135 true false 150 120 165 135 180 75
Polygon -2674135 true false 135 165 150 180 120 225
Polygon -2674135 true false 195 165 180 180 240 210
Polygon -2674135 true false 150 150 165 165 210 120
Circle -10899396 true false 45 45 0
Circle -2674135 true false 105 210 30
Polygon -2674135 true false 150 150 165 165 210 120
Circle -2674135 true false 165 60 30
Circle -2674135 true false 195 105 30

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
NetLogo 6.2.2
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
