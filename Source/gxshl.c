#include <conio.h>
#include <progman.h>

void
_start (void)
{

    static char buffer[1024];
    static int count;

    write(STDOUT,"enter text: ", 12);
    count = read(STDIN, buffer, 1023);
    write(STDOUT, "You entered: ", 13);
    write(STDOUT, buffer, count); 

    exit(SUCCESS);
}
