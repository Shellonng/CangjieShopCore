package CangjieShopCore.models

import serialization.serialization.*
import encoding.json.*
import std.collection.*

public class Order <: Serializable<Order>{
    public var orderId:String=""
    public var userId:String=""
    public var total:Float64=0.0
    public var orderItems:ArrayList<OrderItem>=ArrayList<OrderItem>()
    public var isPayment:Bool=false

    public func serialize(): DataModel {
        return DataModelStruct()
            .add(field<String>("orderId", orderId))
            .add(field<String>("userId", userId))
            .add(field<Float64>("total", total))
            .add(field<ArrayList<OrderItem>>("orderItems", orderItems))
            .add(field<Bool>("isPayment", isPayment))
    }

    public static func deserialize(dm: DataModel): Order {
        var dms = match (dm) {
            case data: DataModelStruct => data
            case _ => throw Exception("this data is not DataModelStruct")
        }
        var result = Order()
        result.orderId = String.deserialize(dms.get("orderId"))
        result.userId = String.deserialize(dms.get("userId"))
        result.total = Float64.deserialize(dms.get("total"))
        result.orderItems = ArrayList<OrderItem>.deserialize(dms.get("orderItems"))
        result.isPayment = Bool.deserialize(dms.get("isPayment"))
        
        return result
    }
}