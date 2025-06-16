package CangjieShopCore.models

import serialization.serialization.*
import encoding.json.*

public class OrderItem <:Serializable<OrderItem>{
    public var orderItemId:String=""
    public var productId:String=""
    public var number:Int64=0
    public var unitPrice:Float64=0.0
    public var subtotal:Float64=0.0



    public func serialize(): DataModel {
        return DataModelStruct()
            .add(field<String>("orderItemId", orderItemId))
            .add(field<String>("productId", productId))
            .add(field<Int64>("number", number))
            .add(field<Float64>("unitPrice", unitPrice))
            .add(field<Float64>("subtotal", subtotal))
    }

    public static func deserialize(dm: DataModel): OrderItem {
        var dms = match (dm) {
            case data: DataModelStruct => data
            case _ => throw Exception("this data is not DataModelStruct")
        }
        var result = OrderItem()
        result.orderItemId = String.deserialize(dms.get("orderItemId"))
        result.productId = String.deserialize(dms.get("productId"))
        result.number = Int64.deserialize(dms.get("number"))
        result.unitPrice = Float64.deserialize(dms.get("unitPrice"))
        result.subtotal = Float64.deserialize(dms.get("subtotal"))
        
        return result
    }
}