package CangjieShopCore.view_model

import CangjieShopCore.models.*
import CangjieShopCore.services.*
import CangjieShopCore.services_impl.*

import std.convert.*

public class OrderItemViewModel{
    public static func create(productName:String,number:Int64):OrderItem{

        var orderItem=OrderItem()

        let productService:IProductService=ProductServiceImpl()
        let uuidServie:IUuidGenerationService=UuidGenerationService()

        let _productId=productService.getProductUuid(productName)
        let price=productService.getProductPrice(productName)

        orderItem.unitPrice=price
        orderItem.productId=_productId
        orderItem.orderItemId=uuidServie.getOrderUuid()
        orderItem.subtotal=price*Float64.parse("${number}")
        orderItem.number=number

        return orderItem
    }
}



