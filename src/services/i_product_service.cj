package CangjieShopCore.services

import CangjieShopCore.models.*

public interface IProductService{
    func createProduct(product:Product):Bool
    func updateStock(productName:String,num:Int64,isIncr:Bool):Int64
    func getStock(productName:String):Int64
    func updatePrice(productName:String,newPrice:Float64):Bool
    func updateIsSaling(productName:String,isSaling:Bool):Bool
    func deleteProduct(productName:String):Unit
    func getProductPrice(productName:String):Float64
    func getProductUuid(productName:String):String

}