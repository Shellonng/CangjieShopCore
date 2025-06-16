package CangjieShopCore.services_impl

import CangjieShopCore.services.*
import CangjieShopCore.models.*
import CangjieShopCore.library.*
//sdk
import std.fs.*
import std.io.*
import serialization.serialization.*
import encoding.json.*

public class UserServiceImpl <: IUserService{

    private let first_dir_path="./data"
    private let second_dir_path="${first_dir_path}/user"

    private let userLibrary:UserLibrary=UserLibrary()

    public func create(uuid:String,username:String,password:String,address:String):Bool{
        if(!Directory.exists(second_dir_path)){
            if(!Directory.exists(first_dir_path)){
                Directory.create(first_dir_path)
            }
            Directory.create(second_dir_path)
        }
        let file_path="${second_dir_path}/${username}"
        var user=User()

        user.userId=uuid
        user.username=username
        user.password=password
        user.address=address

        var data_model = user.serialize()
        var json_obj = data_model.toJson().asObject()
        let user_info_json_str=json_obj.toJsonString()

        let res=userLibrary.writeFile(file_path,user_info_json_str)

        return res
    }

    public func getUserIdentify(username:String):String{
        let file_path="${second_dir_path}/${username}"
        let res=userLibrary.getUser(file_path,username)
        let uuid=res.userId
        return uuid
    }
    public func getUserAddress(username:String):String{
        let file_path="${second_dir_path}/${username}"
        let res=userLibrary.getUser(file_path,username)
        let address=res.address

        return address
    }
    
}