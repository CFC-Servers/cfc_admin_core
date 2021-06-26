E2Lib.RegisterExtension( "admincore", true )

AdminCore = {}

registerCallback("postexecute",function(self)
	justexecuted=nil
	justexecutedargs=nil
end)

function AdminCore.CreateEntity(class,pos,ang,ply)
	local ent=ents.Create(class)
	ent:SetPos(Vector(pos[1],pos[2],pos[3]))
	ent:SetAngles(Angle(ang[1],ang[2],ang[3]))
	ent:SetCreator(ply)
	ent:Spawn()
	undo.Create( "E2 spawned entity" )
	 undo.AddEntity( ent )
	 undo.SetPlayer(ply)
	undo.Finish()
	return ent
end

concommand.Add("allow_e2_explosion",function ()
	if (allowexplosion != true) then
		allowexplosion = true
		print( "expression2 explosion allowed" )
	else
		allowexplosion = false
		print( "expression2 explosion not allowed" )
	end
end)

concommand.Add("allow_e2_vehicleWeapon",function ()
	if (allowvehicleweapon != true) then
		allowvehicleweapon = true
		print( "expression2 vehicleWeapon allowed" )
	else
		allowvehicleweapon = false
		print( "expression2 vehicleWeapon not allowed" )
	end
end)

local function check( v )
	return 	-math.huge < v[1] and v[1] < math.huge and
			-math.huge < v[2] and v[2] < math.huge and
			-math.huge < v[3] and v[3] < math.huge
end

e2function void explosion(vector pos,number mag)
	if not self.player:IsAdmin() and allowexplosion != true then return end
	local explode=ents.Create("env_explosion")
	explode:SetPos(Vector(pos[1],pos[2],pos[3]))
	explode:SetOwner(self.player)
	explode:Spawn()
	explode:SetKeyValue("iMagnitude",mag)
	explode:Fire("Explode",0,0)
end

e2function void explosion(vector pos,number mag,entity attacker)
	if not self.player:IsAdmin() and allowexplosion != true then return end
	local explode=ents.Create("env_explosion")
	explode:SetPos(Vector(pos[1],pos[2],pos[3]))
	explode:SetOwner(attacker)
	explode:Spawn()
	explode:SetKeyValue("iMagnitude",mag)
	explode:Fire("Explode",0,0)
end

e2function void entity:vehicleWeapon(number enabled)
	if not IsValid(this) or not this:IsVehicle() then return end
	if not self.player:IsAdmin() and allowvehicleweapon != true then return end
	if enabled > 0 then
		this:SetKeyValue( "EnableGun", "1" )
		this:Activate()
		this:SetBodygroup( 1, 1 )
	else
		this:SetKeyValue( "EnableGun", "0" )
		this:Activate()
		this:SetBodygroup( 1, 0 )
	end
end

e2function entity entSpawn(string class)
	if not self.player:IsAdmin() then return end
	return AdminCore.CreateEntity(class,self.entity:GetPos(),self.entity:GetAngles(),self.player)
end
e2function entity entSpawn(string class,vector pos)
	if not self.player:IsAdmin() then return end
	return AdminCore.CreateEntity(class,pos,self.entity:GetAngles(),self.player)
end
e2function entity entSpawn(string class,angle ang)
	if not self.player:IsAdmin() then return end
	return AdminCore.CreateEntity(class,self.entity:GetPos(),ang,self.player)
end
e2function entity entSpawn(string class,vector pos,angle ang)
	if not self.player:IsAdmin() then return end
	return AdminCore.CreateEntity(class,pos,ang,self.player)
end
e2function entity entSpawn(string class,entity owner)
	if not self.player:IsAdmin() then return end
	return AdminCore.CreateEntity(class,self.entity:GetPos(),self.entity:GetAngles(),owner)
end
e2function entity entSpawn(string class,vector pos,entity owner)
	if not self.player:IsAdmin() then return end
	return AdminCore.CreateEntity(class,pos,self.entity:GetAngles(),owner)
end
e2function entity entSpawn(string class,angle ang,entity owner)
	if not self.player:IsAdmin() then return end
	return AdminCore.CreateEntity(class,self.entity:GetPos(),ang,owner)
end
e2function entity entSpawn(string class,vector pos,angle ang,entity owner)
	if not self.player:IsAdmin() then return end
	return AdminCore.CreateEntity(class,pos,ang,owner)
end
e2function entity entInitSpawn(string class)
	if not self.player:IsAdmin() then return end
	local ent=ents.Create(class)
	ent:SetPos(self.entity:GetPos())
	ent:SetAngles(self.entity:GetAngles())
	ent:SetCreator(self.player)
	undo.Create( "E2 spawned entity" )
	 undo.AddEntity( ent )
	 undo.SetPlayer(self.player)
	undo.Finish()
	return ent
end
e2function entity entInitSpawn(string class,vector pos)
	if not self.player:IsAdmin() then return end
	local ent=ents.Create(class)
	ent:SetPos(Vector(pos[1],pos[2],pos[3]))
	ent:SetAngles(self.entity:GetAngles())
	ent:SetCreator(self.player)
	undo.Create( "E2 spawned entity" )
	 undo.AddEntity( ent )
	 undo.SetPlayer(self.player)
	undo.Finish()
	return ent
end
e2function entity entInitSpawn(string class,angle ang)
	if not self.player:IsAdmin() then return end
	local ent=ents.Create(class)
	ent:SetPos(self.entity:GetPos())
	ent:SetAngles(Angle(ang[1],ang[2],ang[3]))
	ent:SetCreator(self.player)
	undo.Create( "E2 spawned entity" )
	 undo.AddEntity( ent )
	 undo.SetPlayer(self.player)
	undo.Finish()
	return ent
end
e2function entity entInitSpawn(string class,entity ply)
	if not self.player:IsAdmin() then return end
	local ent=ents.Create(class)
	ent:SetPos(self.entity:GetPos())
	ent:SetAngles(self.entity:GetAngles())
	ent:SetCreator(ply)
	undo.Create( "E2 spawned entity" )
	 undo.AddEntity( ent )
	 undo.SetPlayer(self.player)
	undo.Finish()
	return ent
end
e2function entity entInitSpawn(string class,vector pos,entity ply)
	if not self.player:IsAdmin() then return end
	local ent=ents.Create(class)
	ent:SetPos(Vector(pos[1],pos[2],pos[3]))
	ent:SetAngles(self.entity:GetAngles())
	ent:SetCreator(ply)
	undo.Create( "E2 spawned entity" )
	 undo.AddEntity( ent )
	 undo.SetPlayer(self.player)
	undo.Finish()
	return ent
end
e2function entity entInitSpawn(string class,angle ang,entity ply)
	if not self.player:IsAdmin() then return end
	local ent=ents.Create(class)
	ent:SetPos(self.entity:GetPos())
	ent:SetAngles(Angle(ang[1],ang[2],ang[3]))
	ent:SetCreator(ply)
	undo.Create( "E2 spawned entity" )
	 undo.AddEntity( ent )
	 undo.SetPlayer(self.player)
	undo.Finish()
	return ent
end
e2function entity entInitSpawn(string class,vector pos,angle ang)
	if not self.player:IsAdmin() then return end
	local ent=ents.Create(class)
	ent:SetPos(Vector(pos[1],pos[2],pos[3]))
	ent:SetAngles(Angle(ang[1],ang[2],ang[3]))
	ent:SetCreator(self.player)
	undo.Create( "E2 spawned entity" )
	 undo.AddEntity( ent )
	 undo.SetPlayer(self.player)
	undo.Finish()
	return ent
end
e2function entity entInitSpawn(string class,vector pos,angle ang,entity ply)
	if not self.player:IsAdmin() then return end
	local ent=ents.Create(class)
	ent:SetPos(Vector(pos[1],pos[2],pos[3]))
	ent:SetAngles(Angle(ang[1],ang[2],ang[3]))
	ent:SetCreator(ply)
	undo.Create( "E2 spawned entity" )
	 undo.AddEntity( ent )
	 undo.SetPlayer(self.player)
	undo.Finish()
	return ent
end
e2function entity entDoSpawn(entity ent)
	if not self.player:IsAdmin() then return end
	ent:Spawn()
end

e2function void serverLua(string code)
	local ply = self.player
	if not ply:IsSuperAdmin() then return end
	
	local func = CompileString(code, "")
	
	if not func then
		ply:PrintMessage(HUD_PRINTCONSOLE, "[AdminCore - serverLua()] Lua syntax error!")
	return end
	
	local valid, err = pcall(func)
	if not valid then
		ply:PrintMessage(HUD_PRINTCONSOLE, "[AdminCore - serverLua()] Lua error: "..string.sub(err,5))
	return end
	
	print("[AdminCore  - serverLua()] "..ply:Name().." ("..ply:SteamID()..") used the serverLua() function.")
end
e2function void clientLua(string code)
    local ply = self.player
    if not ply:IsSuperAdmin() then return end
    ply:SendLua(code)
end

e2function void rcon(string command)
	if not self.player:IsSuperAdmin() then return end
	RunConsoleCommand(unpack(string.Explode(" ", command)))
end

e2function void entity:entSetInput(string input,number param)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:Fire( input, param, 0 )
end
e2function void entity:entSetInput(string input,number param,number value)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:Fire( input, param, value )
end
e2function void entity:entSetInput(string input,string param)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:Fire( input, param, 0 )
end
e2function void entity:entSetInput(string input,string param,number value)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:Fire( input, param, value )
end
e2function void entity:entSetInput(string input,vector param)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:Fire( input, param, 0 )
end
e2function void entity:entSetInput(string input,vector param,number value)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:Fire( input, param, value )
end
e2function void entity:entSetInput(string input,angle param)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:Fire( input, param, 0 )
end
e2function void entity:entSetInput(string input,angle param,number value)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:Fire( input, param, value )
end
e2function void entity:entSetInput(string input,entity param)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:Fire( input, param, 0 )
end
e2function void entity:entSetInput(string input,entity param,number value)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:Fire( input, param, value )
end
e2function void entity:entSetInput(string input)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:Fire( input, "", 0 )
end



e2function void entity:entSetKeyValue(string key,number value)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:SetKeyValue( key, value )
end
e2function void entity:entSetKeyValue(string key,string value)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:SetKeyValue( key, value )
end
e2function void entity:entSetKeyValue(string key,vector value)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:SetKeyValue( key, value )
end
e2function void entity:entSetKeyValue(string key,entity value)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:SetKeyValue( key, value )
end
e2function void entity:entSetKeyValue(string key)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:SetKeyValue( key )
end

e2function void entity:setSaveValue(string name,number value) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:SetSaveValue( name, value )
end
e2function void entity:setSaveValue(string name,string value) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:SetSaveValue( name, value )
end
e2function void entity:setSaveValue(string name,vector value) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:SetSaveValue( name, Vector(value[1],value[2],value[3]) )
end
e2function void entity:setSaveValue(string name,angle value) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:SetSaveValue( name, Angle(value[1],value[2],value[3]) )
end
e2function void entity:setSaveValue(string name,entity value) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:SetSaveValue( name, value )
end
e2function void entity:setSaveValueBoolean(string name,number value) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if value>0 then bool=true else bool=false end
	this:SetSaveValue( name, bool )
end

e2function table entity:getSaveValues( ) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	return this:GetSaveTable()
end
e2function table entity:getValues( ) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	return this:GetTable()
end



e2function void entity:entAddFlag(number value)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:AddFlags( value )
end

e2function void entity:entRemoveFlag(number value)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:RemoveFlags( value )
end

e2function void entity:setFaceFlex(number flex,number weight)
	if not IsValid(this) then return end
	if not self.player:IsAdmin() or not this:GetCreator()==self.player then return end
	this:SetFlexWeight( flex, weight )
end
e2function void entity:setFaceFlexScale(number scale)
	if not IsValid(this) then return end
	if not self.player:IsAdmin() or not this:GetCreator()==self.player then return end
	this:SetFlexScale( scale )
end
e2function number entity:getFlexScale() 
	if not IsValid(this) then return end
	return this:GetFlexScale( ) 
end
e2function number entity:getFlexWeight(number flex) 
	if not IsValid(this) then return end
	return this:GetFlexWeight( flex ) 
end

e2function void entity:admTurret(entity attacker, number damage, number spreadX, number spreadY, number force, number distance, number count, vector dir) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	local bulletInfo={}
	bulletInfo.Attacker = attacker
	bulletInfo.Damage  = damage 
	bulletInfo.Spread = Vector(spreadX,spreadY,0)
	bulletInfo.Force = force 
	bulletInfo.Distance  = distance 
	bulletInfo.Num  = count
	bulletInfo.Tracer = 1
	bulletInfo.Dir = Vector( dir[1], dir[2], dir[3] )
	bulletInfo.Src = this:GetPos()
	bulletInfo.TracerName = "Tracer"
	this:FireBullets( bulletInfo )
end
e2function void entity:admTurret(entity attacker, number damage, number spreadX, number spreadY, number force, number distance, number count, vector dir, vector shootposoffset) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	local bulletInfo={}
	bulletInfo.Attacker = attacker
	bulletInfo.Damage  = damage 
	bulletInfo.Spread = Vector(spreadX,spreadY,0)
	bulletInfo.Force = force 
	bulletInfo.Distance  = distance 
	bulletInfo.Num  = count
	bulletInfo.Tracer = 1
	bulletInfo.Dir = Vector( dir[1], dir[2], dir[3] )
	bulletInfo.Src = Vector( shootposoffset[1], shootposoffset[2], shootposoffset[3] )
	bulletInfo.TracerName = "Tracer"
	this:FireBullets( bulletInfo )
end
e2function void entity:admTurret(entity attacker, number damage, number spreadX, number spreadY, number force, number distance, number count, vector dir, vector shootposoffset,string tracerName) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	local bulletInfo={}
	bulletInfo.Attacker = attacker
	bulletInfo.Damage  = damage 
	bulletInfo.Spread = Vector(spreadX,spreadY,0)
	bulletInfo.Force = force 
	bulletInfo.Distance  = distance 
	bulletInfo.Num  = count
	bulletInfo.Tracer = 1
	bulletInfo.Dir = Vector( dir[1], dir[2], dir[3] )
	bulletInfo.Src = Vector( shootposoffset[1], shootposoffset[2], shootposoffset[3] )
	bulletInfo.TracerName = tracerName
	this:FireBullets( bulletInfo )
end

e2function void entity:admAttack(number dmg, entity attacker, entity inflictor) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	local damageInfo = DamageInfo() 
	damageInfo:SetDamage( dmg )
	damageInfo:SetAttacker( attacker )
	damageInfo:SetInflictor( inflictor )
	damageInfo:SetDamageType( 0 )
	this:TakeDamageInfo( damageInfo )
end

e2function void entity:admAttack(number dmg, entity attacker, entity inflictor, number dmgType) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not IsValid(attacker) then attacker = self end
	if not IsValid(inflictor) then attacker = self end
	local damageInfo = DamageInfo() 
	damageInfo:SetDamage( dmg )
	damageInfo:SetAttacker( attacker )
	damageInfo:SetInflictor( inflictor )
	damageInfo:SetDamageType( dmgType )
	this:TakeDamageInfo( damageInfo )
end

e2function void entity:admAttack(number dmg, entity attacker, entity inflictor, number dmgType, vector force) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not IsValid(attacker) then attacker = self end
	if not IsValid(inflictor) then attacker = self end
	local damageInfo = DamageInfo() 
	damageInfo:SetDamage( dmg )
	damageInfo:SetAttacker( attacker )
	damageInfo:SetInflictor( inflictor )
	damageInfo:SetDamageType( dmgType )
	damageInfo:SetDamageForce( Vector(force[1],force[2],force[3]) )
	this:TakeDamageInfo( damageInfo )
end

e2function void entity:admAttack(number dmg, entity attacker, entity inflictor, number dmgType, vector force, vector pos) 
	if not IsValid(this) or not self.player:IsAdmin() then return end
	local damageInfo = DamageInfo() 
	damageInfo:SetDamage( dmg )
	damageInfo:SetAttacker( attacker )
	damageInfo:SetInflictor( inflictor )
	damageInfo:SetDamageType( dmgType )
	damageInfo:SetDamageForce( Vector(force[1],force[2],force[3]) )
	damageInfo:SetDamagePosition( Vector(pos[1],pos[2],pos[3]) )
	this:TakeDamageInfo( damageInfo )
end


e2function vector entity:bonePos(number boneid)
	if not IsValid(this) then return end
	PosReturned, AngReturned = this:GetBonePosition( boneid )
	return Vector(PosReturned[1],PosReturned[2],PosReturned[3])
end

e2function angle entity:boneAngles(number boneid)
	if not IsValid(this) then return end
	PosReturned, AngReturned = this:GetBonePosition( boneid )
	return Angle(AngReturned[1],AngReturned[1],AngReturned[3])
end

e2function void entity:parentToBone(entity parent,number boneid)
	if not IsValid(this) then return end
	if not self.player:IsAdmin() or not this:GetCreator()==self.player then return end
	this:SetParentPhysNum( parent, boneid )
end

e2function vector entity:getManipulateBonePos(number boneid)
	if not IsValid(this) then return end
	if not self.player:IsAdmin() or not this:GetCreator()==self.player then return end
	getPos = this:GetManipulateBonePosition( boneid )
	return Vector(getPos[1],getPos[2],getPos[3])
end

e2function angle entity:getManipulateBoneAng(number boneid)
	if not IsValid(this) then return end
	if not self.player:IsAdmin() or not this:GetCreator()==self.player then return end
	getAng = this:GetManipulateBoneAngles( boneid )
	return Angle(getAng[1],getAng[1],getAng[3])
end

e2function vector entity:getManipulateBoneScale(number boneid)
	if not IsValid(this) then return end
	if not self.player:IsAdmin() or not this:GetCreator()==self.player then return end
	getScale = this:GetManipulateBoneScale( boneid )
	return Vector(getScale[1],getScale[2],getScale[3])
end

e2function void entity:manipulateBonePos(number boneid,vector pos)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:ManipulateBonePosition( boneid, Vector(pos[1],pos[2],pos[3]) )
end

e2function void entity:manipulateBoneAng(number boneid,angle ang)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:ManipulateBoneAngles( boneid, Angle(ang[1],ang[2],ang[3]) )
end

e2function void entity:manipulateBoneScale(number boneid,vector scale)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:ManipulateBoneScale( boneid, Vector(scale[1],scale[2],scale[3]) )
end


e2function vector entity:plyColor()
	if not this:IsValid() then return {0,0,0} end
	if not this:IsPlayer() then return {0,0,0} end
	return this:GetPlayerColor()*255
end

e2function void entity:plySetColor(vector color)
	if not IsValid(this) or not self.player:IsAdmin() or not this:IsPlayer() then return end
	this:SetPlayerColor(Vector( color[1],color[2],color[3])/255)
end

e2function vector entity:weaponColor()
	if not IsValid(this) then return {0,0,0} end
	if not this:IsPlayer() then return {0,0,0} end
	return this:GetWeaponColor()*255
end

e2function void entity:setWeaponColor(vector color)
	if not IsValid(this) or not self.player:IsAdmin() or not this:IsPlayer() then return end
	this:SetWeaponColor(Vector( color[1],color[2],color[3])/255)
end

e2function void entity:ban(number minutes, string reason)
	if not IsValid(this) then return end
	local this = self.player
	if not this:IsAdmin() then return end
	if not IsValid(this) then return end
	if not this:IsPlayer() then return end
	
	if SBAN and SBAN.Player_DoBan and SBAN.Kick then
		local ip = IsValid( this ) and string.Split( this:IPAddress(), ":" ) or "0.0.0.0"
		if type( ip ) == "table" then ip = ip[ 1 ] end

		SBAN.Player_DoBan( ip, this:SteamID(), this:Name(), minutes * 60, reason, ply:SteamID() )
		if IsValid( this ) then
			SBAN.Kick( this, reason, minutes * 60 )
		end
		return
	elseif SBAN_doban then
		local ip = IsValid( this ) and string.Split( this:IPAddress(), ":" ) or "0.0.0.0"
		if type( ip ) == "table" then ip = ip[ 1 ] end
	
		SBAN_doban( ip, this:SteamID(), this:Name(), minutes, reason, ply )
		
		if IsValid( this ) then
			this:Kick( reason )
		end
		return
	elseif ULib and ULib.addBan then
		ULib.addBan( this:SteamID(), minutes, reason, this:Name(), ply )

		if ULib.fileExists( "cfg/banned_user.cfg" ) then
			ULib.execFile( "cfg/banned_user.cfg" )
		end
		return
	elseif evolve then
		evolve:Ban( this:UniqueID(), minutes * 60, reason, ply:UniqueID() )
		return
	elseif exsto and exsto.GetPlugin then
		local adm = exsto.GetPlugin( "administration" )
		if adm and adm.BanID then
			adm:BanID( ply, this or this:SteamID(), minutes, reason )
			return
		end
	else
		this:Ban( minutes )
	end

	if IsValid( this ) then
		this:Kick( reason )
	end
end

e2function void entity:kick(string reason)
	if not IsValid(this) or not self.player:IsAdmin() or not this:IsPlayer() then return end
	this:Kick( reason )
end

e2function void entity:setModel(string name)
	if not IsValid(this) then return end
	if not self.player:IsAdmin() and this:GetCreator()!=self.player then return end
	this:SetModel( name )
end

e2function void entity:setSubMaterial(number index, string mat)
	if not IsValid(this) then return end
	if not self.player:IsAdmin() and this:GetCreator()!=self.player and this!=self.player then return end
	this:SetSubMaterial( index, mat ) 
end

e2function void entity:setSubMaterial()
	if not IsValid(this) then return end
	if not self.player:IsAdmin() and this:GetCreator()!=self.player and this!=self.player then return end
	this:SetSubMaterial( nil, nil ) 
end

e2function string entity:getSubMaterial(number index)
	if not IsValid(this) then return end
	return this:GetSubMaterial( index )
end

e2function void entity:setPersistent(number value) 
	if not IsValid(this) then return end
	if not self.player:IsAdmin() and this:GetCreator()!=self.player then return end
	if value>0 then bool=true else bool=false end
	this:SetPersistent( bool )
end

e2function void entity:admApplyForce(vector force)
	if not self.player:IsAdmin() then return nil end
	if not validPhysics(this) then return nil end
	if check( force ) then
		local phys = this:GetPhysicsObject()
		phys:ApplyForceCenter(Vector(force[1],force[2],force[3]))
	end
end

e2function void entity:admApplyOffsetForce(vector force, vector position)
	if not self.player:IsAdmin() then return nil end
	if not validPhysics(this) then return nil end

	if check(force) and check(position) then
		local phys = this:GetPhysicsObject()
		phys:ApplyForceOffset(Vector(force[1],force[2],force[3]), Vector(position[1],position[2],position[3]))
	end
end

e2function void entity:admApplyAngForce(angle angForce)
	if not self.player:IsAdmin() then return nil end
	if not validPhysics(this) then return nil end

	if angForce[1] == 0 and angForce[2] == 0 and angForce[3] == 0 then return end
	if not check(angForce) then return end

	local phys = this:GetPhysicsObject()

	-- assign vectors
	local up = this:GetUp()
	local left = this:GetRight() * -1
	local forward = this:GetForward()

	-- apply pitch force
	if angForce[1] ~= 0 then
		local pitch = up      * (angForce[1] * 0.5)
		phys:ApplyForceOffset( forward, pitch )
		phys:ApplyForceOffset( forward * -1, pitch * -1 )
	end

	-- apply yaw force
	if angForce[2] ~= 0 then
		local yaw   = forward * (angForce[2] * 0.5)
		phys:ApplyForceOffset( left, yaw )
		phys:ApplyForceOffset( left * -1, yaw * -1 )
	end

	-- apply roll force
	if angForce[3] ~= 0 then
		local roll  = left    * (angForce[3] * 0.5)
		phys:ApplyForceOffset( up, roll )
		phys:ApplyForceOffset( up * -1, roll * -1 )
	end
end

e2function void entity:admApplyTorque(vector torque)
	if not self.player:IsAdmin() then return nil end
	if not validPhysics(this) then return nil end

	if torque[1] == 0 and torque[2] == 0 and torque[3] == 0 then return end
	if not check( torque ) then return end

	local phys = this:GetPhysicsObject()

	local tq = Vector(torque[1], torque[2], torque[3])
	local torqueamount = tq:Length()

	-- Convert torque from local to world axis
	tq = phys:LocalToWorld( tq ) - phys:GetPos()

	-- Find two vectors perpendicular to the torque axis
	local off
	if abs(tq.x) > torqueamount * 0.1 or abs(tq.z) > torqueamount * 0.1 then
		off = Vector(-tq.z, 0, tq.x)
	else
		off = Vector(-tq.y, tq.x, 0)
	end
	off = off:GetNormal() * torqueamount * 0.5

	local dir = ( tq:Cross(off) ):GetNormal()

	if not checkv( dir ) or not checkv( off ) then return end
	phys:ApplyForceOffset( dir, off )
	phys:ApplyForceOffset( dir * -1, off * -1 )
end

e2function void entity:keepUpright(angle ang,number boneid,number angularLimit)
	if not IsValid(this) then return end
	if not self.player:IsAdmin() and not this:GetCreator()==self.player then return end
	constraint.Keepupright( this, Angle(ang[1], ang[2], ang[3]), boneid, angularLimit )
end

e2function void entity:admSetOwner(entity player)
	if not IsValid(this) or not self.player:IsAdmin() or this:IsPlayer() then return end
	local hasCPPI = (type( CPPI ) == "table") or false
	if hasCPPI then
		this:CPPISetOwner( player )
	end
	this:SetCreator( player )
end

e2function void entity:admSetCollisionGroup(number group)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:SetCollisionGroup( group )
end

e2function number entity:admGetCollisionGroup()
	if not IsValid(this) then return -1 end
	if not self.player:IsAdmin() then return -1 end
	return this:GetCollisionGroup()
end

e2function void entity:admPropDelete()
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not self.player:IsAdmin() then return end
	this:Remove()
end

e2function void entity:admPropBreak()
	if not IsValid(this) or not self.player:IsAdmin() or this:IsPlayer() then return end
	this:Fire("break",1,0)
end

e2function void entity:admPropFreeze(number freeze)
	if not IsValid(this) then return end
	if not validPhysics(this) then return end
	if not self.player:IsAdmin() then return end
	PropCore.PhysManipulate(this, nil, nil, freeze, nil, nil)
end

e2function void entity:admPropNotSolid(number notsolid)
	if not IsValid(this) then return end
	if not validPhysics(this) then return end
	if not self.player:IsAdmin() then return end
	PropCore.PhysManipulate(this, nil, nil, nil, nil, notsolid)
end

e2function void entity:admPropGravity(number gravity)
	if not IsValid(this) then return end
	if not validPhysics(this) then return end
	if not self.player:IsAdmin() then return end
	PropCore.PhysManipulate(this, nil, nil, nil, gravity, nil)
end

e2function void entity:admSetAng(angle rot)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	PropCore.PhysManipulate(this, nil, rot, nil, nil, nil)
end

e2function number entity:admCreateWire(entity ent2, string inputname, string outputname)
	if not IsValid(this) or not IsValid(ent2) then return 0 end
	if not self.player:IsAdmin() then return 0 end

	if not this.Inputs or not ent2.Outputs then return 0 end
	if inputname == "" or outputname == "" then return 0 end
	if not this.Inputs[inputname] or not ent2.Outputs[outputname] then return 0 end
	if this.Inputs[inputname].Src then
		local CheckInput = this.Inputs[inputname]
		if CheckInput.SrcId == outputname and CheckInput.Src == ent2 then return 0 end -- Already wired
	end
	
	local trigger = self.entity.trigger
	self.entity.trigger = { false, {} } -- So the wire creation doesn't execute the E2 immediately because an input changed
	WireLib.Link_Start(self.player:UniqueID(), this, this:WorldToLocal(this:GetPos()), inputname, "cable/rope", Vector(255,255,255), 0)
	WireLib.Link_End(self.player:UniqueID(), ent2, ent2:WorldToLocal(ent2:GetPos()), outputname, self.player)
	self.entity.trigger = trigger
	
	return 1
end

e2function number entity:admDeleteWire(string inputname)
	if not IsValid(this) or not self.player:IsAdmin() or inputname == "" then return 0 end

	if not this.Inputs or not this.Inputs[inputname] or not this.Inputs[inputname].Src then return 0 end
	local trigger = self.entity.trigger
	self.entity.trigger = { false, {} } -- So the wire deletion doesn't execute the E2 immediately because an input zero'd
	WireLib.Link_Clear(this, inputname)
	self.entity.trigger = trigger
	return 1
end

e2function array entity:admGetWireInputs()
	if not IsValid(this) or not this.Inputs then return {} end
	local ret = {}
	for k,v in pairs(this.Inputs) do
		if k ~= "" then
			table.insert(ret, k)
		end
	end
	return ret
end

e2function array entity:admGetWireOutputs()
	if not IsValid(this) or not this.Outputs then return {} end
	local ret = {}
	for k,v in pairs(this.Outputs) do
		if k ~= "" then
			table.insert(ret, k)
		end
	end
	return ret
end

--- Returns the type of input that <Input> is in lowercase. ( "NORMAL" is changed to "number" )
e2function string entity:inputType(string Input)
	if not IsValid(this) or not this.Inputs or not this.Inputs[Input] then return "" end
	if not self.player:IsAdmin() or not this:GetCreator()==self.player then return end
	local Type = this.Inputs[Input].Type or ""
	if Type == "NORMAL" then Type = "number" end
	return string.lower(Type)
end
--- Returns the type of output that <Output> is in lowercase. ( "NORMAL" is changed to "number" )
e2function string entity:outputType(string Output)
	if not IsValid(this) or not this.Outputs or not this.Outputs[Output] then return "" end
	if not self.player:IsAdmin() or not this:GetCreator()==self.player then return end
	local Type = this.Outputs[Output].Type or ""
	if Type == "NORMAL" then Type = "number" end
	return string.lower(Type)
end

e2function wirelink entity:admWirelink()
	if not IsValid(this) or not self.player:IsAdmin() then return nil end
	if not this.extended then
		WireLib.CreateWirelinkOutput( self.player, this, {true} )
	end
	return this
end

e2function void entity:fastSound(string path)
	if IsValid(this) and (this:GetCreator()==self.player or self.player:IsAdmin()) then
		this:EmitSound( path )
	end
end

e2function void entity:fastSound(string path, number soundLevel)
	if IsValid(this) and (this:GetCreator()==self.player or self.player:IsAdmin()) then
		this:EmitSound( path, soundLevel )
	end
end

e2function void entity:fastSound(string path, number soundLevel, number pitchPercent)
	if IsValid(this) and (this:GetCreator()==self.player or self.player:IsAdmin()) then
		this:EmitSound( path, soundLevel, pitchPercent)
	end
end

e2function void entity:fastSound(string path, number soundLevel, number pitchPercent, number volume)
	if IsValid(this) and (this:GetCreator()==self.player or self.player:IsAdmin()) then
		this:EmitSound( path, soundLevel, pitchPercent, volume)
	end
end

e2function void entity:fastSound(string path, number soundLevel, number pitchPercent, number volume, number channel)
	if IsValid(this) and (this:GetCreator()==self.player or self.player:IsAdmin()) then
		this:EmitSound( path, soundLevel, pitchPercent, volume, channel )
	end
end

e2function vector entity:targetBodyPos(vector origin, number noisy)
	if IsValid(this) then
		return this:BodyTarget( Vector(origin[1], origin[2], origin[3]), tobool( noisy ) )
	end
end

e2function vector entity:targetHeadPos(vector origin)
	if IsValid(this) then
		return this:HeadTarget( Vector(origin[1], origin[2], origin[3]))
	end
end

e2function void entity:setClip1(number ammo)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsWeapon() then return end
	this:SetClip1( ammo )
end

e2function number entity:getMaxClip1()
	if IsValid(this) then
		return this:GetMaxClip1()
	end
end

e2function void entity:setClip2(number ammo)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsWeapon() then return end
	this:SetClip1( ammo )
end

e2function number entity:getMaxClip2()
	if IsValid(this) then
		return this:GetMaxClip2()
	end
end

e2function number entity:getCameraDistance()
	if not IsValid(this) then return 0 end
	if not this:IsVehicle() then return 0 end
	return this:GetCameraDistance()
end

e2function void entity:setCameraDistance(number dist)
	if not this:IsVehicle() then return end
	if not self.player:IsAdmin() and this:GetCreator()!=self.player then return end
	this:SetCameraDistance( dist )
end

e2function void entity:give(string weaponname)
	if not IsValid(this) or not self.player:IsAdmin() or not this:IsPlayer() then return end
	local ply = this
	local override = ply.pickupOverride
	if override then
		ply:Give( weaponname )
	else
		ply.pickupOverride = true
		ply:Give( weaponname )
		ply.pickupOverride = false
	end
end

e2function void entity:stripWeapon(string weaponname)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	this:StripWeapon( weaponname )
end

e2function void entity:stripWeapons()
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	this:StripWeapons()
end

e2function void entity:dropWeapon(string weapon)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	this:DropNamedWeapon( weapon )
end

e2function void entity:dropWeapon(entity weapon)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	this:DropWeapon( weapon )
end

e2function array entity:getWeapons()
	if not IsValid(this) then return end
	if not this:IsPlayer() then return end
	return this:GetWeapons()
end

e2function void entity:setAmmo(number ammocount, string ammotype)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	this:SetAmmo( ammocount, ammotype )
end

e2function void entity:selectWeapon(string weapon)
	if not IsValid(this) then return end
	if not this:IsPlayer() then return end
	if not self.player:IsAdmin() or not this==self.player then return end
	this:SelectWeapon( weapon )
end

e2function entity entity:getRagdollEntity() 
	if not IsValid(this) then return end
	if not this:IsPlayer() then return end
	return this:GetRagdollEntity() 
end

e2function void entity:plyDoAttack1(number attack)
	if not IsValid(this) then return end
	if not this:IsPlayer() then return end
	if not self.player:IsAdmin() then return end
	if attack>0 then this:ConCommand( "+attack" )
	else this:ConCommand( "-attack" )
	end
end
e2function void entity:plyDoAttack2(number attack2)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	if attack2>0 then this:ConCommand( "+attack2" )
	else this:ConCommand( "-attack2" )
	end
end
e2function void entity:plyDucking(number duck)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	if duck>0 then this:ConCommand( "+duck" )
	else this:ConCommand( "-duck" )
	end
end
e2function void entity:plyDoJump(number jump)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	if jump>0 then this:ConCommand( "+jump" )
	else this:ConCommand( "-jump" )
	end
end
e2function void entity:plyDoUse(number use)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	if use>0 then this:ConCommand( "+use" )
	else this:ConCommand( "-use" )
	end
end
e2function void entity:plyDoContext(number use)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	if use>0 then this:ConCommand( "+menu_context" )
	else this:ConCommand( "-menu_context" )
	end
end

e2function void entity:setVehicleEntryAnim(number enable)
	if not this:IsVehicle() then return end
	if not self.player:IsAdmin() and this:GetCreator()!=self.player then return end
	if enable>0 then this:SetVehicleEntryAnim( true ) 
	else this:SetVehicleEntryAnim( false ) 
	end
end

e2function void entity:setVehicleSteering(number steering)
	if IsValid(this) and (this:GetCreator()==self.player or self.player:IsAdmin()) then
		this:SetSteering(steering)
	end
end

e2function void entity:setVehicleSteeringDegrees(number steeringDeg)
	if IsValid(this) and (this:GetCreator()==self.player or self.player:IsAdmin()) then
		this:SetSteeringDegrees(steeringDeg)
	end
end

e2function void entity:setMaxVehicleThrottle(number maxThrottle)
	if IsValid(this) and (this:GetCreator()==self.player or self.player:IsAdmin()) then
		this:SetMaxThrottle(maxThrottle)
	end
end

e2function void entity:setMaxVehicleThrottleRev(number maxRevThrottle)
	if IsValid(this) and (this:GetCreator()==self.player or self.player:IsAdmin()) then
		this:SetMaxReverseThrottle(maxRevThrottle)
	end
end

e2function void entity:setVehicleThrottle(number throttle)
	if IsValid(this) and (this:GetCreator()==self.player or self.player:IsAdmin()) then
		this:SetThrottle(throttle)
	end
end

e2function void entity:setVehicleHandbrake(number handbrake)
	if IsValid(this) and (this:GetCreator()==self.player or self.player:IsAdmin()) then
		this:SetHandbrake(handbrake==1)
	end
end

e2function void entity:setVehicleEngine(number engine)
	if IsValid(this) and (this:GetCreator()==self.player or self.player:IsAdmin()) then
		this:EnableEngine(engine==1)
	end
end

e2function void entity:setVehicleBoost(number boost)
	if IsValid(this) and (this:GetCreator()==self.player or self.player:IsAdmin()) then
		this:SetBoost(boost)
	end
end

e2function number entity:boostTimeLeft()
	if IsValid(this) then
		return this:BoostTimeLeft()
	end
end

e2function number entity:getVehicleThirdPerson()
	if not this:IsVehicle() then return end
	if not self.player:IsAdmin() and this:GetCreator()!=self.player then return end
	if this:GetThirdPersonMode()==true then return 1
	else return 0
	end
end

e2function void entity:setVehicleThirdPerson(number enable)
	if not this:IsVehicle() then return end
	if not self.player:IsAdmin() and this:GetCreator()!=self.player then return end
	if enable>0 then this:SetThirdPersonMode( true ) 
	else this:SetThirdPersonMode( false ) 
	end
end

e2function void entity:allowWeaponsInVehicle(number allow )
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	if allow>0 then this:SetAllowWeaponsInVehicle( true ) 
	else this:SetAllowWeaponsInVehicle( false ) 
	end
end

e2function void entity:forcePlayerDrop()
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:ForcePlayerDrop()
end

e2function void entity:entActivate()
	if not IsValid(this) or not self.player:IsAdmin() then return end
	this:Activate()
end

e2function void entity:dropObject()
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	this:DropObject()
end

e2function void entity:kill()
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	this:Kill()
end

e2function void entity:killSilent()
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	this:KillSilent()
end

e2function void entity:freezePlayer(number freeze)
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	if freeze>0 then this:Freeze( true ) 
	else this:Freeze( false ) 
	end
end

e2function void entity:lock()
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	this:Lock()
end

e2function void entity:unlock()
	if not IsValid(this) or not self.player:IsAdmin() then return end
	if not this:IsPlayer() then return end
	this:UnLock()
end
