/*
 * Copyright (c) 2020-2021 Tero Hänninen.
 * SPDX-License-Identifier: BSD-2-Clause
 */

public:

module typeinfo;


internal:

// This whole module could be excluded from compilation when all checks are disabled,
// but that means distributing two compiled versions of the library. And it's not
// *much* garbage for unchecked builds but garbage nonetheless...
module failure;
