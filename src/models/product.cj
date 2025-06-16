package CangjieShopCore.models

import serialization.serialization.*
import encoding.json.*

public class Product <:Serializable<Product>{
    public var productId:String=""
    public var productName:String=""
    public var price:Float64=0.0
    public var desc:String=""
    public var stock:Int64=0
    public var isSaling:Bool=true


    public func serialize(): DataModel {
        return DataModelStruct()
            .add(field<String>("productId", productId))
            .add(field<String>("productName", productName))
            .add(field<Float64>("price", price))
            .add(field<String>("desc", desc))
            .add(field<Int64>("stock", stock))
            .add(field<Bool>("isSaling", isSaling))
    }

    public static func deserialize(dm: DataModel): Product {
        var dms = match (dm) {
            case data: DataModelStruct => data
            case _ => throw Exception("this data is not DataModelStruct")
        }
        var result = Product()
        result.productId = String.deserialize(dms.get("productId"))
        result.productName = String.deserialize(dms.get("productName"))
        result.price = Float64.deserialize(dms.get("price"))
        result.desc = String.deserialize(dms.get("desc"))
        result.stock = Int64.deserialize(dms.get("stock"))
        result.isSaling = Bool.deserialize(dms.get("isSaling"))
        
        return result
    }
}