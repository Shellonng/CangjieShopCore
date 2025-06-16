package CangjieShopCore.services

import CangjieShopCore.models.*

public interface IOrderService{
    func createOrder(order:Order,username:String):Bool
    func addOrder(username:String,orderItem:OrderItem):Float64
    func pay(username:String):Float64
}