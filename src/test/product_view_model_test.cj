package CangjieShopCore.test

//test
import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*

import CangjieShopCore.view_model.*
import CangjieShopCore.models.*

@Test
public class ProductViewModelTest{
    private let TestProduct1="农夫山泉"
    private let TestProduct2="哇哈哈"
    private let TestProduct3="纯悦"
    private let TestProduct4="怡宝"
    @AfterAll
    public func reset(){
        File.delete("./data/product/${TestProduct1}")
        File.delete("./data/product/${TestProduct2}")
        File.delete("./data/product/${TestProduct3}")
        File.delete("./data/product/${TestProduct4}")
    }

    @TestCase
    public func test_create_product_success(){
        let productViewModel=ProductViewModel()
        let price=2.1
        let desc="我们不生产水"
        let stock=999
        let isSaling=true
        let isCreate=productViewModel.createProduct(TestProduct1,price,desc,stock,isSaling)
        @Assert(File.exists("./data/product/${TestProduct1}"))
        let resurn_stock=productViewModel.getStock(TestProduct1)
        @Expect(resurn_stock,stock)
    }

    @TestCase
    public func test_deduction_of_stock_by_one(){
        let productViewModel=ProductViewModel()
        let price=3.0
        let desc="纯净水"
        let stock=99
        let isSaling=true
        let isCreate=productViewModel.createProduct(TestProduct2,price,desc,stock,isSaling)
        @Assert(File.exists("./data/product/${TestProduct2}"))
        let resurn_stock=productViewModel.deductionOfStockByOne(TestProduct2)
        @Expect(resurn_stock,stock-1)
    }

    @TestCase
    public func test_deduction_of_stock(){
        let productViewModel=ProductViewModel()
        let price=3.0
        let desc="纯悦"
        let stock=99
        let isSaling=true

        let num=8
        let isCreate=productViewModel.createProduct(TestProduct3,price,desc,stock,isSaling)
        @Assert(File.exists("./data/product/${TestProduct3}"))
        let resurn_stock=productViewModel.deductionOfStock(TestProduct3,num)
        @Expect(resurn_stock,stock-num)
    }

    @TestCase
    public func test_incr_stock(){
        let productViewModel=ProductViewModel()
        let price=1.8
        let desc="水"
        let stock=90
        let isSaling=true

        let num=8
        let isCreate=productViewModel.createProduct(TestProduct4,price,desc,stock,isSaling)
        @Assert(File.exists("./data/product/${TestProduct4}"))
        let resurn_stock=productViewModel.incrStock(TestProduct4,num)
        @Expect(resurn_stock,stock + num)
    }

    @TestCase
    public func test_update_price(){
        let productViewModel=ProductViewModel()
        let newPrice=1.8
        @Assert(File.exists("./data/product/${TestProduct1}"))
        let res=productViewModel.updatePrice(TestProduct1,newPrice)
        @Assert(res)
    }
    @TestCase
    public func test_update_isSaling(){
        let productViewModel=ProductViewModel()
        let newPrice=1.8
        @Assert(File.exists("./data/product/${TestProduct1}"))
        let res=productViewModel.updateIsSaling(TestProduct1,false)
        @Assert(res)
    }
    @TestCase
    public func test_delete_product(){
        let productViewModel=ProductViewModel()
        let name="康师傅"
        let price=2.1
        let desc="water"
        let stock=10
        let isSaling=true
        @Assert(!File.exists("./data/product/${name}"))
        let isCreate=productViewModel.createProduct(name,price,desc,stock,isSaling)
        @Assert(File.exists("./data/product/${name}"))
        productViewModel.deleteProduct(name)
        @Assert(!File.exists("./data/product/${name}"))
    }
}