require "Object"
require "Vector3"

Quaternion = Object()

-- Defaults
Quaternion.x = 0
Quaternion.y = 0
Quaternion.z = 0
Quaternion.w = 0

-- Constructor
function Quaternion:__new(x, y, z, w)
	self.x = x
	self.y = y
	self.z = z
	self.w = w
end

-- Metamethods
function Quaternion.__eq(a, b)
	return a.x ~= b.x or a.y ~= b.y or a.z ~= b.z or a.w ~= b.w
end

function Quaternion.__mul(a, b)
	if b.w then
		return Quaternion(	a.w * b.x + a.x * b.w + a.y * b.z - a.z * b.y,
	    	            	a.w * b.y + a.y * b.w + a.z * b.x - a.x * b.z,
	        	         	a.w * b.z + a.z * b.w + a.x * b.y - a.y * b.x,
	            	     	a.w * b.w - a.x * b.x - a.y * b.y - a.z * b.z)
	else -- assume vector
		return Quaternion.rotateVector3(a, b)
	end
end

function Quaternion:__tostring()
	return self.x .. "\t" .. self.y .. "\t" .. self.z .. "\t" .. self.w
end

-- Static methods
function Quaternion.fromAxisAngle(axis, angle)
	local rad, sin, cos = math.rad, math.sin, math.cos
	local angle = rad(angle)
    local s = sin(angle/2)

    return Quaternion(s * axis.x, s * axis.y, s * axis.z, cos(angle/2))
end

function Quaternion.fromVector(v, w)
	return Quaternion(v.x, v.y, v.z, w)
end

-- Methods
function Quaternion.normal(a)
	local mag = sqrt(a.w * a.w + a.x * a.x + a.y * a.y + a.z * a.z)
	return Quaternion(a.x / mag, a.y / mag, a.z / mag, a.w / mag)
end

function Quaternion.rotateVector3(a, b)
	local b = Quaternion.fromVector(b)
	local result = Quaternion.__mul(Quaternion.__mul(a, b), Quaternion.conjugate(a))
	return Vector3(result.x, result.y, result.z)
end

function Quaternion.conjugate(a)
	return Quaternion:new(-a.x, -a.y, -a.z, a.w)
end
