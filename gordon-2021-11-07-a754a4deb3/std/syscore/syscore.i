/*
 * Copyright (c) 2021 Tero Hänninen.
 * SPDX-License-Identifier: BSD-2-Clause
 *
 * Bindings to parts of libc and system api depending on how things
 * work on each platform.
 *
 * On most unix like systems things are mostly done through libc. On MacOS,
 * libSystem is used instead. On Windows, it seems best to call kernel32.dll
 * because libc is utterly unstable in recent Windows versions.
 *
 * The most practical reference I could find:
 *   https://github.com/rust-lang/libc/blob/master/src
 */

#setup[unix] {
    private module unix;
    public import self.syscore.unix <- void;
} #else #setup[windows] {
    private module windows;
    public import self.syscore.windows <- void;
}
