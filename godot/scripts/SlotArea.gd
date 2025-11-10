extends Area2D

@export_enum("Multiplier", "Upgrade") var slot_kind: String = "Multiplier"
@export var multiplier: float = 2.0
@export var label: String = "x2"
@export var respawn_path: NodePath

@onready var label_node: Label = $Label
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
var respawn_marker: Node2D

func _ready() -> void:
    label_node.text = label
    if respawn_path != NodePath(""):
        respawn_marker = get_node(respawn_path) as Node2D
    connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
    if slot_kind == "Multiplier" and body.has_method("apply_multiplier") and body.has_method("reset_for_respawn"):
        body.apply_multiplier(multiplier)
        if respawn_marker:
            body.reset_for_respawn(respawn_marker.global_position)
    elif slot_kind == "Upgrade" and body.has_method("remove_to_lower"):
        body.remove_to_lower()
