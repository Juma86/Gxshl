#include <conio.h>
#include <progman.h>

int
main (void)
{

    char buffer[1024];
    int count;

    write(STDOUT,"enter text: ", 12);
    count = read(STDIN, buffer, 1023);
    write(STDOUT, "You entered: ", 13);
    write(STDOUT, buffer, count); 

    return SUCCESS;
}
