emu.softreset()
emu.speedmode("maximum")
states = {savestate.object(),savestate.object()}
time = 0
goal = 0
savetime = 100
emu.message("HI")

which = true

function r(thresh) -- random boolean
  if math.random() > thresh then return true else return false end
end

for n = 0, 200, 1 do
  if n==100 then joypad.set(1,{start=1}) end
  gui.text(50,90,n)
  emu.frameadvance()
end


savestate.save(states[1])
savestate.save(states[2])
emu.message("Saved initial state")

xpos2=0
xpos=0

while true do
  lives = memory.readbyte(0x075A)
  ypos  = 176 - memory.readbyte(0x00CE)
  sprite= memory.readbyte(0x06D5)
  xpos  = memory.readbyte(0x006D)
  xpos2 = memory.readbyte(0x0086)
  yvel  = memory.readbyte(0x009F)
  
  xpos3=256*xpos+xpos2

  gui.text(50,50,"ypos: "..ypos)
  gui.text(50,60,"time: "..time)
  gui.text(50,70,"xpos: "..xpos.."."..xpos2)
  gui.text(50,80,"yards: "..xpos3)
  gui.text(50,90,"yvel: "..yvel)

  if memory.readbyte(0x001D) == 0x03 
    then emu.message("flag") 
         goal=-1
         time=-1000
  end
  
  if memory.readbyte(0x000E) == 0x02
    then emu.message("pipe")
         goal =-1
         time = -1000
  end


  if ypos<-50    or 
     sprite==176 or
     time > savetime 
    then 
         if time < -40 or goal-xpos>20
           then savestate.load(states[2])
                goal=goal-100
                emu.message("loaded oldstate")
           else savestate.load(states[1]) 
                emu.message("Loaded newstate")
         end
         time=-50
  end

  
  if time > (savetime - 10) 
     and yvel==0
     and xpos3>=goal
    then savestate.save(states[1])
         if ypos==0 then savestate.save(states[2]) end
         time=0
         emu.message("Saving state")
         goal=xpos3+150
  end
  
  joypad.set(1,{B=1,A=r(0.1),right=r(0.15)});

  emu.frameadvance() -- This essentially tells FCEUX to keep running
  time=time+1

end
