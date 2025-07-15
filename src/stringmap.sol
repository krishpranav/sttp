// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { StringSet } from "./stringset.sol";

library StringMap {
    using StringSet for StringSet.Set;

    error EnumerableMapNonexistentKey(string key);

    struct StringToStringMap {
        StringSet.Set _keys;
        mapping(string key => string) _values;
    }
}