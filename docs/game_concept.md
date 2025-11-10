# Concept Reconstruction from Original Pygame Prototype

## Overview
The prototype simulates a Galton-board-inspired plinko machine where multiple balls fall through a field of pegs and land in reward slots. The program continuously runs without user input, emphasizing automated play, score progression, and a future lower deck of upgrades.

## Key Systems
- **Ball Initialization**: Two balls spawn near the top center, each carrying a score value and radius. They fall under a capped gravity simulation (`vy` clamped at 3) while maintaining lateral velocity adjustments after collisions.
- **Obstacle Grid**: Pegs arranged in staggered rows create randomized trajectories. Collision checks measure the distance between a ball and each peg; when intersecting, the ball bounces with a randomized horizontal velocity and is nudged upward to avoid overlap.
- **Boundary Handling**: Balls rebound off the left and right walls by inverting horizontal velocity, keeping gameplay within the vertical shaft.
- **Slot Resolution**: Upon crossing the playfield threshold, the x-position determines which slot captures the ball. Slots include multiplier rewards (`x2`, `x4`, `x8`) and a central updraft column that propels light balls back upward. When scores exceed two million (2M), balls become “heavy” and can break through the updraft to the next layer.
- **Score Display**: Each ball renders its score as formatted text (e.g., `1K`, `2M`) with a drop shadow directly on the sprite, reinforcing progress feedback.

## Progression Loop
The gameplay loop is autonomous: balls repeatedly fall, interact with pegs, and collect multipliers. The central arrow slot now represents an updraft that recycles lighter balls, while heavier balls transition toward the planned lower deck. This structure aims to deliver an incremental idle experience where visual motion and rising numbers provide the core engagement.

## Visual Layout Sketch
```
+--------------------------------------------------+
|                 Spawn Zone                       |
|            o            o                        |
|                                                  |
|   •     •     •     •     •     •                |
|     •     •     •     •     •                    |
|   •     •     •     •     •     •                |
|                                                  |
|================== Play Threshold =================|
|  x2  |  x4  |  x8  | ↑↑↑ |  x2  |  x8  |  x4  |  |
|      Multiplier Slots      | Updraft Lane         |
|--------------------------------------------------|
|                                                  |
|   •     •     •     •     •     •                |
|     •     •     •     •     •                    |
|   •     •     •     •     •     •                |
|                                                  |
| 散彈  |  機槍  |  護盾  |  大球  |  狙擊  | (planned triggers)
+--------------------------------------------------+
```

The top 40% showcases the existing plinko field and multiplier band. The remaining 60% sketches the future upgrade deck where heavy balls descend. Each bottom slot represents an upgrade archetype (e.g., shotgun, machine gun, shield, giant ball, sniper) that will receive dedicated functionality in later iterations.
