local function tohex(num)
	if not num then num = 0 end
	local hex = string.format("%x", num/3.92)
	if #hex == 1 then
		hex = "0"..hex
	end
	return hex
end
local function picker_fs(r,g,b)
	local fs ="size[6,1.4]" ..
	"box[0,0;4,0.4;red]" ..
	"scrollbar[0,0;4,0.4;horizontal;red;"..(tostring(r) or "0").."]" ..
	"box[0,0.5;4,0.4;green]" ..
	"scrollbar[0,0.5;4,0.4;horizontal;green;"..(tostring(g) or "0").."]" ..
	"box[0,1;4,0.4;blue]" ..
	"scrollbar[0,1;4,0.4;horizontal;blue;"..(tostring(b) or "0").."]" ..
	"box[4.5,0;1.4,1.4;#"..tohex(r)..tohex(g)..tohex(b).."]" ..
	"label[4,0;"..tohex(r).."]" ..
	"label[4,0.5;"..tohex(g).."]" ..
	"label[4,1;"..tohex(b).."]"
	core.show_formspec("color_picker",fs)
end
core.register_chatcommand("cpicker",{
  func = function(param)
	picker_fs()
end})
core.register_on_formspec_input(function(formname, fields)
	if formname ~= "color_picker" then return end
	local r = core.explode_scrollbar_event(fields.red).value
	local g = core.explode_scrollbar_event(fields.green).value
	local b = core.explode_scrollbar_event(fields.blue).value
	if not fields.quit and (r and g and b) then
		picker_fs(r,g,b)
	end
end)
