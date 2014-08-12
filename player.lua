--emu.softreset()
--for i=1,300,1 do emu.frameadvance() end
emu.message("hi")
gui.savescreenshotas("temp_frame.png")

function string2table(s)
	emu.message("requested "..s)
	buttons = joypad.get(1)
	--buttons={up, down, left, right, A, B, start, select}
	i=1
	for key,val in pairs(buttons) do
		buttons[key]=(string.sub(s,i,i)=='1')
		i=i+1
		--print("pressed ",key,buttons[key])
	end
	return buttons
end

function table2string(t)
	s=""
	for i,x in pairs(t) do 
		s=s..(x and 1 or 0) end
  	return s
end


function main()
	gui.savescreenshotas("temp_frame.png")
	
	os.execute("./simplify.sh temp_frame.png do_frame.png")
	--emu.message("simplified the image!")
	bot = io.popen("./do.py")
	str = bot:read(8)
	cmd = string2table(str)
	joypad.set(1,cmd)
--[[	for k,v in pairs(cmd) do
		print(k,v)
	end]]
	emu.frameadvance()
	bot:close()
end

while true do main() end
