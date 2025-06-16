package CangjieShopCore.view_model

import CangjieShopCore.services.*
import CangjieShopCore.services_impl.*
import CangjieShopCore.models.*

public class ProductViewModel{

    private let productService:IProductService=ProductServiceImpl()
    private let uuidService:IUuidGenerationService=UuidGenerationService()
    public func createProduct(name:String,price:Float64,desc:String,stock:Int64,isSaling:Bool):Bool{
        if(name.isEmpty() || price<0.0){
            return false
        }
        let uuid=uuidService.getProductUuid()
        var product=Product()

        product.productId=uuid
        product.productName=name
        product.price=price
        product.desc=desc
        product.stock=stock
        product.isSaling=isSaling

        let res=productService.createProduct(product)

        return res
    }

    public func deductionOfStock(productName:String,num:Int64):Int64{
        if(productName.isEmpty() || num<=0){
            throw Exception("参数有误，请检查")
        }
        let res=productService.updateStock(productName,num,false)
        if(res<0){
            throw Exception("内部错误")
        }
        return res
    }
    public func deductionOfStockByOne(productName:String):Int64{
        if(productName.isEmpty()){
            throw Exception("参数有误，请检查")
        }
        let res=productService.updateStock(productName,1,false)
        if(res<0){
            throw Exception("内部错误")
        }
        return res
    }
    public func incrStock(productName:String,num:Int64):Int64{

        if(productName.isEmpty() || num<=0){
            throw Exception("参数有误，请检查")
        }
        let res=productService.updateStock(productName,num,true)
        if(res<0){
            throw Exception("内部错误")
        }
        return res
    }
    public func getStock(productName:String):Int64{

        return productService.getStock(productName)
    }
    public func updatePrice(productName:String,newPrice:Float64):Bool{
        let res=productService.updatePrice(productName,newPrice)
        return res
    }
    public func updateIsSaling(productName:String,isSaling:Bool):Bool{
        let res=productService.updateIsSaling(productName,isSaling)
        return res
    }
    public func deleteProduct(productName:String):Unit{
        productService.deleteProduct(productName)
    }
}