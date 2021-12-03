/*
 * Copyright (c) 2021 Tero Hänninen.
 * SPDX-License-Identifier: MIT
 *
 * Functions to convert strings to floating point numbers.
 *
 * This is based on Rust's core::num::dec2flt. The 'core' package
 * is dual-licensed under MIT and Apache 2.0 terms. Available at:
 * https://github.com/rust-lang/rust/tree/master/library/core
 */

module common;
module decimal;
module lemire;
module number;
module parse;
module pow5tab;

#setup[stdtest] {
    module test;
    module tests_lemire;
}

import self.s2fp.common;
import self.s2fp.lemire;
import self.s2fp.number;
import self.s2fp.parse;

define PF_UNDERSCORE = 0x1; // Allow underscores in numbers.
define PF_EXTREMES   = 0x2; // Allow rounding to infinity and truncating to zero.

/*
 * Converts a decimal string into a floating point number.
 *
 * Returns the parsed value on success and the length of the value
 * string through len (zero on failure).
 *
 * The form of the value string is an optional minus followed by
 * either a decimal string or NAN or INF.
 *
 * The decimal string must contain at least one base 10 digit and
 * may contain one dot ('.'), followed by an optional exponent
 * consisting of upper or lower case letter 'e' and then optional
 * plus or minus sign and a non-empty string of base 10 digits.
 * Leading zeros are skipped in both parts but counted into length.
 *
 * NAN and INF are the letter sequences "nan" and "inf" where each
 * letter may be upper or lower case.
 *
 * Flags:
 *      PF_UNDERSCORE   Skip underscores in parts before exponent.
 */
double parsef64(const ubyte[] s, out isz len, uint flags = 0)
{
    if (!s.len)
        return 0.0;

    bool negative = s[0] == '-';
    s = s[negative..$];
    len += negative;

    isz     n;
    Number  num = parse_number(s, negative, &n, flags);

    if (!n)
        return parse_infnan(s, negative, &len);

    len += n;

    int    err;
    double value = fastpath64(&num, &err);

    if (!err) return value;
    err = 0;

    // If significant digits were truncated, then we can have rounding error
    // only if `mantissa + 1` produces a different result. We also avoid
    // redundantly using the Eisel-Lemire algorithm if it was unable to
    // correctly round on the first pass.

    BiasedFP fp = compute_float(num.exponent, num.mantissa, &F64_CONSTS);

    if (num.many_digits && fp.e >= 0) {
        auto fp2 = compute_float(num.exponent, num.mantissa + 1, &F64_CONSTS);
        if (fp.f != fp2.f || fp.e != fp2.e)
            fp.e = -1;
    }

    if (fp.e < 0) { // Unable to correctly round the float.
        fp = parse_fallback(s, &n, &F64_CONSTS); // slow but always correct
        len = negative + n; // note: relying on negative
    }

    double v = biasedfp_to_native64(fp);

    if (num.negative)
        v = -v;

    define BIASED_EXP_INF = 0x7ff00000_00000000Lu >> F64_MANTISSA_EXPLICIT_BITS;

    if !(flags & PF_EXTREMES) {
        bool nz = num.mantissa > 0;
        len *= !(nz & (fp.f + fp.e == 0) | (fp.e == BIASED_EXP_INF));
    }

    return v;
}

float parsef32(const ubyte[] s, out isz len, uint flags = 0)
{
    if (!s.len)
        return 0.0;

    bool negative = s[0] == '-';
    s = s[negative..$];
    len += negative;

    isz     n;
    Number  num = parse_number(s, negative, &n, flags);

    if (!n)
        return parse_infnan(s, negative, &len);

    len += n;

    int    err;
    float  value = fastpath32(&num, &err);

    if (!err) return value;
    err = 0;

    // If significant digits were truncated, then we can have rounding error
    // only if `mantissa + 1` produces a different result. We also avoid
    // redundantly using the Eisel-Lemire algorithm if it was unable to
    // correctly round on the first pass.

    BiasedFP fp = compute_float(num.exponent, num.mantissa, &F32_CONSTS);

    if (num.many_digits && fp.e >= 0) {
        auto fp2 = compute_float(num.exponent, num.mantissa + 1, &F32_CONSTS);
        if (fp.f != fp2.f || fp.e != fp2.e)
            fp.e = -1;
    }

    if (fp.e < 0) { // Unable to correctly round the float.
        fp = parse_fallback(s, &n, &F32_CONSTS); // slow but always correct
        len = negative + n; // note: relying on negative
    }

    float v = biasedfp_to_native32(fp);

    if (num.negative)
        v = -v;

    define BIASED_EXP_INF = 0x7f80_0000u >> F32_MANTISSA_EXPLICIT_BITS;

    if !(flags & PF_EXTREMES) {
        bool nz = num.mantissa > 0;
        len *= !(nz & (fp.f + fp.e == 0) | (fp.e == BIASED_EXP_INF));
    }

    return v;
}
