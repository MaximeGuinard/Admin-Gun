//General Variables\\
SWEP.DrawCrosshair = true
SWEP.Weight = 5
SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.HoldType = "Pistol"
SWEP.ViewModelFOV = 64
SWEP.Slot = 0
SWEP.Purpose = ""
SWEP.AutoSwitchTo = false
SWEP.Contact = ""
SWEP.Author = "Kayxy"
SWEP.FiresUnderwater = false
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ReloadSound = "Weapon_Pistol.Reload"
SWEP.SlotPos = 0
SWEP.Instructions = ""
SWEP.AutoSwitchFrom = false
SWEP.base = "weapon_base"
SWEP.Category = "SWEP KY"
SWEP.DrawAmmo = true
SWEP.PrintName = "GUN Swep"

SWEP.Primary.NumberofShots = 1
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Spread = 0.1
SWEP.Primary.ClipSize = 16
SWEP.Primary.Force = 10
SWEP.Primary.Damage = 10
SWEP.Primary.Delay = 0.2
SWEP.Primary.Recoil = 1
SWEP.Primary.DefaultClip = 32
SWEP.Primary.Automatic = false
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Sound = "Weapon_Pistol.Single"
//Primary Fire Variables\\

//Secondary Fire Variables\\
SWEP.Secondary.ClipSize = 16
SWEP.Secondary.Automatic = false
SWEP.Secondary.NumberofShots = 1
SWEP.Secondary.Damage = 10
SWEP.Secondary.Ammo = "Pistol"
SWEP.Secondary.Spread = 0.1
SWEP.Secondary.DefaultClip = 32
SWEP.Secondary.Force = 10
SWEP.Secondary.Recoil = 1
SWEP.Secondary.Sound = "Weapon_Pistol.Single"
SWEP.Secondary.TakeAmmo = 1
SWEP.Secondary.Delay = 0.2
//Secondary Fire Variables\\

function SWEP:Initialize()
	util.PrecacheSound(self.Primary.Sound) -- Son principale
	util.PrecacheSound(self.Secondary.Sound) -- son segondaire
	if ( SERVER ) then
		self:SetWeaponHoldType( self.HoldType )
	end
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	local bullet = {}
		bullet.Num = self.Primary.NumberofShots
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 0
		bullet.Force = self.Primary.Force
		bullet.Damage = self.Primary.Damage
		bullet.AmmoType = self.Primary.Ammo
	local rnda = self.Primary.Recoil * -1
	local rndb = self.Primary.Recoil * math.random(-1, 1)
	self:ShootEffects()
	self.Owner:FireBullets( bullet )
	self.Weapon:EmitSound(Sound(self.Primary.Sound))
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) )
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
end
//SWEP:PrimaryFire()\\

//SWEP:SecondaryFire()\\
function SWEP:SecondaryFire() 
	return false
end
//SWEP:SecondaryFire()\\

