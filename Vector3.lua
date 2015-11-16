require "Object"

Vector3 = Object()

-- Defaults
Vector3.x = 0
Vector3.y = 0
Vector3.z = 0

-- Constructor
function Vector3:__new(x, y, z)
	self.x = x
	self.y = y
	self.z = z
end

-- Static Variables
Vector3.Zero = Vector3(0, 0, 0)
Vector3.Right = Vector3(1, 0, 0)
Vector3.Up = Vector3(0, 1, 0)
Vector3.Forward = Vector3(0, 0, 1)


-- Metamethods
function Vector3.__unm(a)
	return Vector3.new(-a.x, -a.y, -a.z)
end

function Vector3.__add(a, b)
	return Vector3:new(a.x + b.x, a.y + b.y, a.z + b.z)
end

function Vector3.__sub(a, b)
	return Vector3:new(a.x - b.x, a.y - b.y, a.z - b.z)
end

function Vector3.__mul(a, b)
	return Vector3:new(a.x * b, a.y * b, a.z * b)
end

function Vector3.__div(a, b)
	return Vector3:new(a.x / b, a.y / b, a.z / b)
end

function Vector3.__eq(a, b)
	return a.x == b.x and a.y == b.y and a.z == b.z
end

function Vector3:__tostring()
	return self.x .. "\t" .. self.y .. "\t" .. self.z
end

-- Methods
function Vector3.magnitude(a)
	return math.sqrt(a.x * a.x + a.y * a.y + a.z * a.z)
end

function Vector3.normal(a)
	local mag = Vector3.magnitude(a)
	return Vector3(a.x / mag, a.y / mag, a.z / mag)
end


function Vector3.cross(a, b)
	return Vector3:new( a.y * b.z - b.y * a.z,
						a.z * b.x - b.z * a.x,
						a.x * b.y - b.x * a.y
					)
end

function Vector3.dot(a, b)
	return a.x * b.x + a.y * b.y + a.z * b.z
end

function Vector3.lerp(a, b, p)
	return Vector3.__add(a, Vector3.__mul(Vector3.__sub(b, a), p))
end