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

    function remove(Set storage set, string memory value) internal returns (bool) {
        uint256 position = set._positions[value];

        if (position != 0) {
            uint256 valueIndex = position - 1;
            uint256 lastIndex = set._values.length - 1;

            if (valueIndex != lastIndex) {
                string memory lastValue = set._values[lastIndex];

                set._values[valueIndex] = lastValue;
                set._positions[lastValue] = position;
            }

            set._values.pop();

            delete set._positions[value];

            return true;
        } else {
            return false;
        }
    }

    function contains(Set storage set, string memory value) internal view returns (bool) {
        return set._positions[value] != 0;
    }

    function length(Set storage set) internal view returns (uint256) {
        return set._values.length;
    }

    function at(Set storage set, uint256 index) internal view returns (string memory) {
        return set._values[index];
    }

    function values(Set storage set) internal view returns (string[] memory) {
        return set._values;
    }
}
