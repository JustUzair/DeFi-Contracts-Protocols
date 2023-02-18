const { network } = require("hardhat")
const { developmentChains } = require("../helper-hardhat-config")
const { verify } = require("../utils/verify")
require("@nomiclabs/hardhat-waffle")
require("@nomiclabs/hardhat-etherscan")
const { run } = require("hardhat")

module.exports = async function ({ getNamedAccounts, deployments }) {
    const { deploy, log } = deployments
    const { deployer } = await getNamedAccounts()

    log("--------------------------")
    log("Deploying Governance Token...")
    const governanceToken = await deploy("GovernanceToken", {
        from: deployer,
        args: [],
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    })
    log("--------------------------")
    log("Deploying Utility Token...")
    const utilityToken = await deploy("UnderlyingToken", {
        from: deployer,
        args: [],
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    })
    log("--------------------------")
    log("Deploying Liquidity Pool Token...")
    const lpToken = await deploy("LPToken", {
        from: deployer,
        args: [],
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    })
    log("--------------------------")
    const args = [utilityToken.address, governanceToken.address]
    log("Deploying Liquidity Pool...")
    const liquidityPool = await deploy("LiquidityPool", {
        from: deployer,
        args,
        log: true,
        waitConfirmations: network.config.blockConfirmations || 1,
    })
    log("--------------------------")
    if (!developmentChains.includes(network.name) && process.env.ETHERSCAN_API_KEY) {
        log("Verifying................................")
        await verify(governanceToken.address, [])
        await verify(utilityToken.address, [])
        await verify(lpToken.address, [])
        try {
            await run("verify:verify", {
                address: liquidityPool.address,
                constructorArguments: args,
                contract: "contracts/Liquidity Mining/LPToken.sol:LPToken",
            })
        } catch (e) {
            if (e.message.toLowerCase().includes("already verified")) {
                console.log("Already verified!")
            } else {
                console.log(e)
            }
        }
    }
    log("--------------------------")
}

module.exports.tags = ["all", "lptoken", "main"]
