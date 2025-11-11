# Godot Prototype Setup

This directory contains a Godot 4.x project that recreates the two-level plinko field described in the pygame prototype.

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
1. 解壓縮專案壓縮檔，確保 `project.godot` 與 `scenes/`、`scripts/` 等資料夾同層存在（例如 `BallGame/godot/`）。
2. 在 Godot 4.1 以上版本中，選擇 **Import > Browse**，指向上述資料夾並按 **Import & Edit**。
3. 開啟 `scenes/Main.tscn` 並按下 **Play** 進行測試。
4. 若曾用舊版 Godot 4.0 或 3.x 匯入導致崩潰，可刪除專案資料夾重新解壓，再以 4.1 以上版本重新匯入。
5. 需要調整釘子或槽位位置時，可編輯 `scripts/Main.gd` 內的座標常數。

## Troubleshooting
- **匯入時崩潰**：多半是因為使用 4.0 或更舊版本。請改用官方網站提供的 Godot 4.1 或更新版本，再次依照上述步驟匯入。
- **場景路徑錯誤**：確定匯入的是 `godot/` 子資料夾而不是整個倉庫根目錄，避免 Godot 找不到 `project.godot`。
- **仍無法開啟**：刪除 `BallGame/godot/.godot/`（若存在），重新啟動 Godot 讓它重新產生匯入快取。

## Next Steps
- Implement unique effects for each upgrade slot by extending `SlotArea.gd` or connecting signals in `Main.gd`.
- Add visuals (sprites, particles, UI) to replace the procedural drawings used for pegs and labels.
- Hook up save/load systems or score tracking to persist progress beyond the basic loop.
