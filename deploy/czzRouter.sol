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

interface IRouter {
    function getAddress() external returns(address ads); 
    // function getAmountsOut(IERC20 _srcToken, IERC20 _dstToken, uint256 _srcAmount)
    //     external view returns (uint256 dstAmount);
    function swapSTD2Token(uint256 _srcAmount, address _dstToken, uint256 _minDstAmount)
        external payable returns (uint256 dstAmount);
    function swapToken2STD(address _srcToken, uint256 _srcAmount, uint256 _minDstAmount)
        external returns (uint256 dstAmount);
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
    using SafeERC20 for IERC20;
    
    address internal constant CONTRACT_ADDRESS = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    IUniswapV2Router02 internal 1inch;
     
    constructor() public {
        1inch = IUniswapV2Router02(CONTRACT_ADDRESS);
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
        path[0] = 1inch.WETH();
        path[1] = _dstToken;

        uint256[] memory amounts = 1inch.swapExactETHForTokens{ value: _srcAmount }(
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
        path[1] = 1inch.WETH();
        
        uint256[] memory amounts = 1inch.swapExactTokensForETH(
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
