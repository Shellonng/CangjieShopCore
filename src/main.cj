package CangjieShopCore


import CangjieShopCore.view_model.*

main(): Int64 {

    /**
        运行 cjpm run 之前需要删除  目录  data
        否则会无法运行完成

        否则运行cjpm test即可
    */



    let userViewModel=UserViewModel()

    let res=userViewModel.createUser("testuser", "123456", "辽宁省沈阳市")
    let uuid=userViewModel.getUserIdentify("testuser")
    println(uuid)
    let address=userViewModel.getUserAddress("testuser")
    println(address)

    let productViewModel=ProductViewModel()
    let isProductCreate=productViewModel.createProduct("农夫山泉", 2.1, "我们不生产水", 999, true)
    println("创建商品成功：${isProductCreate}")
    let destock=productViewModel.deductionOfStock("农夫山泉", 89)
    println("扣减库存之后：${destock}")
    let instock=productViewModel.incrStock("农夫山泉", 89)
    println("增加库存之后：${instock}")

    let updatePrice=productViewModel.updatePrice("农夫山泉", 1.8)
    println("更新价格：${updatePrice}")

    let orderViewModel=OrderViewModel()
    var isCreateOrder1=orderViewModel.createOrder("testuser")
    println("创建空订单: ${isCreateOrder1}")

    let res1=userViewModel.createUser("testuser2", "1234056", "辽宁省沈阳市")

    var isCreateOrder2=orderViewModel.createOrder("testuser2")
    println("创建空订单: ${isCreateOrder2}")

    let item1=OrderItemViewModel.create("农夫山泉",10)
    let total=orderViewModel.addOrder("testuser2", item1)
    println("增加后的总价: ${total}")

    let item2=OrderItemViewModel.create("农夫山泉",20)
    let total1=orderViewModel.addOrder("testuser2", item2)
    println("增加后的总价: ${total1}")

    let pay=orderViewModel.payOrder("testuser2")
    println("结算：${pay}")


    return 0
}