emu.softreset()
-- emu.speedmode("maximum")

time=0

function buttonString()
	s=""
	for i,x in pairs(joypad.get(1)) do 
		s=s..(x and 1 or 0) end
  	return s
end

function saveLearningData()
	 emu.message(buttonString())
	 gui.savescreenshotas(buttonString()..".png")


  if 0==time%100 then saveLearningData() end
  emu.frameadvance() -- This essentially tells FCEUX to keep running
  time=time+1

end


while true do main() end
