# Godot Prototype Setup

This directory contains a Godot 4.2 project that recreates the two-level plinko field described in the pygame prototype.

## Project Structure
- `project.godot` – Godot project configuration targeting the main scene.
- `scenes/` – Packed scenes for the main playfield, balls, pegs, and slot areas.
- `scripts/` – GDScript files implementing ball behaviour, peg drawing, slot logic, and the updraft area.

## Scene Overview
- **Main.tscn** – Root scene that instantiates pegs, multiplier slots, the updraft column, and placeholder upgrade slots.
- **Ball.tscn** – RigidBody2D with score-aware radius scaling and label rendering.
- **SlotArea.tscn** – Area2D used for both multiplier slots (upper 40%) and placeholder upgrade slots (lower 60%).
- **Peg.tscn** – StaticBody2D peg that draws itself as a circle for easy duplication.

## Implemented Behaviours
- Two balls spawn near the top, inherit the score formatting from the pygame version, and scale in size as their score increases.
- Peg grids are generated for both the upper playfield and the lower upgrade deck to match the provided diagram.
- Multiplier slots apply their configured multiplier and immediately respawn the ball at the top spawn marker.
- The central `↑↑↑` lane is implemented as an updraft (`UpdraftArea.gd`) that applies upward force to lighter balls. Once a ball reaches 2M score it is considered heavy and slips through to the lower area.
- Upgrade slots at the bottom currently remove the ball (they emit a `removed` signal so the spawner can create a fresh ball). Future functionality can hook into this point.

## Getting Started
1. Open the Godot editor and choose **Import > Browse**, then select this folder.
2. Open `scenes/Main.tscn` and press **Play** to run the prototype.
3. Adjust peg or slot positions inside `scripts/Main.gd` if you need to match different spacing.

## Next Steps
- Implement unique effects for each upgrade slot by extending `SlotArea.gd` or connecting signals in `Main.gd`.
- Add visuals (sprites, particles, UI) to replace the procedural drawings used for pegs and labels.
- Hook up save/load systems or score tracking to persist progress beyond the basic loop.
