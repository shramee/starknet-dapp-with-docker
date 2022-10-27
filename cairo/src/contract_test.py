import os
import pytest

from starkware.starknet.testing.starknet import Starknet

# The path to the contract source code.
CONTRACT_FILE = os.path.join(
    os.path.dirname(__file__), "contract.cairo")

# The testing library uses Python's asyncio. So the following
# decorator and the ``async`` keyword are needed.
@pytest.mark.asyncio
async def test_increase_balance():
    # Create a new Starknet class that simulates the StarkNet
    # system.
    starknet = await Starknet.empty()

    # Deploy the contract.
    contract = await starknet.deploy(
        source=CONTRACT_FILE,
    )

    # Invoke increase_balance() twice.
    await contract.increase_balance(amount=10).execute()
    await contract.increase_balance(amount=15).execute()

    # Check the result of get_balance().
    execution_info = await contract.get_balance().call()
    print( "Yo sup?", execution_info.result )
    assert execution_info.result == (25,)
	