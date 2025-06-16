package CangjieShopCore.services

public interface IRandomService{
    func getUserRandomSeed():UInt64
    func getProductRandomSeed():UInt64
    func getOrderRandomSeed():UInt64
}