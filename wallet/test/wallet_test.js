const Wallet = artifacts.require("./Wallet.sol");

contract("Wallet", function (accounts) {
  it("initializes the contract successfully", function () {
    return Wallet.deployed().then(function (instance) {
        
    })
  });
});
