import inspect
import os

from typing import Tuple
from starkware.starknet.testing.starknet import Starknet, StarknetContract


def str_to_felt(str):
    """Return felt for passed string"""
    return int(str.encode('utf-8').hex(), 16)


class StarknetContractTester():
    """
    Adds some shortcuts for testing
    """

    def __init__(self, contract) -> None:
        self.contract = contract

    async def assert_call(self, entrypoint, assertResult, caller_address=0, **args):
        """
        One liner to call views and assert result

        Example:
        await contract_tester.assert_call( 'contract_view_name', (1,), view_arg1=23, view_arg2=23464654 )
        """
        # Get callable view entrypoint from contract
        view = getattr(self.contract, entrypoint)
        # Call the view
        execution_info = await view(**args).call(caller_address)
        # assert result
        assert execution_info.result == assertResult


async def setup_test_contract(cairo_file, constructor_calldata=[]) -> Tuple[StarknetContract, StarknetContractTester]:
    """Creates StarknetContract from a cairo file."""

    # The path to the contract source code.
    caller_path = os.path.abspath(inspect.stack()[1][1])
    cairo_file_path = os.path.join(
        os.path.dirname(caller_path), cairo_file)

    # Create a new Starknet class that simulates the StarkNet
    # system.
    starknet = await Starknet.empty()

    # Deploy the contract.
    contract = await starknet.deploy(
        source=cairo_file_path,
        constructor_calldata=constructor_calldata,
    )

    tester = StarknetContractTester(contract)
    return (contract, tester)
