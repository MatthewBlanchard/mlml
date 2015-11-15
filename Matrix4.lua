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

-- Static Methods
function Matrix4.fromTable(t)
	return Object.__cast(t, Matrix4)
end