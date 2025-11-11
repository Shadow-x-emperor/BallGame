extends RigidBody2D

signal request_respawn(ball: Node)
signal removed(ball: Node)

const KILO := 1000
const MILLION := 1000000
const TWO_MILLION := 2000000

@export var base_radius: float = 6.0
@export var max_radius: float = 22.0
@export var score: int = 1

@onready var label: Label = $Label
@onready var shape: CircleShape2D = $CollisionShape2D.shape

func _ready() -> void:
    contact_monitor = true
    contacts_reported = 8
    update_visuals()

func apply_multiplier(multiplier: float) -> void:
    score = int(score * multiplier)
    update_visuals()

func update_visuals() -> void:
    label.text = _format_score(score)
    var radius := base_radius
    if score >= KILO and score < MILLION:
        radius = min(base_radius * (1.0 + 0.1 * log(score / KILO)), max_radius)
    elif score >= MILLION:
        radius = min(base_radius * (1.0 + 0.1 * (log(score / MILLION) + log(MILLION / KILO))), max_radius)
    shape.radius = radius

func reset_for_respawn(spawn_position: Vector2) -> void:
    global_position = spawn_position
    linear_velocity = Vector2.ZERO
    angular_velocity = 0.0
    sleeping = false
    emit_signal("request_respawn", self)

func remove_to_lower() -> void:
    emit_signal("removed", self)
    queue_free()

func is_heavy() -> bool:
    return score >= TWO_MILLION

func _format_score(value: int) -> String:
    if value >= MILLION:
        return str(value / MILLION) + "M"
    elif value >= KILO:
        return str(value / KILO) + "K"
    return str(value)
