math.clamp=function(value,min,max)
    return math.max(min,math.min(max,value))
end
math.Epsilon=0.000001
Vector3= class({
    ctor=function(self,x,y,z)
        self[1]=x or 0
        self[2]=y or 0
        self[3]=z or 0
    end,

    extend=Object,
    static={
        up={
            get=function(self)
                return Vector3:new(0,1,0)
            end,
        },
        Lerp=function(self,from,to,alpha)
            return Vector3:new((to.x-from.x)*alpha,(to.y-from.y)*alpha,(to.z-from.z)*alpha)
        end
    },
    property={
        toString=function()
            return "Vector3"
        end,
        normalized={
            get=function(self)
                local sum=self[1]+self[2]+self[3]
                return Vector3:new(self[1]/sum,self[2]/sum,self[3]/sum)
            end
        },
        x={
            get=function(self)
                return self[1]
            end,
            set=function(self,value)
                self[1]=value
            end
        },
        y={
            get=function(self)
                return self[2]
            end,
            set=function(self,value)
                self[2]=value
            end
        },
        z={
            get=function(self)
                return self[3]
            end,
            set=function(self,value)
                self[3]=value
            end
        },
        clone={
            get=function(self)
                return Vector3:new(self.x,self.y,self.z)
            end
        }
    },
    operator={
        __add=function(a,b)
            return Vector3:new(a[1]+b[1],a[2]+b[2],a[3]+b[3])
        end,
        __tostring=function(self)
            return '['..self.x..','..self.y..','..self.z..']'
        end,
        __mul=function(a,b)
            if type(b)=='number' then
                return Vector3:new(a.x*b,a.y*b,a.z*b)
            end
        end,
        __sub=function(a,b)
            return Vector3:new(a[1]-b[1],a[2]-b[2],a[3]-b[3])
        end
    }
})
Mat4x4=class({
    ctor=function(self,array)
        self.data=array
    end,
    static={
        Perspective=function(left, right, top, bottom, near, far )

            local x = 2 * near / ( right - left )
            local y = 2 * near / ( top - bottom )
    
            local a = ( right + left ) / ( right - left )
            local b = ( top + bottom ) / ( top - bottom )
            local c = - ( far + near ) / ( far - near )
            local d = - 2 * far * near / ( far - near )
            return Mat4x4:new({
                 x,	0, 0, 0,
                 0,	y, 0, 0,
                 a,	b, c, -1,
                 0,	0, d, 0,
        
            })
        end,
        identity={
            get=function(self)
                return Mat4x4:new({
                    1,0,0,0,
                    0,1,0,0,
                    0,0,1,0,
                    0,0,0,1
                })
            end
        },
        Compose=function(position, quaternion, scale)
            local x ,y,z,w= quaternion._x, quaternion._y,quaternion._z, quaternion._w
            local x2, y2,z2= x + x, y + y, z + z
            local xx ,xy,xz= x * x2, x * y2, x * z2
            local yy ,yz,zz= y * y2, y * z2, z * z2
            local wx ,wy,wz= w * x2, w * y2, w * z2
    
            local sx,sy,sz = scale[1],scale[2],scale[3]
            return Mat4x4:new({
                ( 1 - ( yy + zz ) ) * sx,
                ( xy + wz ) * sx,
                ( xz - wy ) * sx,
                0,
        
                ( xy - wz ) * sy,
                ( 1 - ( xx + zz ) ) * sy,
                ( yz + wx ) * sy,
                0,
        
                ( xz + wy ) * sz,
                ( yz - wx ) * sz,
                 ( 1 - ( xx + yy ) ) * sz,
                 0,
        
                 position[1],
                 position[2],
                 position[3],
                 1,
            })
        end
    },
    property={
        Translate=function(self,vec)
            return Mat4x4:new({
                1, 0, 0, x,
                0, 1, 0, y,
                0, 0, 1, z,
                0, 0, 0, 1
            })
        end,
        Rotate=function(self,angle, axis)
            local c=math.cos(angle)
            local s=math.sin(angle)
            local t=1-c
            local x=axis[1]
            local y=axis[2]
            local z=axis[3]
            local tx=t*x0
            local ty=t*y
            return Mat4x4:new({
                tx * x + c, tx * y - s * z, tx * z + s * y, 0,
                tx * y + s * z, ty * y + c, ty * z - s * x, 0,
                tx * z - s * y, ty * z + s * x, t * z * z + c, 0,
                0, 0, 0, 1
            })
        end,
        Scale=function(self,vec)
            local dest = self.data
            dest[1] = dest[1] * vec[1]
            dest[2] = dest[2] * vec[1]
            dest[3] = dest[3] * vec[1]
            dest[4] = dest[4] * vec[1]
            dest[5] = dest[5] * vec[2]
            dest[6] = dest[6] * vec[2]
            dest[7] = dest[7] * vec[2]
            dest[8] = dest[8] * vec[2]
            dest[9] = dest[9] * vec[3]
            dest[10] = dest[10] * vec[3]
            dest[11] = dest[11] * vec[3]
            dest[12] = dest[12] * vec[3]
            return self
        end,
        inverse={
            get=function(self)
                local me=self.data
                local n11,n21,n31,n41=me[1],me[2],me[3],me[4]
                local n12,n22,n32,n42=me[5],me[6],me[7],me[8]
                local n13,n23,n33,n43=me[9],me[10],me[11],me[12]
                local n14,n24,n34,n44=me[13],me[14],me[15],me[16]
                local t11 = n23 * n34 * n42 - n24 * n33 * n42 + n24 * n32 * n43 - n22 * n34 * n43 - n23 * n32 * n44 + n22 * n33 * n44
                local t12 = n14 * n33 * n42 - n13 * n34 * n42 - n14 * n32 * n43 + n12 * n34 * n43 + n13 * n32 * n44 - n12 * n33 * n44
                local t13 = n13 * n24 * n42 - n14 * n23 * n42 + n14 * n22 * n43 - n12 * n24 * n43 - n13 * n22 * n44 + n12 * n23 * n44
                local t14 = n14 * n23 * n32 - n13 * n24 * n32 - n14 * n22 * n33 + n12 * n24 * n33 + n13 * n22 * n34 - n12 * n23 * n34
                local det = n11 * t11 + n21 * t12 + n31 * t13 + n41 * t14
                if det==0 then
                    return Mat4x4.identity
                end
                local detInv=1/det
                return Mat4x4:new({
                    t11 * detInv,
                    ( n24 * n33 * n41 - n23 * n34 * n41 - n24 * n31 * n43 + n21 * n34 * n43 + n23 * n31 * n44 - n21 * n33 * n44 ) * detInv,
                    ( n22 * n34 * n41 - n24 * n32 * n41 + n24 * n31 * n42 - n21 * n34 * n42 - n22 * n31 * n44 + n21 * n32 * n44 ) * detInv,
                    ( n23 * n32 * n41 - n22 * n33 * n41 - n23 * n31 * n42 + n21 * n33 * n42 + n22 * n31 * n43 - n21 * n32 * n43 ) * detInv,
            
                    t12 * detInv,
                    ( n13 * n34 * n41 - n14 * n33 * n41 + n14 * n31 * n43 - n11 * n34 * n43 - n13 * n31 * n44 + n11 * n33 * n44 ) * detInv,
                    ( n14 * n32 * n41 - n12 * n34 * n41 - n14 * n31 * n42 + n11 * n34 * n42 + n12 * n31 * n44 - n11 * n32 * n44 ) * detInv,
                    ( n12 * n33 * n41 - n13 * n32 * n41 + n13 * n31 * n42 - n11 * n33 * n42 - n12 * n31 * n43 + n11 * n32 * n43 ) * detInv,
            
                    t13 * detInv,
                    ( n14 * n23 * n41 - n13 * n24 * n41 - n14 * n21 * n43 + n11 * n24 * n43 + n13 * n21 * n44 - n11 * n23 * n44 ) * detInv,
                     ( n12 * n24 * n41 - n14 * n22 * n41 + n14 * n21 * n42 - n11 * n24 * n42 - n12 * n21 * n44 + n11 * n22 * n44 ) * detInv,
                     ( n13 * n22 * n41 - n12 * n23 * n41 - n13 * n21 * n42 + n11 * n23 * n42 + n12 * n21 * n43 - n11 * n22 * n43 ) * detInv,
            
                     t14 * detInv,
                     ( n13 * n24 * n31 - n14 * n23 * n31 + n14 * n21 * n33 - n11 * n24 * n33 - n13 * n21 * n34 + n11 * n23 * n34 ) * detInv,
                     ( n14 * n22 * n31 - n12 * n24 * n31 - n14 * n21 * n32 + n11 * n24 * n32 + n12 * n21 * n34 - n11 * n22 * n34 ) * detInv,
                     ( n12 * n23 * n31 - n13 * n22 * n31 + n13 * n21 * n32 - n11 * n23 * n32 - n12 * n21 * n33 + n11 * n22 * n33 ) * detInv,
                })
            end
        }
    },
    operator={
        __mul=function(self,target)
            if target.type==Mat4x4 then
                local mat1=self.data
                local mat2=target.data
                local result= Mat4x4.identity
                local dest = result.data
                local a = mat1[1]
                local b = mat1[2]
                local c = mat1[3] 
                local d = mat1[4]
                local e = mat1[5] 
                local f = mat1[6]
                local  g = mat1[7]
                local  h = mat1[8]
                local i = mat1[9]
                local  j = mat1[10]
                local k = mat1[11] 
                local l = mat1[12]
                local m = mat1[13]
                local  n = mat1[14]
                local o = mat1[15]
                local p = mat1[16]
                local A = mat2[1]
                local B = mat2[2]
                local C = mat2[3]
                local D = mat2[4]
                local E = mat2[5]
                local F = mat2[6]
                local G = mat2[7]
                local H = mat2[8]
                local I = mat2[9]
                local J = mat2[10]
                local K = mat2[11] 
                local L = mat2[12]
                local M = mat2[13]
                local N = mat2[14]
                local O = mat2[15] 
                local P = mat2[16]
                dest[1] = A * a + B * e + C * i + D * m
                dest[2] = A * b + B * f + C * j + D * n
                dest[3] = A * c + B * g + C * k + D * o
                dest[4] = A * d + B * h + C * l + D * p
                dest[5] = E * a + F * e + G * i + H * m
                dest[6] = E * b + F * f + G * j + H * n
                dest[7] = E * c + F * g + G * k + H * o
                dest[8] = E * d + F * h + G * l + H * p
                dest[9] = I * a + J * e + K * i + L * m
                dest[10] = I * b + J * f + K * j + L * n
                dest[11] = I * c + J * g + K * k + L * o
                dest[12] = I * d + J * h + K * l + L * p
                dest[13] = M * a + N * e + O * i + P * m
                dest[14] = M * b + N * f + O * j + P * n
                dest[15] = M * c + N * g + O * k + P * o
                dest[16] = M * d + N * h + O * l + P * p
                return result
            elseif target.type==Vector3 then
                local mat=self.data
                local vec=target
                return Vector3:new(
                    mat[1] * vec[1] + mat[5] * vec[2] + mat[9] * vec[3] + mat[13] * 1,
    
                    mat[2] * vec[1] + mat[6] * vec[2] + mat[10] * vec[3] + mat[14] * 1,
    
                    mat[3] * vec[1] + mat[7] * vec[2] + mat[11] * vec[3] + mat[15] * 1
                )
            end
        end
    }
})

Quaternion=class({
    ctor=function(self,x,y,z,w)
        self._x=x or 0
        self._y=y or 0
        self._z=z or 0
        self._w=w or 1
    end,
    property={
        setFromAxisAngle=function(self,axis,angle)
            local halfAngle=angle/2
            local s=math.sin(halfAngle)
            self._x = axis.x * s;
            self._y = axis.y * s;
            self._z = axis.z * s;
            self._w = math.cos( halfAngle );
            return self
        end,
        eulerAngle={
            get=function(self)
                z = math.atan2(2 * (self._w * self._z + self._x * self._y) , 1 - 2 * (self._z * self._z + self._x * self._x))
                x = math.asin(math.clamp(2 * (self._w * self._x - self._y * self._z) , -1.0 , 1.0))
                y = math.atan2(2 * (self._w * self._y + self._z * self._x) , 1 - 2 * (self._x * self._x + self._y * self._y))
                return Vector3:new(x,y,z)
            end,
            set=function(self,value)
                self=Quaternion:Euler(value)
            end
        },
        normalized={
            get=function(self)
                local mag=math.sqrt(Quaternion:Dot(self,self))
                if mag<math.Epsilon then
                    return Quaternion.identity
                end
                return Quaternion:new(self._x / mag, self._y / mag, self._z / mag, self._w / mag)
            end
        }
    },
    operator={
        __mul=function(a,b)
            if b.type==Quaternion then
                local qax = a._x local qay = a._y local qaz = a._z local qaw = a._w
                local qbx = b._x local qby = b._y local qbz = b._z local qbw = b._w
                local q=Quaternion:new()  
                q._x = qax * qbw + qaw * qbx + qay * qbz - qaz * qby
                q._y = qay * qbw + qaw * qby + qaz * qbx - qax * qbz
                q._z = qaz * qbw + qaw * qbz + qax * qby - qay * qbx
                q._w = qaw * qbw - qax * qbx - qay * qby - qaz * qbz
                return q
            elseif b.type==Vector3 then
                local x = a._x * 2
                local y = a._y * 2
                local z = a._z * 2
                local xx = a._x * x
                local yy = a._y * y
                local zz = a._z * z
                local xy = a._x * y
                local xz = a._x * z
                local yz = a._y * z
                local wx = a._w * x
                local wy = a._w * y
                local wz = a._w * z
    
                local res=Vector3:new()
                res.x = (1 - (yy + zz)) * b.x + (xy - wz) * b.y + (xz + wy) * b.z
                res.y = (xy + wz) * b.x + (1 - (xx + zz)) * b.y + (yz - wx) * b.z
                res.z = (xz - wy) * b.x + (yz + wx) * b.y + (1 - (xx + yy)) * b.z
                return res;
            end
        end
    },
    static={
        Euler=function(self,euler)
            local q=Quaternion:new()
            local x,y,z=euler[1],euler[2],euler[3]
            local c1 = math.cos( x / 2 );
            local c2 = math.cos( y / 2 );
            local c3 = math.cos( z / 2 );
    
            local s1 = math.sin( x / 2 );
            local s2 = math.sin( y / 2 );
            local s3 = math.sin( z / 2 );
			q._x = s1 * c2 * c3 - c1 * s2 * s3
			q._y = c1 * s2 * c3 + s1 * c2 * s3
			q._z = c1 * c2 * s3 - s1 * s2 * c3
            q._w = c1 * c2 * c3 + s1 * s2 * s3
            return q
        end,
        Inverse=function(self,value)
            local rotation= Quaternion:new()
            rotation._x=-1*value._x
            rotation._y=-1*value._y
            rotation._z=-1*value._z
            rotation._w=value._w
            return rotation
        end,
        Dot=function(self,a,b)
            return a._x * b._x + a._y * b._y + a._z * b._z + a._w * b._w
        end,
        identity={
            get=function()
                return Quaternion:new(0,0,0,1)
            end
        }
    }
})