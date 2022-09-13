#include <iostream>
#include "lua.hpp"
int main(){
    std::cout<<123<<std::endl;
    lua_State *L =luaL_newstate();
    return 0;
}