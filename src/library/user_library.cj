package CangjieShopCore.library

import std.fs.*
import std.io.*
import CangjieShopCore.models.*
import serialization.serialization.*
import encoding.json.*

public class UserLibrary{
    public func writeFile(path:String,content:String):Bool{
        try(file=File.create(path), fileWriter=StringWriter(file)){
            fileWriter.write(content)
            return true
        }
        return false
    }
    public func getUser(path:String,username:String):User{
        var user:User=User()
        try(phone_file=File.openRead(path), fileRead=StringReader(phone_file)){
            let res=fileRead.readToEnd()
            var jv = JsonValue.fromStr(res)
            var dm = DataModel.fromJson(jv)
            user = User.deserialize(dm)
        }
        return user
    }

}