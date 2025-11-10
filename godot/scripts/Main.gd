extends Node2D

const BALL_SCENE := preload("res://scenes/Ball.tscn")
const PEG_SCENE := preload("res://scenes/Peg.tscn")
const SLOT_SCENE := preload("res://scenes/SlotArea.tscn")

@onready var spawn_top: Marker2D = $SpawnPoints/Top
@onready var spawn_left: Marker2D = $SpawnPoints/Left
@onready var spawn_right: Marker2D = $SpawnPoints/Right
@onready var updraft_area: Area2D = $Updraft

var balls: Array = []

const UPPER_PEGS := [
    Vector2(60, 80), Vector2(120, 80), Vector2(180, 80), Vector2(240, 80), Vector2(300, 80),
    Vector2(90, 150), Vector2(150, 150), Vector2(210, 150), Vector2(270, 150),
    Vector2(60, 220), Vector2(180, 220), Vector2(300, 220),
]

const LOWER_PEGS := [
    Vector2(40, 360), Vector2(110, 360), Vector2(180, 360), Vector2(250, 360), Vector2(320, 360), Vector2(390, 360),
    Vector2(75, 410), Vector2(145, 410), Vector2(215, 410), Vector2(285, 410), Vector2(355, 410),
    Vector2(40, 460), Vector2(110, 460), Vector2(180, 460), Vector2(250, 460), Vector2(320, 460), Vector2(390, 460),
]

const UPPER_SLOTS := [
    {"label": "x2", "multiplier": 2.0, "position": Vector2(30, 240)},
    {"label": "x4", "multiplier": 4.0, "position": Vector2(90, 240)},
    {"label": "x8", "multiplier": 8.0, "position": Vector2(150, 240)},
    {"label": "x2", "multiplier": 2.0, "position": Vector2(270, 240)},
    {"label": "x8", "multiplier": 8.0, "position": Vector2(330, 240)},
    {"label": "x4", "multiplier": 4.0, "position": Vector2(390, 240)},
]

const LOWER_SLOT_LABELS := ["散彈", "機槍", "護盾", "大球", "狙擊"]

func _ready() -> void:
    _spawn_initial_balls()
    _build_pegs(UPPER_PEGS)
    _build_pegs(LOWER_PEGS)
    _build_multiplier_slots()
    _build_upgrade_slots()

func _spawn_initial_balls() -> void:
    for spawn_point in [spawn_left.global_position, spawn_right.global_position]:
        var ball: RigidBody2D = BALL_SCENE.instantiate()
        ball.global_position = spawn_point
        ball.connect("removed", Callable(self, "_on_ball_removed"))
        add_child(ball)
        balls.append(ball)

func respawn_ball(ball: RigidBody2D) -> void:
    ball.global_position = spawn_top.global_position
    ball.linear_velocity = Vector2.ZERO
    ball.angular_velocity = 0.0

func _build_pegs(positions: Array) -> void:
    for position in positions:
        var peg: StaticBody2D = PEG_SCENE.instantiate()
        peg.position = position
        $PegContainer.add_child(peg)

func _build_multiplier_slots() -> void:
    for config in UPPER_SLOTS:
        var slot: Area2D = SLOT_SCENE.instantiate()
        slot.position = config["position"]
        slot.label = config["label"]
        slot.multiplier = config["multiplier"]
        slot.respawn_path = spawn_top.get_path()
        $SlotContainer.add_child(slot)

func _build_upgrade_slots() -> void:
    var width := 420.0 / LOWER_SLOT_LABELS.size()
    for i in range(LOWER_SLOT_LABELS.size()):
        var slot: Area2D = SLOT_SCENE.instantiate()
        slot.slot_kind = "Upgrade"
        slot.label = LOWER_SLOT_LABELS[i]
        slot.position = Vector2(42 + width * i, 560)
        $UpgradeContainer.add_child(slot)

func _on_ball_removed(ball: Node) -> void:
    balls.erase(ball)
    var new_ball: RigidBody2D = BALL_SCENE.instantiate()
    new_ball.global_position = spawn_top.global_position
    new_ball.connect("removed", Callable(self, "_on_ball_removed"))
    add_child(new_ball)
    balls.append(new_ball)
