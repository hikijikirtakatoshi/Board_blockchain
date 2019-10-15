const BoardContract = artifacts.require('Board.sol');

module.exports = function (deployer) {
  deployer.deploy(BoardContract);
};