extends StaticBody2D

@export var radius: float = 6.0
@export var color: Color = Color(0.86, 0.86, 0.86, 1.0)

func _ready() -> void:
    if $CollisionShape2D.shape is CircleShape2D:
        ($CollisionShape2D.shape as CircleShape2D).radius = radius
    update()

func _draw() -> void:
    draw_circle(Vector2.ZERO, radius, color)
