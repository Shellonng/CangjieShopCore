package CangjieShopCore.view_model

import CangjieShopCore.services.*
import CangjieShopCore.services_impl.*

public class UserViewModel{

    private let userService:IUserService=UserServiceImpl()
    private let uuidService:IUuidGenerationService=UuidGenerationService()
    public func createUser(username:String,password:String,address:String):Bool{
        let uuid:String=uuidService.getUuid()
        let res=userService.create(uuid,username,password,address)
        return res
    }
    public func getUserIdentify(username:String):String{
        let res=userService.getUserIdentify(username)
        if(res.isEmpty()){
            throw Exception("发生内部错误")
        }
        return res
    }
    public func getUserAddress(username:String):String{
        let res=userService.getUserAddress(username)
        if(res.isEmpty()){
            throw Exception("发生内部错误")
        }
        return res
    }
}