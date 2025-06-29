#include <conio.h>
#include <progman.h>

int
main (void)
{
    char buffer [4096];
    int16 count;

    do
    {
        write(stdout, "gxshl# ", 7);
        count = read(stdin, buffer, sizeof buffer);
        buffer[count-1] = '\0';
        write(stdout, "You entered the following command: ", 36);
        write(stdout, buffer, count);
        write(stdout, "\n", 1);
    } while(true);

    return SUCCESS;
}
