import os
import pytest
from tests.utils import setup_test_contract, str_to_felt


# Define `async` test function with `@pytest.mark.asyncio`` decorator
@pytest.mark.asyncio
async def test_increase_balance():
    # Setup StarknetContract and StarknetContractTester
    (contract, tester) = await setup_test_contract('contract.cairo')

    # Invoke increase_balance() twice.
    await contract.increase_balance(amount=10).execute()
    await contract.increase_balance(amount=15).execute()

    # Call view and assert response
    await tester.assert_call('get_balance', (25,))
