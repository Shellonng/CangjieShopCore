package CangjieShopCore.services_impl

import CangjieShopCore.services.*
import CangjieShopCore.models.*
import CangjieShopCore.library.*

import std.fs.*
import std.io.*
import serialization.serialization.*
import encoding.json.*
import std.convert.*


public class OrderServiceImpl <:IOrderService{
    private let first_dir_path="./data"
    private let second_dir_path="${first_dir_path}/order"


    private let orderLibrary:OrderLibrary=OrderLibrary()
    public func createOrder(order:Order,username:String):Bool{
        if(!Directory.exists(second_dir_path)){
            if(!Directory.exists(first_dir_path)){
                Directory.create(first_dir_path)
            }
            Directory.create(second_dir_path)
        }
        let file_path="${second_dir_path}/${username}"

        var data_model = order.serialize()
        var json_obj = data_model.toJson().asObject()
        let order_info_json_str=json_obj.toJsonString()

        let res=orderLibrary.writeToFile(file_path,order_info_json_str)
        return res
    }

    public func addOrder(username:String,orderItem:OrderItem):Float64{
        let file_path="${second_dir_path}/${username}"

        var product=orderLibrary.getOrder(file_path)
        let sub_total=Float64.parse("${orderItem.number}")*orderItem.unitPrice
        let total=sub_total+product.total
        product.orderItems.append(orderItem)
        product.total=total

        var data_model = product.serialize()
        var json_obj = data_model.toJson().asObject()
        let product_info_json_str=json_obj.toJsonString()

        orderLibrary.addOrder(file_path,product_info_json_str)
        
        return total
    }
    public  func pay(username:String):Float64{
        let file_path="${second_dir_path}/${username}"
        

        var order=orderLibrary.getOrder(file_path)
        if(order.isPayment){
            throw Exception("该订单已支付")
        }

        let new_file_path="${second_dir_path}/${order.userId}"
        order.isPayment=true

        var data_model = order.serialize()
        var json_obj = data_model.toJson().asObject()
        let order_info_json_str=json_obj.toJsonString()

        orderLibrary.payOrder(file_path,order_info_json_str,new_file_path)
        

        return order.total
    }
}