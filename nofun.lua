emu.softreset()
emu.speedmode("maximum")
states = {savestate.object(1),savestate.object(2)}
time = 0
goal = 0
goalold = 0
chances = 10
savetime = 120
emu.message("HI")

which = true

function r(thresh) -- random boolean
  if math.random() > thresh then return true else return false end
end

function skip(n)
  for i=1,n do 
    emu.frameadvance() 
    emu.message(i)
  end
  savestate.save(states[1])
  savestate.save(states[2])
  goal=xpos+100
  time=0
end

function die()
  --dies
  -- watch out for jumping higher than the screen
         emu.message("y: "..ypos.." vy: "..yvel)
         if chances==0 then --emu.pause()
                savestate.load(states[old])
                savestate.save(states[new])
                emu.frameadvance()
		time=0
                update_bytes()
		emu.message("had "..chances..", loaded old")
		goal=xpos3+100
		chances=20
                savetime=100
	   else chances=chances-1
                savetime=100
                if chances==0 then savetime=1000 end
                savestate.load(states[new])
                emu.frameadvance()
                update_bytes()
                goal = xpos3 + 100
                emu.message("Loaded newstate")
                time=0
         end
end


-- start the game, need to press start
for n = 0, 250, 1 do
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

function update_bytes()
  lives = memory.readbyte(0x075A)
  ypos1 = memory.readbyte(0x00CE)
  ypos2 = memory.readbyte(0x00B5)
  sprite= memory.readbyte(0x06D5)
  xpos  = memory.readbyte(0x006D)
  xpos2 = memory.readbyte(0x0086)
  yvel  = -memory.readbytesigned(0x009F)
  bowser= memory.readbyte(0x0723)  
  bowhp = memory.readbyte(0x0483)
  xpos3 =256*xpos+xpos2 -- this is the actual distance
  ypos  =ypos1*ypos2
end


function main()
  update_bytes()

  gui.text(50,50,"ypos: "..ypos)
  gui.text(50,60,"t left: "..savetime-time)
  gui.text(50,70,"x left: "..goal-xpos3)
  gui.text(50,80,"chances: "..chances)
  gui.text(50,90,"yvel: "..yvel)
  gui.text(50,100,"pipe: "..memory.readbyte(0x000E))
  gui.text(50,110,"bows: "..bowser)
  gui.text(50,120,"sprite: "..sprite)
  gui.text(50,130,"bowhp: "..bowhp)

--  if memory.readbyte(0x001D) == 0x03 
--   then emu.message("flag") 
--         goal=-1
--         --time=-1000
--         skip(1000)
--  end
  
  if memory.readbyte(0x000E) == 0x02
    then emu.message("pipe")
         goal =-1
         --time = -1000
         skip(300)
  end

-- save time by pre-emptively dying
  if ypos>176 or sprite==176 then die() end


-- save if we think we can
  if time > 70
    -- maybe check here how long to die from freefall
    -- like (ypos+jump)/5
    -- and ypos>=0
    and (xpos3>=goal or goal-xpos3>2000)
    then swap()
         savestate.save(states[new])
         time=0
         chances=20
         emu.message("Saving state")
         emu.frameadvance()
         update_bytes()
         goal=xpos3+100
         goalold=goal
  end

  if time > savetime then die() end
  
  -- the magic
  joypad.set(1,{B=1,A=r(0.1),right=r(0.15),down=r(0.5)});

  emu.frameadvance() -- This essentially tells FCEUX to keep running
  time=time+1

end


while true do main() end
