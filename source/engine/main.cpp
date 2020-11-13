#include "luabinding/ScriptUtil.h"

int main(int argc, char *argv[])
{
    assert(argc>1);
    ScriptUtil* su=new ScriptUtil(argc,argv);
    su->Run(argv[1]);
    return 0;
}
