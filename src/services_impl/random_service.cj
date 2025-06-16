package CangjieShopCore.services_impl

import CangjieShopCore.services.*

import std.fs.*
import std.io.*
import std.convert.*

public class RandomService <:IRandomService{
    private let first_dir_path="./data"
    private let second_dir_path="${first_dir_path}/random"

    private let user_path="${second_dir_path}/user"
    private let product_path="${second_dir_path}/product"
    private let order_path="${second_dir_path}/order"



    public RandomService(){
        if(!Directory.exists(second_dir_path)){
            if(!Directory.exists(first_dir_path)){
                Directory.create(first_dir_path)
            }
            Directory.create(second_dir_path)
        }
        if(!File.exists(user_path)){
            try(file=File.create(user_path), fileWriter=StringWriter(file)){
                fileWriter.write(1)
            }
        }
        if(!File.exists(product_path)){
            try(file=File.create(product_path), fileWriter=StringWriter(file)){
                fileWriter.write(100)
            }
        }
        if(!File.exists(order_path)){
            try(file=File.create(order_path), fileWriter=StringWriter(file)){
                fileWriter.write(10000)
            }
        }

    }

    public func getUserRandomSeed():UInt64{
        var res:UInt64=0
        try(file=File.openRead(user_path), fileRead=StringReader(file)){
            let temp=fileRead.readToEnd()
            res=UInt64.parse(temp)
        }
        try(file = File(user_path, OpenOption.CreateOrTruncate(true)), fileWriter=StringWriter(file)){
            fileWriter.write(res+1)
        }
        return res
    }
    public func getProductRandomSeed():UInt64{
        var res:UInt64=0
        try(file=File.openRead(product_path), fileRead=StringReader(file)){
            let temp=fileRead.readToEnd()
            res=UInt64.parse(temp)
        }
        try(file = File(product_path, OpenOption.CreateOrTruncate(true)), fileWriter=StringWriter(file)){
            fileWriter.write(res+1)
        }
        return res
    }
    public func getOrderRandomSeed():UInt64{
        var res:UInt64=0
        try(file=File.openRead(order_path), fileRead=StringReader(file)){
            let temp=fileRead.readToEnd()
            res=UInt64.parse(temp)
        }
        try(file = File(order_path, OpenOption.CreateOrTruncate(true)), fileWriter=StringWriter(file)){
            fileWriter.write(res+1)
        }
        return res
    }
}