package CangjieShopCore.test

//test
import std.unittest.*
import std.unittest.testmacro.*
import std.fs.*

import CangjieShopCore.view_model.*
import CangjieShopCore.models.*

@Test
public class UserViewModelTest{

    private let TestUser1="测试用户1"
    private let TestUser2="测试用户2"
    private let TestUser3="测试用户3"


    @AfterAll
    public func reset(){
        File.delete("./data/user/${TestUser1}")
        File.delete("./data/user/${TestUser2}")
        File.delete("./data/user/${TestUser3}")

    }




    @TestCase
    public func test_create_user_sucess(){
        let userViewModel=UserViewModel()
        let username=TestUser1
        let pwd="123456"
        let address="辽宁省沈阳市"
        userViewModel.createUser(username,pwd,address)
        let res=File.exists("./data/user/${username}")
        @Expect(res,true)
    }
    @TestCase
    public func test_get_user_uuid_sucess(){
        let userViewModel=UserViewModel()
        let username=TestUser2
        let pwd="123456"
        let address="辽宁省沈阳市"
        
        @Assert(!File.exists("./data/user/${username}"))
        userViewModel.createUser(username,pwd,address)
        @Assert(File.exists("./data/user/${username}"))

        let res=userViewModel.getUserIdentify(username)
        @Expect(res.size,19)
    }

    @TestCase
    public func test_get_user_address_success(){
        let userViewModel=UserViewModel()
        let username=TestUser3
        let pwd="123456"
        let address="辽宁省大连市"
        
        @Assert(!File.exists("./data/user/${username}"))
        userViewModel.createUser(username,pwd,address)
        @Assert(File.exists("./data/user/${username}"))

        let res=userViewModel.getUserAddress(username)
        @Expect(res,address)
    }


}