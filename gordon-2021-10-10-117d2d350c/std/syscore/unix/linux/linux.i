/*
 * Copyright (c) 2020-2021 Tero Hänninen.
 * SPDX-License-Identifier: BSD-2-Clause
 */

#setup[gnu && x86_64] {
    module gnu_x86_64;
    public import self.syscore.unix.linux.gnu_x86_64 <- void;
    //embed self.syscore.unix.linux.gnu_x86_64;
}

import self.syscore.unix;

/*
enum {
    SEEK_SET,   // relative to beginning
    SEEK_CUR,   // relative to current position
    SEEK_END,   // relative to end
}

alias dev_t = u64;
alias mode_t = uint;
*/

/*
define mode_t S_IFIFO = 4096;
define mode_t S_IFCHR = 8192;
define mode_t S_IFBLK = 24576;
define mode_t S_IFDIR = 16384;
define mode_t S_IFREG = 32768;
define mode_t S_IFLNK = 40960;
define mode_t S_IFSOCK = 49152;
define mode_t S_IFMT = 61440;
define mode_t S_IRWXU = 448;
define mode_t S_IXUSR = 64;
define mode_t S_IWUSR = 128;
define mode_t S_IRUSR = 256;
define mode_t S_IRWXG = 56;
define mode_t S_IXGRP = 8;
define mode_t S_IWGRP = 16;
define mode_t S_IRGRP = 32;
define mode_t S_IRWXO = 7;
define mode_t S_IXOTH = 1;
define mode_t S_IWOTH = 2;
define mode_t S_IROTH = 4;
define c_int F_OK = 0;
define c_int R_OK = 4;
define c_int W_OK = 2;
define c_int X_OK = 1;
*/
define c_int STDIN_FILENO = 0;
define c_int STDOUT_FILENO = 1;
define c_int STDERR_FILENO = 2;
/*
define c_int SIGHUP = 1;
define c_int SIGINT = 2;
define c_int SIGQUIT = 3;
define c_int SIGILL = 4;
define c_int SIGABRT = 6;
define c_int SIGFPE = 8;
define c_int SIGKILL = 9;
define c_int SIGSEGV = 11;
define c_int SIGPIPE = 13;
define c_int SIGALRM = 14;
define c_int SIGTERM = 15;
*/

/*
// errno.h ----------------------------------------------------------------

define c_int EPERM = 1;
define c_int ENOENT = 2;
define c_int ESRCH = 3;
define c_int EINTR = 4;
define c_int EIO = 5;
define c_int ENXIO = 6;
define c_int E2BIG = 7;
define c_int ENOEXEC = 8;
define c_int EBADF = 9;
define c_int ECHILD = 10;
define c_int EAGAIN = 11;
define c_int ENOMEM = 12;
define c_int EACCES = 13;
define c_int EFAULT = 14;
define c_int ENOTBLK = 15;
define c_int EBUSY = 16;
define c_int EEXIST = 17;
define c_int EXDEV = 18;
define c_int ENODEV = 19;
define c_int ENOTDIR = 20;
define c_int EISDIR = 21;
define c_int EINVAL = 22;
define c_int ENFILE = 23;
define c_int EMFILE = 24;
define c_int ENOTTY = 25;
define c_int ETXTBSY = 26;
define c_int EFBIG = 27;
define c_int ENOSPC = 28;
define c_int ESPIPE = 29;
define c_int EROFS = 30;
define c_int EMLINK = 31;
define c_int EPIPE = 32;
define c_int EDOM = 33;
define c_int ERANGE = 34;
define c_int EWOULDBLOCK = EAGAIN;

extern(C) int*    __errno_location();
*/
