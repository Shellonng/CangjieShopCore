package CangjieShopCore.view_model

import CangjieShopCore.services.*
import CangjieShopCore.services_impl.*

import CangjieShopCore.models.*

public class OrderViewModel{

    private let orderService:IOrderService=OrderServiceImpl()
    private let uuidService:IUuidGenerationService=UuidGenerationService()
    private let userService:IUserService=UserServiceImpl()

    public func createOrder(username:String):Bool{
        let userUuid=userService.getUserIdentify(username)
        let orderUuid=uuidService.getOrderUuid()
        var order=Order()
        order.orderId=orderUuid
        order.userId=userUuid
        order.isPayment=false
        
        let res=orderService.createOrder(order,username)
        return res
    }
    public func addOrder(username:String,orderItem:OrderItem):Float64{
        let res=orderService.addOrder(username,orderItem)
        return res
    }
    public func payOrder(username:String):Float64{
        let res=orderService.pay(username)
        return res
    }
}