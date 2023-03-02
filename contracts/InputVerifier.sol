import "./Maintainer.sol";

contract InputVerifier {

    address private _signer;

    constructor(address signer) {
        _signer = signer;
    }

    function getSigner() external view returns (address) {
        return _signer;
    }

    function _setSigner(address signer) internal {
        _signer = signer;
    }

    // Signature verifier
    function _verifyMessage(bytes32 messageHash, bytes memory sig) internal view {
        bytes32 ethSignedMessageHash = _getEthSignedMessageHash(messageHash);
        require(_signer == _recover(ethSignedMessageHash, sig), "not signer");
    }

    function _getEthSignedMessageHash(bytes32 messageHash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", messageHash));
    }

    function _recover(bytes32 ethSignedMessageHash, bytes memory sig) internal pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = _split(sig);
        return ecrecover(ethSignedMessageHash, v, r, s);
    }

    function _split(bytes memory sig) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        require(sig.length == 65, "invalid signature length");
        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }
    }
}