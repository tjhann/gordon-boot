/*
 * Copyright (c) 2020-2021 Tero Hänninen.
 * SPDX-License-Identifier: BSD-2-Clause
 */

#setup[linux] {
    module linux;
    embed self.syscore.unix.linux;
}

alias c_schar = byte;
alias c_uchar = ubyte;
alias c_short = short;
alias c_ushort = ushort;
alias c_int = int;
alias c_uint = uint;
alias c_float = float;
alias c_double = double;
alias c_longlong = i64;
alias c_ulonglong = u64;
alias intmax_t = i64;
alias uintmax_t = u64;

//alias uid_t = uint;
//alias gid_t = uint;
//alias pid_t = int;

enum FILE;

extern(C) {
    /*
    #extern #gshared FILE* stdout;
    #extern #gshared FILE* stderr;

    int     stat(const ubyte* pathname, stat_t *statbuf);
    int     mkdir(const ubyte* pathname, mode_t mode);
    pid_t   wait(int* wstatus); // sys/wait.h
    pid_t   fork(); // unistd.h
    int     execv(const ubyte* pathname, const(ubyte**) argv); // unistd.h
    */
    isz     write(int fd, const void* buf, usz count); // unistd.h

    void*   memcpy(void* dest, const void* src, usz n);
    void*   memmove(void* dest, const void* src, usz n);
    void*   memset(void* s, int c, usz n);

    void*   malloc(usz size);
    void*   calloc(usz nmemb, usz size);
    void*   realloc(void* ptr, usz size);
    void    free(const void* ptr);

    void    exit(int status);
    /*
    ubyte*  getenv(const ubyte* name);

    double  strtod(const ubyte* nptr, ubyte** endptr);

    int     printf(const ubyte* format, ...);
    int     fprintf(FILE* stream, const ubyte* format, ...);
    int     snprintf(ubyte* s, usz n, const ubyte* format, ...);
    int     fputc(int c, FILE* stream);
    */

    FILE*   fopen(const ubyte* filename, const ubyte* mode);
    usz     fwrite(const void* ptr, usz size, usz nmemb, FILE* stream);
    //usz     fread(void* ptr, usz size, usz nmemb, FILE* stream);
    //int     fseek(FILE* stream, c_long offset, int whence);
    //c_long  ftell(FILE* stream);
    int     fclose(FILE* stream);
}
