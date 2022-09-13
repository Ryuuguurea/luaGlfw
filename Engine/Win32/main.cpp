#include "ScriptRuntime.h"

int main(int argc, char *argv[])
{
    if(argc>1){
        ScriptRuntime Runtime(argv[1]);
    }
    return 0;
}
