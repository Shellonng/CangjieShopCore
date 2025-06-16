package CangjieShopCore.models

import serialization.serialization.*
import encoding.json.*

public class User <:Serializable<User>{
    public var userId:String=""
    public var username:String=""
    public var password:String=""
    public var address:String=""

    public func serialize(): DataModel {
        return DataModelStruct()
            .add(field<String>("userId", userId))
            .add(field<String>("username", username))
            .add(field<String>("password", password))
            .add(field<String>("address", address))
    }

    public static func deserialize(dm: DataModel): User {
        var dms = match (dm) {
            case data: DataModelStruct => data
            case _ => throw Exception("this data is not DataModelStruct")
        }
        var result = User()
        result.userId = String.deserialize(dms.get("userId"))
        result.username = String.deserialize(dms.get("username"))
        result.password = String.deserialize(dms.get("password"))
        result.address = String.deserialize(dms.get("address"))
        
        return result
    }
}