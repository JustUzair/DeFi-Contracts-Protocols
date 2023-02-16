const { network } = require("hardhat")
const { developmentChains } = require("../helper-hardhat-config")
const { verify } = require("../utils/verify")

module.exports = async function ({ getNamedAccounts, deployments }) {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()

    log("--------------------------")
    const args = ["0xf9d2FA8Ef2c5F933164f2b913E39803b181B7496"]
    const collateralBackedToken = await deploy("CollateralBackedToken", {
        from: deployer,
        args,
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    })

    if (!developmentChains.includes(network.name) && process.env.ETHERSCAN_API_KEY) {
        log("Verifying................................")
        await verify(collateralBackedToken.address, args)
    }
    log("--------------------------")
}

module.exports.tags = ["all", "collateralBackedToken", "main"]
