function distanceFrom(x1,y1,x2,y2) return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) end
function dirToPlayer(x,y) return {x = player.x-x, y=player.y-y} end
function outofscreen(x,y)  if(x > GB.width +50 or y > GB.height + 50 or x < -50 or y < -50 ) then return true else return false end  end
function normalize(x,y) local l=(x*x+y*y)^.5 if l==0 then return 0,0,0 else return x/l,y/l,l end end