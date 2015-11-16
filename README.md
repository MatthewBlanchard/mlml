#MLML

A Lua math library. A special thanks to the devs of CPML and holo, I used their code as a reference for the Matrix object.

##Features

* Matrix4x4
* Quaternions
* Vector3
* Planned Octree and Vector2 support.

```lua
m1 = Matrix4.fromAxisAngle(Vector3.Up, 90)

m2 = Matrix4.fromTable{
	1, 0, 0, 0,
	0, 1, 0, 0,
	0, 0, 1, 0,
	0, 0, 0, 1
}

m3 = Matrix4() -- identity matrix

q1 = Quaternion.fromAxisAngle(Vector3.Up, 90)
q2 = Quaternion(0, 0, 0, 1)

v1 = Vector3(0, 0, 0)
v2 = q2 * Vector3(1, 0, 1) -- rotate {1, 0, 1} around the up axis 90 degrees. 
```


##License

MIT:

```
Copyright (c) 2012 Matthew R. Blanchard

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.```