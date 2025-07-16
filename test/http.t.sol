// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {HTTP} from "../src/http.sol";
import {strings} from "solidity-stringutils/strings.sol";

contract HTTPTest is Test {
    using HTTP for *;
    using strings for *;

    HTTP.Client http;
}
