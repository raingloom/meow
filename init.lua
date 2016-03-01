local M = {
  _AUTHOR = "rain_gloom",
  _LICENSE = [[This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org>
]],
}
local reg = {}
reg.__mode = 'kv'
setmetatable( reg, reg )

local mt = {}


local function new( t )
  if type( t ) == 'table' then
    local r = setmetatable( {}, mt )
    reg[r] = { src = t }
    return r
  else
    return t
  end
end


function mt:__index( k )
  local rd = reg[self]
  if rd.nils[ k ] then
    return nil
  else
    return rd.inherit and new( rd.src[ k ] ) or rd.src[ k ]
  end
end


function mt:__newindex( k, v )
  if v == nil then
    reg[ self ].nils[ k ] = true
  else
    rawset( self, k, v )
  end
end


function mt:__pairs()
  local f, s, v = pairs( reg[ self ].src )
  error"TODO"
end



M.__call = new
return setmetatable( M, M )