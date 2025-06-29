#include <conio.h>
#include <progman.h>

void
_start (void)
{
    write(STDOUT,"Hello, World!\n", 14);
    exit(SUCCESS);
}