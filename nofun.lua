emu.softreset()
emu.speedmode("maximum")
state = savestate.object();
time = 0
goal = 0
savetime = 150
emu.message("HI")

function r(thresh) -- random boolean
  if math.random() > thresh then return true else return false end
end

for n = 0, 200, 1 do
  if n==100 then joypad.set(1,{start=1}) end
  gui.text(50,90,n)
  emu.frameadvance()
end

savestate.save(state)
emu.message("Saved initial state")

xpos2=0
xpos=0

while true do
  lives = memory.readbyte(0x075A)
  ypos  = 176 - memory.readbyte(0x00CE)
  sprite= memory.readbyte(0x06D5)
  --xpos  = memory.readbyte(0x006D)
  if xpos2 == 127 then xpos=xpos+1 end
  xpos2 = memory.readbyte(0x071C)%128
  yvel  = memory.readbyte(0x009F)
  
  xpos3=128*xpos+xpos2

  gui.text(50,50,"ypos: "..ypos)
  gui.text(50,60,"time: "..time)
  gui.text(50,70,"xpos: "..xpos.."."..xpos2)
  gui.text(50,80,"yards: "..goal-xpos3)
  gui.text(50,90,"yvel: "..yvel)

  if memory.readbyte(0x001D) == 0x03 
    then emu.message("flag") 
         goal=-1
         time=-1000
  end

  if ypos<-50    or 
     sprite==176 or
     time > savetime 
    then savestate.load(state) 
         emu.message("You died and tried to load")
         time=-50
  end

  
  if time > (savetime - 10) 
     and yvel==0
     and xpos3>=goal
    then savestate.save(state); time=0
         emu.message("Saving state")
         goal=xpos3+150
  end
  
  joypad.set(1,{B=1,A=r(0.1),right=r(0.15)});

  emu.frameadvance() -- This essentially tells FCEUX to keep running
  time=time+1

end
