package CangjieShopCore.library

import std.fs.*
import std.io.*
import CangjieShopCore.models.*
import serialization.serialization.*
import encoding.json.*

public class ProductLibrary{
    public func writeFile(path:String,content:String):Bool{
        try(file=File.create(path), fileWriter=StringWriter(file)){
            fileWriter.write(content)
            return true
        }
        return false
    }
    public func getProduct(path:String):Product{
        var product:Product=Product()
        try(phone_file=File.openRead(path), fileRead=StringReader(phone_file)){
            let res=fileRead.readToEnd()
            var jv = JsonValue.fromStr(res)
            var dm = DataModel.fromJson(jv)
            product = Product.deserialize(dm)
        }
        return product
    }

    public func updateProduct(path:String,content:String):Unit{
        try(file = File(path, OpenOption.CreateOrTruncate(true)), fileWriter=StringWriter(file)){
            fileWriter.write(content)
        }
    }
    public func get(path:String):Int64{
        var product:Product=Product()
        try(phone_file=File.openRead(path), fileRead=StringReader(phone_file)){
            let res=fileRead.readToEnd()
            var jv = JsonValue.fromStr(res)
            var dm = DataModel.fromJson(jv)
            product = Product.deserialize(dm)
        }
        return product.stock
    }
    public func deleteProduct(file_path:String):Unit{
        File.delete(file_path)
    }
}
