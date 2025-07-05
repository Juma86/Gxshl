#include <unistd.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <string.h>
#include <syscall.h>


int
main (void)
{
    char buffer [4096];
    short count;
    pid_t pid;

    do
    {
        write(1, "gxshl# ", 7);
        count = read(0, buffer, sizeof buffer);
        buffer[count-1] = '\0';

        pid = fork();
        char errmsg[] = "fork(): Failed!";
        if (0 > pid) return 1;
        if (0 == pid)
        {
            execve(buffer, 0, 0);
            _exit(1);
        } else
        {
            waitid(P_ALL, pid, 0, 0);
        }
    } while(! gx_streq("exit", buffer));

    return 0;
}
