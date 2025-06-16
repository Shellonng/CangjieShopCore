package CangjieShopCore.library

import std.fs.*
import std.io.*
import CangjieShopCore.models.*
import serialization.serialization.*
import encoding.json.*

public class OrderLibrary{

    public func writeToFile(path:String,content:String):Bool{
        try(file=File.create(path), fileWriter=StringWriter(file)){
            fileWriter.write(content)
            return true
        }
        return false
    }
    public func getOrder(file_path:String):Order{
        var order:Order=Order()
        try(file=File.openRead(file_path), fileRead=StringReader(file)){
            let res=fileRead.readToEnd()
            var jv = JsonValue.fromStr(res)
            var dm = DataModel.fromJson(jv)
            order = Order.deserialize(dm)
        }
        return order
    }
    public func addOrder(path:String,content:String):Unit{
        try(file = File(path, OpenOption.CreateOrTruncate(true)), fileWriter=StringWriter(file)){
            fileWriter.write(content)
        }
    }
    public func payOrder(path:String,content:String,newPath:String):Unit{
        File.delete(path)
        try(file = File(newPath, OpenOption.CreateOrTruncate(true)), fileWriter=StringWriter(file)){
            fileWriter.write(content)
        }
    }

}