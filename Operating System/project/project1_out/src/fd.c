#include <unistd.h>

#include <fd.h>

/*Huang Daoji 27/02
 * read from fd byte by byte, and copy one byte to buf once at a time
 * returns the cnt of chars read(not include the final '\n')
 * when 1) a '\n' is read
 *      2) reach the 'len' parameter
 * return 0, when error occurs or 0 chars. read
 * oh...that is been described in .h files...
 */
int fd_readln(int fd, char *buf, size_t len)
{
    char c;
    char *cur;
    int i;

    i = 0;
    cur = buf;
    while (read(fd, &c, 1) == 1 && i < len)
    {
        if (c == '\n')
        {
            *cur = '\0';
            return cur - buf;
        }
        else
        {
            *cur = c;
            ++cur;
        }
        ++i;
    }
    return 0;
}
