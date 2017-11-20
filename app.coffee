flow = new FlowComponent

flow.showNext(OpenStep)

tabitemParent_0.states =
	hoverOn:
		backgroundColor: "rgba(0,120,120,0.2)"
	hoverOff:
		backgroundColor: "rgba(240,240,240,1)"
	selected:
		backgroundColor: "rgba(0,160,220,1)"

openButton_0.states =
	disabled:
		opacity: 0.5
	enabled: 
		opacity: 1
		backgroundColor: "#1199EE"
		animationOptions:
			time: 0.2
	pressed:
		backgroundColor: "#0877cc"

openButton_0.stateSwitch("disabled")
tabNameDeet_0.opacity = 0
descDeet_0.opacity = 0
lastModDeet_0.opacity = 0

tabitemParent_0.onMouseOver (event, layer) ->
	if this.states.current.name != "selected"
		tabitemParent_0.stateSwitch("hoverOn")
	
tabitemParent_0.onMouseOut (event, layer) ->
	if this.states.current.name != "selected"
		tabitemParent_0.stateSwitch("hoverOff")

tabitemParent_0.onMouseDown (event, layer) ->
	tabitemParent_0.stateSwitch("selected")
	tableIcon_0.color = "rgba(255,255,255,0.8)"
	tableName_0.color = "white"
	lastmodText_0.color = "white"
	openButton_0.animate("enabled")
	showTableDetails()
	
tabitemParent_0.onDoubleClick (event, layer) ->
	closeBigOpenAnimate()

showTableDetails = ->
	tabNameDeet_0.animate
		opacity: 1
		options:
			time: 0.2
	descDeet_0.animate
		opacity: 1
		options:
			time: 0.2
	lastModDeet_0.animate
		opacity: 1
		options:
			time: 0.2

openButton_0.onMouseDown (event, layer) ->
	if this.states.current.name == "enabled"
		openButton_0.stateSwitch("pressed")

openButton_0.onMouseUp (event, layer) ->
	if this.states.current.name == "pressed"
		openButton_0.stateSwitch("enabled")
		closeBigOpenAnimate()

closeBigOpenAnimate = ->
	tableDeets_0.visible = false
	bigOpenPanel_0.animate
		width: 400
		opacity: 0
		height: bigOpenPanel_0.height - 300
		options: 
			time: 0.25
	bigOpenPanel_0.animate
		y: bigOpenPanel_0.y - 50
		options:
			time: 1
	grid_0.animate
		opacity: 1
		options:
			delay: 0.25
			time: 0.5
	bigOpenPanel_0.onAnimationEnd ->
		bigOpenPanel_0.visible = false
		flow.showNext(AfterOpen, animate: false)
	LHP_0.animate
		width: 440
		options:
			time: 0.25
	collapseLHP_0.animate
		opacity: 1
		options:
			time: 0.25
	runLHP_0.height = 0
	runLHP_0.animate
		opacity: 0.5
		height: 40
		options:
			time: 0.25
			delay: 0.2
	RHP_0.animate
		opacity: 1
		options:
			time: 0.25
	openStepHeader_0.animate
		width: 355
		options:
			time: 0.25
	openStepIcon_0.animate
		backgroundColor: "#FFCC66"
		options:
			time: 0.2
			delay: 0.3
	openStepText_0.text = "Open table Chistmas Price Index"


op_desc = 
	select:
		header: "Select"
		short_desc: "Filter your table to match a criterion"
	pivot:
		header: "Pivot"
		short_desc: "Summarize your table with a tabulation"
	newCol:
		header: "New Column"
		short_desc: "Compute a new column"
	join:
		header: "Join"
		short_desc: "Join two tables on matching keys"
	sort:
		header: "Sort & Arrange"
		short_desc: "Sort and arrange columns in your table"
	append:
		header: "Append"
		short_desc: "Append rows from another table into current table"

focused_name_1=""
focused_button_1=""
changeFocusOp = (thing) ->
	focused_name_1 = thing.name
	focused_button_1 = thing
	temp_name = focused_name_1.substr(0,focused_name_1.length - 2)
	op_header_1.text = op_desc[temp_name].header
	op_short_desc_1.text = op_desc[temp_name].short_desc
	op_header_1.opacity = 0
	op_header_1.animate 
		opacity: 1
		options: 
			time: 0.4
	op_short_desc_1.opacity = 0
	op_short_desc_1.animate 
		opacity: 1
		options: 
			time: 0.4
	changeOpIcon(temp_name)
	
changeOpIcon = (opName) ->
	for icon in ["select","pivot","newCol","join","sort","append"]
		iconObject = icontainer_1.subLayersByName("icon_" + icon + "_1")[0]
		if opName == icon
			iconObject.opacity = 0
			iconObject.visible = true
			iconObject.animate 
				opacity: 1
				options: 
					time: 0.4
		else
			iconObject.visible = false

changeFocusOp(select_1)

for op_button in [select_1,pivot_1,newCol_1,join_1,sort_1,append_1]
	op_button.states = 
		hoverOn:
			backgroundColor: "rgba(255, 204, 102, 0.5)"
			borderColor: "rgba(255, 204, 102, 0.5)"
			animationOptions:
				time: 0.4
		hoverOff:
			backgroundColor: "white"
			borderWidth: 1
			borderColor: "rgba(187,187,187,1)"
		pressed:
			backgroundColor: "rgba(255, 204, 102, 1)"
			borderWidth: 0
			
	if op_button.name == focused_name_1
		op_button.stateSwitch("hoverOn")
	else
		op_button.stateSwitch("hoverOff")

	op_button.onMouseOver (event, layer) ->
		if this.states.current.name != "hoverOn"
			focused_button_1.stateSwitch("hoverOff")		
			this.animate("hoverOn")
			changeFocusOp(this)
	
	op_button.onMouseDown (event, layer) ->
		if this.states.current.name == "hoverOn"
			this.stateSwitch("pressed")
			
	op_button.onMouseUp (event, layer) ->
		if this.states.current.name == "pressed"
			this.stateSwitch("hoverOn")