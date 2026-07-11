// Copyright (c) Unconfirmed Labs, LLC
// SPDX-License-Identifier: MIT

#[test_only]
module country_code::country_code_tests;

// Aliased so the bare `country_code` name stays free for `abort_code = …`.
use country_code::country_code as cc;
use std::unit_test::assert_eq;

#[test]
fun accepts_assigned_codes() {
    assert_eq!(cc::new(b"JP".to_string()).code(), b"JP".to_string());
    assert_eq!(cc::new(b"US".to_string()).code(), b"US".to_string());
    assert_eq!(cc::new(b"GB".to_string()).code(), b"GB".to_string());
    // First and last entries of the list, to exercise the bounds.
    assert_eq!(cc::new(b"AD".to_string()).code(), b"AD".to_string());
    assert_eq!(cc::new(b"ZW".to_string()).code(), b"ZW".to_string());
}

#[test, expected_failure(abort_code = country_code::country_code::EInvalidCountryCode)]
fun rejects_unassigned_code() {
    let _ = cc::new(b"ZZ".to_string()); // well-formed but not an assigned country
    abort
}

#[test, expected_failure(abort_code = country_code::country_code::EInvalidCountryCode)]
fun rejects_wrong_length() {
    let _ = cc::new(b"USA".to_string());
    abort
}

#[test, expected_failure(abort_code = country_code::country_code::EInvalidCountryCode)]
fun rejects_lowercase() {
    let _ = cc::new(b"jp".to_string());
    abort
}
