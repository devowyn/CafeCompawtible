extends TextureButton

func _ready():
	visible = false

func open():
	visible = true

func close():
	visible = false

# This built-in function fires automatically when the TextureButton is clicked!
func _pressed():
	print("1. The tablet was successfully clicked!")
	
	var current_customers = get_tree().get_nodes_in_group("Customer")
	print("2. I found this many customers: ", current_customers.size())
	
	if current_customers.size() > 0:
		print("3. Telling the customer to leave now!")
		current_customers[0].start_leaving()
		close()
	else:
		print("3. ERROR: I couldn't find anyone in the 'Customer' group!")
	close()
