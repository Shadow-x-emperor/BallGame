extends Area2D

@export var upward_force: float = 900.0
var bodies := []

func _ready() -> void:
    monitorable = true
    monitoring = true
    connect("body_entered", Callable(self, "_on_body_entered"))
    connect("body_exited", Callable(self, "_on_body_exited"))

func _physics_process(delta: float) -> void:
    for body in bodies:
        if body and body is RigidBody2D and body.has_method("is_heavy"):
            if not body.is_heavy():
                body.apply_central_force(Vector2(0, -upward_force))

func _on_body_entered(body: Node) -> void:
    if body is RigidBody2D and body.has_method("is_heavy"):
        bodies.append(body)

func _on_body_exited(body: Node) -> void:
    bodies.erase(body)
