package CangjieShopCore.services_impl

import CangjieShopCore.services.*
import std.random.*

public class UuidGenerationService <: IUuidGenerationService{

    private let randomService:IRandomService=RandomService()
    public func getUuid():String{
        let m: Random = Random()
        m.seed = randomService.getUserRandomSeed()
        var i:UInt64=1
        var length:UInt64=16
        var uuid:String=""
        while(i<=length){
            let temp=m.next(64) % 10
            uuid=uuid+temp.toString()
            if(i%4==0 && i!=length){
                uuid=uuid+"-"
            }
            i++
        }
    
        return uuid
    }
    public func getProductUuid():String{
        let m: Random = Random()
        m.seed = randomService.getProductRandomSeed()
        var i:UInt64=1
        var length:UInt64=16
        var uuid:String=""
        while(i<=length){
            let temp=m.next(64) % 10
            uuid=uuid+temp.toString()
            if(i%4==0 && i!=length){
                uuid=uuid+"-"
            }
            i++
        }
    
        return uuid
    }
    
    public func getOrderUuid():String{
        let m: Random = Random()
        m.seed = randomService.getOrderRandomSeed()
        var i:UInt64=1
        var length:UInt64=16
        var uuid:String=""
        while(i<=length){
            let temp=m.next(64) % 10
            uuid=uuid+temp.toString()
            if(i%4==0 && i!=length){
                uuid=uuid+"-"
            }
            i++
        }
    
        return uuid
    }

    public func getOrderItemUuid():String{
        let m: Random = Random()
        m.seed = 5
        var i:UInt64=1
        var length:UInt64=16
        var uuid:String=""
        while(i<=length){
            let temp=m.next(64) % 10
            uuid=uuid+temp.toString()
            if(i%4==0 && i!=length){
                uuid=uuid+"-"
            }
            i++
        }
    
        return uuid
    }

}