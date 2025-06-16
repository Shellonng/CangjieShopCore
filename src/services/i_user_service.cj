package CangjieShopCore.services

public interface IUserService{
    func getUserIdentify(username:String):String
    func getUserAddress(username:String):String
    func create(uuid:String,username:String,password:String,address:String):Bool
}