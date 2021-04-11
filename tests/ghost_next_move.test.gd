extends WAT.Test

func test_norm_angle() -> void:
	asserts.is_true(GhostNextMove.norm_angle(270) == -90)
