package CangjieShopCore.services_impl

import CangjieShopCore.services.*
import CangjieShopCore.models.*
import CangjieShopCore.library.*


//sdk
import std.fs.*
import std.io.*
import serialization.serialization.*
import encoding.json.*

public class ProductServiceImpl <: IProductService{
    private let first_dir_path="./data"
    private let second_dir_path="${first_dir_path}/product"


    private let productLibrary:ProductLibrary=ProductLibrary()
    public func createProduct(product:Product):Bool{
        if(!Directory.exists(second_dir_path)){
            if(!Directory.exists(first_dir_path)){
                Directory.create(first_dir_path)
            }
            Directory.create(second_dir_path)
        }
        let name=product.productName
        let file_path="${second_dir_path}/${name}"


        var data_model = product.serialize()
        var json_obj = data_model.toJson().asObject()
        let product_info_json_str=json_obj.toJsonString()

        let res=productLibrary.writeFile(file_path,product_info_json_str)
        return res
    }
    public func getProductUuid(productName:String):String{
        let file_path="${second_dir_path}/${productName}"
        var product=productLibrary.getProduct(file_path)
        return product.productId
    }
    public func getProductPrice(productName:String):Float64{
        let file_path="${second_dir_path}/${productName}"
        var product=productLibrary.getProduct(file_path)
        return product.price
    }
    public func updateStock(productName:String,num:Int64,isIncr:Bool):Int64{
        var res=0
        
        if(isIncr){
            res=incrStock(productName,num)
        }else{
            res=decrStock(productName,num)
        }
        return res
    }
    func incrStock(productName:String,num:Int64):Int64{

        let file_path="${second_dir_path}/${productName}"
        if(!File.exists(file_path)){
            return -2
        }
        var product=productLibrary.getProduct(file_path)
        product.stock+=num
        if(product.stock<0){
            return -2
        }

        var res=product.stock

        var data_model = product.serialize()
        var json_obj = data_model.toJson().asObject()
        let product_info_json_str=json_obj.toJsonString()

        productLibrary.updateProduct(file_path,product_info_json_str)
        
        return res
    }
    func decrStock(productName:String,num:Int64):Int64{
        let file_path="${second_dir_path}/${productName}"
        if(!File.exists(file_path)){
            return -2
        }
        var product=productLibrary.getProduct(file_path)
        product.stock-=num
        if(product.stock<0){
            return -2
        }

        var res=product.stock

        var data_model = product.serialize()
        var json_obj = data_model.toJson().asObject()
        let product_info_json_str=json_obj.toJsonString()

        productLibrary.updateProduct(file_path,product_info_json_str)
        
        return res
    }
    public func getStock(productName:String):Int64{
        let file_path="${second_dir_path}/${productName}"
        if(!File.exists(file_path)){
            return -2
        }
        productLibrary.get(file_path)
    }
    public func updatePrice(productName:String,newPrice:Float64):Bool{
        let file_path="${second_dir_path}/${productName}"
        if(!File.exists(file_path)){
            return false
        }
        var product=productLibrary.getProduct(file_path)
        product.price=newPrice
        if(product.price<0.0){
            return false
        }

        var data_model = product.serialize()
        var json_obj = data_model.toJson().asObject()
        let product_info_json_str=json_obj.toJsonString()

        productLibrary.updateProduct(file_path,product_info_json_str)
        
        return true
    }
    public func updateIsSaling(productName:String,isSaling:Bool):Bool{

        let file_path="${second_dir_path}/${productName}"
        if(!File.exists(file_path)){
            return false
        }
        var product=productLibrary.getProduct(file_path)
        product.isSaling=isSaling

        var data_model = product.serialize()
        var json_obj = data_model.toJson().asObject()
        let product_info_json_str=json_obj.toJsonString()

        productLibrary.updateProduct(file_path,product_info_json_str)
        
        return true
    }
    public func deleteProduct(productName:String):Unit{
        let file_path="${second_dir_path}/${productName}"
        productLibrary.deleteProduct(file_path)
    }

}