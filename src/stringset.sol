// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

library StringSet {
    struct Set {
        string[] _values;

        mapping(string value => uint256) _positions;
    }

    function add(Set storage set, string memory value) internal returns (bool) {
        if (!contains(set, value)) {
            set._values.push(value);
            set._positions[value] = set._values.length;

            return true;
        } else {
            return false;
        }
    }
    
}