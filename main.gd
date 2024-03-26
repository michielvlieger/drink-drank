extends Node2D

@onready var playerui = $Playerui
@onready var tile_map = $TileMap

const spawnLocations := [Vector2i(3,3),Vector2i(3,4),Vector2i(3,5),Vector2i(3,6), Vector2i(16,4), Vector2i(16,5)];

var players := [];
var pickedUpPlayer = null

func initiateBattle():
	var selectedItematlasCoord = Vector2i(1,0)
	for location in spawnLocations:
		tile_map.set_cell(1, location, 0, selectedItematlasCoord)
		players.append(location);

func _ready():
	initiateBattle()

func _input(_event):
	if Input.is_action_just_pressed("click"):
		var mouse_pos : Vector2 = get_global_mouse_position()
		var tilemap_pos : Vector2 = tile_map.local_to_map(mouse_pos)
		var tile_data: TileData = tile_map.get_cell_tile_data(1, tilemap_pos)
		var tile_data_background: TileData = tile_map.get_cell_tile_data(0, tilemap_pos)
		if pickedUpPlayer == null:
			if tile_data:
				pickUpPlayer(tilemap_pos)
		else:
			if !tile_data && tile_data_background:
				dropPlayer(tilemap_pos)

func pickUpPlayer(tilemap_pos: Vector2i):
	pickedUpPlayer = tilemap_pos
	playerui.visible = true
	tile_map.set_cell(1, tilemap_pos, 0)
	
func dropPlayer(tilemap_pos: Vector2i):
	pickedUpPlayer = null
	playerui.visible = false
	tile_map.set_cell(1, tilemap_pos, 0, Vector2i(1,0))
