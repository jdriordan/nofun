emu.softreset()
emu.speedmode("maximum")
states = {savestate.object(1),savestate.object(2)}
time = 0
goal = 0
chances = 10
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

new=1
old=2

function swap()
  temp=old
  old=new
  new=temp
end


while true do
  lives = memory.readbyte(0x075A)
  ypos  = 176 - memory.readbyte(0x00CE)
  sprite= memory.readbyte(0x06D5)
  xpos  = memory.readbyte(0x006D)
  xpos2 = memory.readbyte(0x0086)
  yvel  = memory.readbyte(0x009F)
  
  xpos3=256*xpos+xpos2 -- this is the actual distance

  gui.text(50,50,"ypos: "..ypos)
  gui.text(50,60,"time: "..time)
  gui.text(50,70,"goal: "..goal-xpos3)
  gui.text(50,80,"chances: "..chances)
  gui.text(50,90,"yvel: "..yvel)
  gui.text(50,100,"pipe: "..memory.readbyte(0x000E))

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


  if (ypos<-50    or 
      sprite==176 or
      time > savetime)
    then 
         if chances==0 
	   then --emu.pause()
                savestate.load(states[old])
		goal=xpos3+100
		time=0
		emu.message("had "..chances..", loaded old")
		chances=10
	   else chances=chances-1
                savestate.load(states[new])
                goal=xpos3+100
                emu.message("Loaded newstate")
                time=0
         end
  end

  
  if time > (savetime - 10) 
  --   and yvel==0
     and xpos3>=goal
    then savestate.save(states[new])
         swap()
         time=0
         chances=10
         emu.message("Saving state")
         goal=xpos3+100
  end
  
  joypad.set(1,{B=1,A=r(0.1),right=r(0.15)});

  emu.frameadvance() -- This essentially tells FCEUX to keep running
  time=time+1

end
