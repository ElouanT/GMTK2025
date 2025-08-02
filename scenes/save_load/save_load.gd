extends Node

const save_location = "user://SaveFile.json"

var content_to_save: Dictionary = {
	record = 0.0
}

func _save() -> void:
	var file = FileAccess.open(save_location, FileAccess.WRITE)
	file.store_var(content_to_save.duplicate())
	file.close()
	
func _load() -> void:
	if FileAccess.file_exists(save_location):
		var file = FileAccess.open(save_location, FileAccess.READ)
		var data = file.get_var()
		file.close()
		
		var save_data = data.duplicate()
