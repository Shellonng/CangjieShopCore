package CangjieShopCore.test

//test
import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*

import CangjieShopCore.view_model.*
import CangjieShopCore.models.*

@Test
public class OrderViewModelTest{

    private let product_view_model=ProductViewModel()
    private let user_view_model=UserViewModel()

    private let username1="user1"
    private let username2="user2"
    private var uuid=""

    private var item1=OrderItem()
    private var item2=OrderItem()
    private var item3=OrderItem()
    private var item4=OrderItem()

    private let product1="1农夫山泉1"
    private let product2="1哇哈哈1"
    private let product3="1纯悦1"
    private let product4="1怡宝1"
    
    @BeforeAll
    public func createItems(){
        let price=1.8
        let desc="矿泉水/纯净水"
        let stock=999
        let isSaling=true

        

        product_view_model.createProduct(product1,price,desc,stock,isSaling)
        product_view_model.createProduct(product2,price,desc,stock,isSaling)
        product_view_model.createProduct(product3,price,desc,stock,isSaling)
        product_view_model.createProduct(product4,price,desc,stock,isSaling)

        user_view_model.createUser(username1,"123456","辽宁省沈阳市")
        user_view_model.createUser(username2,"0987654","辽宁省大连市")

        item1=OrderItemViewModel.create(product1,1)
        item2=OrderItemViewModel.create(product2,2)
        item3=OrderItemViewModel.create(product3,3)
        item4=OrderItemViewModel.create(product4,4)

        uuid=user_view_model.getUserIdentify(username2)

    }
    @AfterAll
    public func reset(){
        File.delete("./data/product/${product1}")
        File.delete("./data/product/${product2}")
        File.delete("./data/product/${product3}")
        File.delete("./data/product/${product4}")

        File.delete("./data/user/${username1}")
        File.delete("./data/user/${username2}")

        File.delete("./data/order/${username1}")
        File.delete("./data/order/${uuid}")
    }

    @TestCase
    public func test_create_order(){
        let order_view_model=OrderViewModel()
        order_view_model.createOrder(username1)
        @Assert(File.exists("./data/order/${username1}"))
        File.delete("./data/order/${username1}")
        @Assert(!File.exists("./data/order/${username1}"))
    }
    @TestCase
    public func test_add_order(){
        let order_view_model=OrderViewModel()
        order_view_model.createOrder(username1)
        @Assert(File.exists("./data/order/${username1}"))
        let total1=order_view_model.addOrder(username1,item1)
        let total2=order_view_model.addOrder(username1,item2)
        @Assert(total2,item1.subtotal+item2.subtotal)
    }
    @TestCase
    public func test_pay_order(){
        let order_view_model=OrderViewModel()
        order_view_model.createOrder(username2)
        @Assert(File.exists("./data/order/${username2}"))
        let total1=order_view_model.addOrder(username2,item3)
        let total2=order_view_model.addOrder(username2,item4)
        @Assert(total2 , item4.subtotal+item3.subtotal)

        order_view_model.payOrder(username2)
        @Assert(!File.exists("./data/order/${username2}"))

        let userUuid=user_view_model.getUserIdentify(username2)
        @Assert(File.exists("./data/order/${userUuid}"))
    }
}