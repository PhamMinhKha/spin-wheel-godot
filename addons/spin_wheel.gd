extends Control

@export var is_spin: bool = false
@export var speed: int = 10
@export var power: int = 2
@export var reward_position = 0
signal sig_reward
var vat_pham = [
	{
		"name": "Dark blue",
		"from": 0,
		"to": 45,
		"ma_vat_pham": 200,
		"ten_vat_pham": "Thanh Long"
	},
	{
		"name": "Dark green",
		"from": 45,
		"to": 90,
		"ma_vat_pham": 0,
		"ten_vat_pham": "Gạch"
	},
	{
		"name": "Blue",
		"from": 90,
		"to": 135,
		"ma_vat_pham": 204,
		"ten_vat_pham": "Chanh"
	},
	{
		"name": "Yellow",
		"from": 135,
		"to": 180,
		"ma_vat_pham": 203,
		"ten_vat_pham": "Dưa Hấu"
	},
	{
		"name": "Purple",
		"from": 180,
		"to": 225,
		"ma_vat_pham": 201,
		"ten_vat_pham": "Sầu Riêng"
	},
	{
		"name": "Green",
		"from": 225,
		"to": 270,
		"ma_vat_pham": 0,
		"ten_vat_pham": "Gạch"
	},
	{
		"name": "Orange",
		"from": 270,
		"to": 315,
		"ma_vat_pham": 202,
		"ten_vat_pham": "Vãi"
	},
	{
		"name": "Pink",
		"from": 315,
		"to": 360,
		"ma_vat_pham": 0,
		"ten_vat_pham": "Gạch"
	}
	]

func _on_btn_spin_pressed():
	if is_spin == false:
		is_spin = true
		var tween = get_tree().create_tween().set_parallel(true)
		tween.connect("finished", func():
			#after tween finish animation, this function is call
			var old_rotation_degrees = %front.rotation_degrees
			#set is_spin = false to tell for user can press again
			is_spin = false
			if old_rotation_degrees > 360:
				#This part is to fix the error that when rotating the steamer once, it will not rotate counterclockwise
				var rad_ = fmod(old_rotation_degrees, 360)
				%front.rotation_degrees = rad_
			)
		reward_position = randi_range(0, 360) #random position from 0 to 360 degrees

		for item in vat_pham:
			if reward_position >= item.from - 22.5 and reward_position <= item.to - 22.5:
				print(item.name)
				#signal for another scene
				sig_reward.emit(item.ma_vat_pham)
		tween.tween_property(%front, "rotation_degrees", reward_position +  360 * speed * power , 3).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CIRC)
		tween.finished
	



