require "Object"

Matrix4 = Object()

-- Defaults

Matrix4[1] = 1
Matrix4[2] = 0
Matrix4[3] = 0
Matrix4[4] = 0

Matrix4[5] = 0
Matrix4[6] = 1
Matrix4[7] = 0
Matrix4[8] = 0

Matrix4[9] = 0
Matrix4[10] = 0
Matrix4[11] = 1
Matrix4[12] = 0

Matrix4[13] = 0
Matrix4[14] = 0
Matrix4[15] = 0
Matrix4[16] = 1

-- Metamethods
function Matrix4:__unm()
	return self:inverse()
end

function Matrix4.__mul(a, b)
	return Matrix4.multiplyMatrix4(a, b)
end

function Matrix4.__eq(a, b)
	local DBL_EPSILON = 2.2204460492503131e-16
	for i = 1, 16 do 
		if math.abs(a[i] - b[i]) > DBL_EPSILON then
			return false
		end
	end

	return true
end

-- Static Methods
function Matrix4.fromTable(t)
	return Object.__cast(t, Matrix4) -- don't create a new object, just turn this one into a matrix
end

function Matrix4.fromPerspective(fovy, aspect, near, far)
	local t = math.tan(math.rad(fovy) / 2)
	local m = Matrix4()

	m[1]  = 1 / (t * aspect)
	m[6]  = 1 / t
	m[11] = -(far + near) / (far - near)
	m[12] = -1
	m[15] = -(2 * far * near) / (far - near)
	m[16] = 1
	
	return m
end

function Matrix4.fromAxisAngle(axis, angle)
	local x, y, z = axis.x, axis.y, axis.z
	local angle = math.rad(angle)
	local c = math.cos(angle)
	local s = math.sin(angle)
	local oc = 1-c

	return Matrix4.fromTable{
		x*x*oc+c, y*x*oc-z*s, x*z*oc+y*s, 0,
		x*y*oc+z*s, y*y*oc+c, y*z*oc-x*s, 0,
		x*z*oc-y*s, y*z*oc+x*s, z*z*oc+c, 0,
		0, 0, 0, 1
	}
end

function Matrix4.fromTranslation(v)
	return Matrix4.fromTable{
		1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		v.x, v.y, v.z, 1
	}
end

function Matrix4.fromScalar(v)
	return Matrix4.fromTable{
		v.x, 0, 0, 0,
		0, v.y, 0, 0,
		0, 0, v.z, 0,
		0, 0, 0, 1
	}
end

-- Method
function Matrix4.inverse(a)
	local m = Matrix4()

	m[1] =  a[6]  * a[11] * a[16] - a[6]  * a[12] * a[15] -
		a[10] * a[7]  * a[16] + a[10] * a[8]  * a[15] +
		a[14] * a[7]  * a[12] - a[14] * a[8]  * a[11]

	m[5] = -a[5]  * a[11] * a[16] + a[5]  * a[12] * a[15] +
		a[9]  * a[7]  * a[16] - a[9]  * a[8]  * a[15] -
		a[13] * a[7]  * a[12] + a[13] * a[8]  * a[11]

	m[9] =  a[5]  * a[10] * a[16] -	a[5]  * a[12] * a[14] -
		a[9]  * a[6]  * a[16] + a[9]  * a[8]  * a[14] +
		a[13] * a[6]  * a[12] - a[13] * a[8]  * a[10]

	m[13] = -a[5]  * a[10] * a[15] + a[5]  * a[11] * a[14] +
		a[9]  * a[6]  * a[15] - a[9]  * a[7]  * a[14] -
		a[13] * a[6]  * a[11] + a[13] * a[7]  * a[10]

	m[2] = -a[2]  * a[11] * a[16] + a[2]  * a[12] * a[15] +
		a[10] * a[3]  * a[16] - a[10] * a[4]  * a[15] -
		a[14] * a[3]  * a[12] + a[14] * a[4]  * a[11]

	m[6] =  a[1]  * a[11] * a[16] - a[1]  * a[12] * a[15] -
		a[9]  * a[3] * a[16] + a[9]  * a[4] * a[15] +
		a[13] * a[3] * a[12] - a[13] * a[4] * a[11]

	m[10] = -a[1]  * a[10] * a[16] + a[1]  * a[12] * a[14] +
		a[9]  * a[2]  * a[16] - a[9]  * a[4]  * a[14] -
		a[13] * a[2]  * a[12] + a[13] * a[4]  * a[10]

	m[14] = a[1]  * a[10] * a[15] - a[1]  * a[11] * a[14] -
		a[9]  * a[2] * a[15] + a[9]  * a[3] * a[14] +
		a[13] * a[2] * a[11] - a[13] * a[3] * a[10]

	m[3] = a[2]  * a[7] * a[16] - a[2]  * a[8] * a[15] -
		a[6]  * a[3] * a[16] + a[6]  * a[4] * a[15] +
		a[14] * a[3] * a[8] - a[14] * a[4] * a[7]

	m[7] = -a[1]  * a[7] * a[16] + a[1]  * a[8] * a[15] +
		a[5]  * a[3] * a[16] - a[5]  * a[4] * a[15] -
		a[13] * a[3] * a[8] + a[13] * a[4] * a[7]

	m[11] = a[1]  * a[6] * a[16] - a[1]  * a[8] * a[14] -
		a[5]  * a[2] * a[16] + a[5]  * a[4] * a[14] +
		a[13] * a[2] * a[8] - a[13] * a[4] * a[6]

	m[15] = -a[1]  * a[6] * a[15] + a[1]  * a[7] * a[14] +
		a[5]  * a[2] * a[15] - a[5]  * a[3] * a[14] -
		a[13] * a[2] * a[7] + a[13] * a[3] * a[6]

	m[4] = -a[2]  * a[7] * a[12] + a[2]  * a[8] * a[11] +
		a[6]  * a[3] * a[12] - a[6]  * a[4] * a[11] -
		a[10] * a[3] * a[8] + a[10] * a[4] * a[7]

	m[8] = a[1] * a[7] * a[12] - a[1] * a[8] * a[11] -
		a[5] * a[3] * a[12] + a[5] * a[4] * a[11] +
		a[9] * a[3] * a[8] - a[9] * a[4] * a[7]

	m[12] = -a[1] * a[6] * a[12] + a[1] * a[8] * a[10] +
		a[5] * a[2] * a[12] - a[5] * a[4] * a[10] -
		a[9] * a[2] * a[8] + a[9] * a[4] * a[6]

	m[16] = a[1] * a[6] * a[11] - a[1] * a[7] * a[10] -
		a[5] * a[2] * a[11] + a[5] * a[3] * a[10] +
		a[9] * a[2] * a[7] - a[9] * a[3] * a[6]

	local det = a[1] * m[1] + a[2] * m[5] + a[3] * m[9] + a[4] * m[13]

	if det == 0 then return a end

	det = 1.0 / det

	for i = 1, 16 do
		m[i] = m[i] * det
	end

	return m
end

function Matrix4.multiplyVector3(a, b)
	return Vector3(
		a[1]*b.x+a[2]*b.y+a[3]*b.z+a[4],
		a[5]*b.x+a[6]*b.y+a[7]*b.z+a[8],
		a[9]*b.x+a[10]*b.y+a[11]*b.z+a[12]
	)
end

function Matrix4.multiplyMatrix4(a, b)
	return Matrix4.fromTable{
		a[1]*b[1]+a[2]*b[5]+a[3]*b[9]+a[4]*b[13],
		a[1]*b[2]+a[2]*b[6]+a[3]*b[10]+a[4]*b[14],
		a[1]*b[3]+a[2]*b[7]+a[3]*b[11]+a[4]*b[15],
		a[1]*b[4]+a[2]*b[8]+a[3]*b[12]+a[4]*b[16],

		a[5]*b[1]+a[6]*b[5]+a[7]*b[9]+a[8]*b[13],
		a[5]*b[2]+a[6]*b[6]+a[7]*b[10]+a[8]*b[14],
		a[5]*b[3]+a[6]*b[7]+a[7]*b[11]+a[8]*b[15],
		a[5]*b[4]+a[6]*b[8]+a[7]*b[12]+a[8]*b[16],

		a[9]*b[1]+a[10]*b[5]+a[11]*b[9]+a[12]*b[13],
		a[9]*b[2]+a[10]*b[6]+a[11]*b[10]+a[12]*b[14],
		a[9]*b[3]+a[10]*b[7]+a[11]*b[11]+a[12]*b[15],
		a[9]*b[4]+a[10]*b[8]+a[11]*b[12]+a[12]*b[16],

		a[13]*b[1]+a[14]*b[5]+a[15]*b[9]+a[16]*b[13],
		a[13]*b[2]+a[14]*b[6]+a[15]*b[10]+a[16]*b[14],
		a[13]*b[3]+a[14]*b[7]+a[15]*b[11]+a[16]*b[15],
		a[13]*b[4]+a[14]*b[8]+a[15]*b[12]+a[16]*b[16]
	}
end

function Matrix4.transpose(a)
	return Matrix4.fromTable{
		a[1], a[5], a[9], a[13],
		a[2], a[6], a[10], a[14],
		a[3], a[7], a[11], a[15],
		a[4], a[8], a[12], a[16]
	}
end

function Matrix4:translate(v)
	return self * Matrix4.fromTranslation(v)
end

function Matrix4:scale(v)
	return self * Matrix4.fromScalar(v)
end