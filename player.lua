--emu.softreset()
for i=1,300,1 do emu.frameadvance() end

function string2table(s)
	t={}
	str=s
	str:gsub(".",function(c) table.insert(t,c==1) end)
	return table
end


function main()
	gui.savescreenshotas("temp_frame.png")
	emu.message("hi")
	os.execute("./simplify.sh temp_frame.png do_frame.png")
	emu.message("simplified the image!")
	bot = io.popen("./do.py")
	str = bot:read(8)
	emu.message(str)
	cmd = string2table(str)
	joypad.set(1,cmd)
	emu.frameadvance()
	bot:close()
end

while true do main() end
