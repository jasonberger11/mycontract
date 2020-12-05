pragma solidity ^0.6.6;

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}
interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountETH);
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}


// pragma solidity ^0.5.0;


interface IOneSplit {
    
    function getExpectedReturn(
        IERC20 fromToken,
        IERC20 destToken,
        uint256 amount,
        uint256 parts,
        uint256 flags // See constants in IOneSplit.sol
    )
        external
        view
        returns(
            uint256 returnAmount,
            uint256[] memory distribution
        );

    function getExpectedReturnWithGas(
        IERC20 fromToken,
        IERC20 destToken,
        uint256 amount,
        uint256 parts,
        uint256 flags, // See constants in IOneSplit.sol
        uint256 destTokenEthPriceTimesGasPrice
    )
        external
        view
        returns(
            uint256 returnAmount,
            uint256 estimateGasAmount,
            uint256[] memory distribution
        );

    function swap(
        IERC20 fromToken,
        IERC20 destToken,
        uint256 amount,
        uint256 minReturn,
        uint256[] memory distribution,
        uint256 flags
    )
        external
        payable
        returns(uint256 returnAmount);
}

pragma solidity ^0.6.6;

interface IRouter {
    function getAddress() external returns(address ads); 
    // function getAmountsOut(IERC20 _srcToken, IERC20 _dstToken, uint256 _srcAmount)
    //     external view returns (uint256 dstAmount);
    function swapSTD2Token(uint256 _srcAmount, address _dstToken, uint256 _minDstAmount)
        external payable returns (uint256 dstAmount);
    function swapToken2STD(address _srcToken, uint256 _srcAmount, uint256 _minDstAmount)
        external returns (uint256 dstAmount);
}

library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

contract BoundRouterOfTrx is IRouter{
    
    using SafeMath for uint256;
    // using SafeERC20 for IERC20;
    
    address internal constant CONTRACT_ADDRESS = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    IUniswapV2Router02 internal uniswap;
     
    constructor() public {
        uniswap = IUniswapV2Router02(CONTRACT_ADDRESS);
    } 
    function getAddress() public override returns(address ads)
    {
        return CONTRACT_ADDRESS;
    }
    function swapSTD2Token(uint256 _srcAmount, address _dstToken, uint256 _minDstAmount)
        public payable override returns (uint256 dstAmount)
    {
        require(msg.value > 0);
        
        address[] memory path = new address[](2);
        path[0] = uniswap.WETH();
        path[1] = _dstToken;

        uint256[] memory amounts = uniswap.swapExactETHForTokens{ value: _srcAmount }(
            _minDstAmount,
            path,
            msg.sender,
            now + 600
        );
        require(amounts.length >= 2);
        return amounts[amounts.length - 1];
    }
    function swapToken2STD(address _srcToken, uint256 _srcAmount, uint256 _minDstAmount)
        public override returns (uint256 dstAmount)
    {
        require(IERC20(_srcToken).balanceOf(msg.sender) >= _srcAmount);
        
        // IERC20(_srcToken).approve(address(CONTRACT_ADDRESS), _srcAmount + 1);
        // IERC20(_srcToken).safeIncreaseAllowance(CONTRACT_ADDRESS, _srcAmount);
        
        address[] memory path = new address[](2);
        path[0] = _srcToken;
        path[1] = uniswap.WETH();
        
        uint256[] memory amounts = uniswap.swapExactTokensForETH(
            _srcAmount,
            _minDstAmount,
            path,
            msg.sender,
            now + 600
        );
        require(amounts.length >= 2);
        return amounts[amounts.length - 1];
    }
}
contract BoundRouterOfEth is IRouter{
    
    using SafeMath for uint256;
    // using SafeERC20 for IERC20;
    
    address internal constant CONTRACT_ADDRESS = 0xC586BeF4a0992C495Cf22e1aeEE4E446CECDee0E;  // OneSplitAudit on mainnet
    IOneSplit internal oneInch;
    address internal constant WETH_ADDRESS = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;       // WETH address on mainnet
     
    constructor() public {
        oneInch = IOneSplit(CONTRACT_ADDRESS);
    } 
    function getAddress() public override returns(address ads)
    {
        return CONTRACT_ADDRESS;
    }
    function swapSTD2Token(uint256 _srcAmount, address _dstToken, uint256 _minDstAmount)
        public payable override returns (uint256 dstAmount)
    {
        require(msg.value > 0);

        (uint256 returnAmount,uint256[] memory distribution) = oneInch.getExpectedReturn(
            IERC20(WETH_ADDRESS),
            IERC20(_dstToken),
            _srcAmount,
            5,
            0
            );
        return oneInch.swap(IERC20(WETH_ADDRESS),
                            IERC20(_dstToken),
                            _srcAmount,
                            returnAmount,
                            distribution,
                            0
                            );
    }
    function swapToken2STD(address _srcToken, uint256 _srcAmount, uint256 _minDstAmount)
        public override returns (uint256 dstAmount)
    {
        require(IERC20(_srcToken).balanceOf(msg.sender) >= _srcAmount);
        
        // IERC20(_srcToken).approve(address(CONTRACT_ADDRESS), _srcAmount + 1);
        // IERC20(_srcToken).safeIncreaseAllowance(CONTRACT_ADDRESS, _srcAmount);
        (uint256 returnAmount,uint256[] memory distribution) = oneInch.getExpectedReturn(
            IERC20(_srcToken),
            IERC20(WETH_ADDRESS),
            _srcAmount,
            5,
            0
            );
        return oneInch.swap(IERC20(_srcToken),
                                       IERC20(WETH_ADDRESS),
                                       _srcAmount,
                                       returnAmount,
                                       distribution,
                                       0
                                       );
        
    }
}
