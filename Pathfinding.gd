extends TileMap

var start_cell = Vector2()
var end_cell = Vector2(32, 19)
var current_cell = start_cell
var path = []
var neighbours = []

func set_path():
	for cell in path:
		set_cell(cell.x, cell.y, 1)

func find_neighbours():
	neighbours.clear()
	if get_cell(current_cell.x-1, current_cell.y) <= 1:
		#var g = abs(start_cell.x - current_cell.x-1) + abs(start_cell.y - current_cell.y)
		var h = abs(current_cell.x-1 - end_cell.x) + abs(current_cell.y - end_cell.y)
		#var f = g + h
		neighbours.append([Vector2(current_cell.x-1, current_cell.y), h])
		set_cell(current_cell.x-1, current_cell.y, 3)
	if get_cell(current_cell.x+1, current_cell.y) <= 1:
		#var g = abs(start_cell.x - current_cell.x+1) + abs(start_cell.y - current_cell.y)
		var h = abs(current_cell.x+1 - end_cell.x) + abs(current_cell.y - end_cell.y)
		#var f = g + h
		neighbours.append([Vector2(current_cell.x+1, current_cell.y), h])
		set_cell(current_cell.x+1, current_cell.y, 3)
	if get_cell(current_cell.x, current_cell.y-1) <= 1:
		#var g = abs(start_cell.x - current_cell.x) + abs(start_cell.y - current_cell.y-1)
		var h = abs(current_cell.x - end_cell.x) + abs(current_cell.y-1 - end_cell.y)
		#var f = g + h
		neighbours.append([Vector2(current_cell.x, current_cell.y-1), h])
		set_cell(current_cell.x, current_cell.y-1, 3)
	if get_cell(current_cell.x, current_cell.y+1) <= 1:
		#var g = abs(start_cell.x - current_cell.x) + abs(start_cell.y - current_cell.y+1)
		var h = abs(current_cell.x - end_cell.x) + abs(current_cell.y+1 - end_cell.y)
		#var f = g + h
		neighbours.append([Vector2(current_cell.x, current_cell.y+1), h])
		set_cell(current_cell.x, current_cell.y+1, 3)

func find_best_neighbour():
		var best_neighbour_position = Vector2()
		var best_neighbour_h = 9999999
		if neighbours.size() > 0:
			for neighbour in neighbours:
				if neighbour[1] < best_neighbour_h:
					best_neighbour_h = neighbour[1]
					best_neighbour_position = neighbour[0]
				elif neighbour[0] == end_cell:
					best_neighbour_h = neighbour[1]
					best_neighbour_position = neighbour[0]
					break
			current_cell = best_neighbour_position
			if current_cell == end_cell:
				set_path()
				set_cell(start_cell.x, start_cell.y, 1)
			else:
				path.append(current_cell)
				set_cell(current_cell.x, current_cell.y, 2)

func _ready():
	for y in range(20):
		for x in range(33):
			var ran = randi()%10+1
			if ran == 10:
				set_cell(x, y, 2)
			else:
				set_cell(x, y, 0)
	set_cell(start_cell.x, start_cell.y, 1)
	set_cell(end_cell.x, end_cell.y, 1)

func _physics_process(delta):
	if current_cell != end_cell:
		find_neighbours()
		find_best_neighbour()
