// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {StringSet} from "./StringSet.sol";

library StringMap {
    using StringSet for StringSet.Set;

    error EnumerableMapNonexistentKey(string key);

    struct StringToStringMap {
        StringSet.Set _keys;
        mapping(string key => string) _values;
    }

    function set(StringToStringMap storage map, string memory key, string memory value) internal returns (bool) {
        map._values[key] = value;
        return map._keys.add(key);
    }

    function remove(StringToStringMap storage map, string memory key) internal returns (bool) {
        delete map._values[key];
        return map._keys.remove(key);
    }

    function contains(StringToStringMap storage map, string memory key) internal view returns (bool) {
        return map._keys.contains(key);
    }

    function length(StringToStringMap storage map) internal view returns (uint256) {
        return map._keys.length();
    }

    function at(StringToStringMap storage map, uint256 index)
        internal
        view
        returns (string memory key, string memory value)
    {
        string memory atKey = map._keys.at(index);
        return (atKey, map._values[atKey]);
    }

    function tryGet(StringToStringMap storage map, string memory key)
        internal
        view
        returns (bool exists, string memory value)
    {
        string memory val = map._values[key];
        if (bytes(val).length == 0) {
            return (contains(map, key), "");
        } else {
            return (true, val);
        }
    }

    function get(StringToStringMap storage map, string memory key) internal view returns (string memory) {
        string memory value = map._values[key];
        if (bytes(value).length == 0 && !contains(map, key)) {
            revert EnumerableMapNonexistentKey(key);
        }
        return value;
    }

    function keys(StringToStringMap storage map) internal view returns (string[] memory) {
        return map._keys.values();
    }
}
