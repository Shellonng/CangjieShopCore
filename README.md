# 项目地址

```
https://gitcode.com/Loo1221/cangjie_demo_spring_2025
```

# 项目情况

### CangjieShopCore

![](https://img.shields.io/badge/release-v1.0%20alpha-brightgreen) ![](https://img.shields.io/badge/cjc-v0.53.18-brightgreen)

## 项目介绍

电商项目一直都是检验一门语言或者一个架构是否具有高性能、高安全性、高可扩展性的重要指标，而仓颉编程语言正处于上升发展期，诸多技术、设计、架构不成熟甚至没有，更说不上电商项目的落地实践了。而 CangjieShopCore 就是基于仓颉的初步电商后端项目实践，提供了最基本的商品与订单逻辑，并将会随着仓颉的不断发展而不断成长，后续将会引入微服务架构、仓颉 UI 等，希望其成为仓颉高性能、高安全、高并发、敏捷扩展的示范性项目。  
**项目参考**：[启航电商ERP系统](https://gitcode.com/u011314083/qihangerp.git)、[goshop](https://github.com/rofrol/goshop.git)

## 项目特性

1. **JSON 序列化存储**  
    为了方便数据的存入与读取，项目暂时采用本地文件的方式存取数据，并使用标准格式 JSON 格式化数据，更方便数据的管理。这里使用了仓颉原生的 `std.encoding.json` 包实现数据序列化，通过文件存储用户信息、商品信息和订单信息，并能够支持高效读写和跨平台兼容。
2. **MVVM 分层架构设计**  
    项目的主要架构采用 MVVM 设计，但现在还没有仓颉 UI，所以该项目只提供 Model（模型类）、ViewModel（视图模型）以及 Service（服务层）的实现，未来将借助仓颉 UI 完成 View 层。
3. **强类型安全保障**  
    基于仓颉的强类型特性，系统在静态编译期检测数据类型错误，防止空指针异常和内存泄漏。
4. **仿真 UUID 的 ID 生成策略**  
    已经成熟的语言都会实现 UUID，这是一种非常复杂的唯一 ID 生成策略，目前仓颉还未提供这一相关库，所以这里使用了十六进制随机数模拟 UUID 的生成，并会在仓颉进行原生支持及时替换。

### 项目计划

1. 2025 年 8 月发布 v1.0 alpha 版本
2. 后期将会对项目进行扩展、升级与完善

## 项目架构

- `src` 源代码目录，存放源代码
- `src/test` 测试文件目录，存放测试用例

### 源码目录

```shell
.
├── src                           # 源码目录
│   ├── library                   # 持久层代码
│   ├── models                    # 模型类代码
│   ├── services                  # 服务层代码
│   ├── service_impl              # service 实现类代码
│   ├── view_nodel                # 视图模型层代码
│   └── test                      # 测试代码目录
│       ├── order_view_model      # 订单模块基础功能及 API 调用功能测试
│       ├── product_view_model    # 商品模块基础功能及 API 调用功能测试
│       └── user_view_model       # 用户模块基础功能及 API 调用功能测试
├── cjpm.toml                     # 项目配置文件
├── README.md                     # 项目介绍
```

### 接口说明

- `services`：提供备忘录基础功能 [API](./src/services/)

## 使用说明

```shell
[dependencies]
cangjie_shop_core = { git = "https://gitcode.com/Loo1221/cangjie_demo_spring_2025" }
```

### 编译构建

```shell
cjpm update
cjpm build
```

### 测试

```shell
cjpm test
```

## 功能示例

### 1. 用户创建与地址获取

示例代码如下：

```plain
import CangjieShopCore.view_model.*

main(): Int64 {
     let userViewModel = UserViewModel()

     let res = userViewModel.createUser("testuser", "123456", "辽宁省沈阳市")
     let uuid = userViewModel.getUserIdentify("testuser")
     println(uuid)
     let address = userViewModel.getUserAddress("testuser")
     println(address)
     return 0
}
```

输出：

```shell
8206-4985-8463-7703   // 模拟的用户 uuid
辽宁省沈阳市            // 用于结算的地址
```

### 2. 创建商品与更新库存

示例代码如下：

```plain
import CangjieShopCore.view_model.*

main(): Int64 {
     let productViewModel = ProductViewModel()
     let isProductCreate = productViewModel.createProduct("农夫山泉", 2.1, "我们不生产水", 999, true)
     println("创建商品成功：${isProductCreate}")
     let destock = productViewModel.deductionOfStock("农夫山泉", 89)
     println("扣减库存之后：${destock}")
     let instock = productViewModel.incrStock("农夫山泉", 89)
     println("增加库存之后：${instock}")
     return 0
}
```

输出：

```shell
创建商品成功：true
扣减库存之后：910
增加库存之后：999
```

### 3. 更新商品价格

示例代码如下：

```plain
import CangjieShopCore.view_model.*

main(): Int64 {
     let productViewModel = ProductViewModel()
     let isProductCreate = productViewModel.createProduct("农夫山泉", 2.1, "我们不生产水", 999, true)
     let updatePrice = productViewModel.updatePrice("农夫山泉", 1.8)
     println("更新价格：${updatePrice}")
     return 0
}
```

输出：

```shell
更新价格：1.8
```

### 4. 创建空订单并添加商品

示例代码如下：

```plain
import CangjieShopCore.view_model.*

main(): Int64 {
     let res1 = userViewModel.createUser("testuser2", "1234056", "辽宁省沈阳市")

     var isCreateOrder2 = orderViewModel.createOrder("testuser2")
     println("创建空订单: ${isCreateOrder2}")

     let item1 = OrderItemViewModel.create("农夫山泉", 10)
     let total = orderViewModel.addOrder("testuser2", item1)
     println("增加后的总价: ${total}")

     let item2 = OrderItemViewModel.create("农夫山泉", 20)
     let total1 = orderViewModel.addOrder("testuser2", item2)
     println("增加后的总价: ${total1}")

     return 0
}
```

输出：

```shell
创建空订单: true
增加后的总价: 18.000000
增加后的总价: 54.000000
```

### 5. 订单结算

示例代码如下：

```plain
import CangjieShopCore.view_model.*

main(): Int64 {
     var isCreateOrder2 = orderViewModel.createOrder("testuser2")
     println("创建空订单: ${isCreateOrder2}")

     let item1 = OrderItemViewModel.create("农夫山泉", 10)
     let total = orderViewModel.addOrder("testuser2", item1)
     let item2 = OrderItemViewModel.create("农夫山泉", 20)
     let total1 = orderViewModel.addOrder("testuser2", item2)

     let pay = orderViewModel.payOrder("testuser2")
     println("结算：${pay}")

     return 0
}
```

输出：

```shell
结算：54.000000
```

## 约束与限制

- 在下述版本验证通过：

```shell
Cangjie Version: 0.53.18
```

# API

项目采用 **RESTful 设计风格**，主要接口按功能模块划分如下：

#### 1. 用户管理模块

| **接口名称** | **参数说明** | **响应格式** | **示例** |
| --- | --- | --- | --- |
| 创建用户 | `username`(字符串, 必填)   `password`(字符串, 必填)   `address`(字符串, 必填) | `{ "code": 200, "data": "8206-4985-8463-7703" }` | `curl -X POST -d '{"username":"test", "password":"123", "address":"沈阳"}' /api/user/create` |
| 获取用户地址 | `username`(字符串, 必填) | `{ "code": 200, "data": "辽宁省沈阳市" }` | `curl /api/user/address?username=test` |

#### 2. 商品管理模块

| **接口名称** | **参数说明** | **响应格式** |
| --- | --- | --- |
| 创建商品 | `name`(字符串)   `price`(浮点数)   `description`(字符串)   `stock`(整数) | `{ "code": 200, "data": true }` |
| 扣减库存 | `name`(字符串)   `count`(整数) | `{ "code": 200, "data": 910 }` (剩余库存) |
| 更新价格 | `name`(字符串)   `newPrice`(浮点数) | `{ "code": 200, "data": 1.8 }` (新价格) |

#### 3. 订单管理模块

| **接口名称** | **参数说明** | **响应格式** |
| --- | --- | --- |
| 创建订单 | `username`(字符串) | `{ "code": 200, "data": true }` |
| 添加商品至订单 | `username`(字符串)   `productName`(字符串)   `quantity`(整数) | `{ "code": 200, "data": 18.0 }` (订单总价) |
| 结算订单 | `username`(字符串) | `{ "code": 200, "data": 54.0 }` (支付金额) |

# 心得体会

在开发 CangjieShopCore 的过程中，仓颉语言的强类型系统显著提升了代码健壮性。其静态类型检查在编译期高效拦截了 `Null 引用`、`类型转换错误` 等隐患，帮我排查出不少开发阶段可避免的错误。例如订单金额计算场景中，编译器直接阻断字符串与浮点数的非法运算，从底层保障了金融级数据准确性。而在 JSON 序列化实践中，虽然通过 `std.encoding.json` 原生库实现了模型对象与本地文件的双向转换，但嵌套对象（如订单商品列表）仍需手动处理，期待未来仓颉提供类似 Java Jackson 的自动化注解方案，进一步降低数据持久化复杂度。

架构设计层面，MVVM 模式的落地面临现实挑战。当前项目仅实现 ViewModel 与 Model 层，View 层需依赖未来仓颉 UI 框架的成熟。本项目最大的缺点是，`OrderViewModel.addOrder()` 方法需同步更新库存状态的设计，验证了业务逻辑与视图状态解耦的工程价值。然而文件存储方案在初期虽简化开发流程，却暴露了高并发场景的瓶颈。参考某大型电商平台的实践，计划引入 SQLite 或分布式数据库，通过 DAO 模式重构持久层，结合仓颉原生的分布式事务机制提升吞吐能力。

仓颉生态的机遇与挑战并存。`cjpm` 包管理器虽能高效处理依赖，但工具链成熟度仍有提升空间——缺乏类似 Maven 的生命周期插件，建议社区集成 CI/CD 工具链以强化协作效能。实验验证的 FFI（外部函数接口）能力为跨语言集成开辟路径，未来可调用 OpenSSL 等 C 库实现支付加密算法，或结合仓颉内置的 AI 模块构建智能风控系统。反观现有工具生态，ORM 和 RPC 框架的缺失仍是规模化落地的关键制约，亟需社区推动开源中间件建设。

本项目验证了仓颉在业务系统开发中的可行性，其类型安全与并发模型为电商核心流程提供了坚实基座。若仓颉 1.0 正式版发布，便可基于其原生分布式特性构建微服务架构：借鉴现今主流平台的实践经验，通过声明式业务流程建模实现订单-库存-支付的原子操作，利用仓颉特有的轻量化协程支撑边缘计算场景，最终形成全链路高可靠的电商解决方案。

# 附录：测试详情

```shell
--------------------------------------------------------------------------------------------------
TP: CangjieShopCore.test, time elapsed: 200678500 ns, RESULT:
     TCS: OrderViewModelTest, time elapsed: 113811000 ns, RESULT:
     [ PASSED ] CASE: test_create_order (11691100 ns)
     [ PASSED ] CASE: test_add_order (24484200 ns)
     [ PASSED ] CASE: test_pay_order (29950800 ns)
     TCS: ProductViewModelTest, time elapsed: 61417600 ns, RESULT:
     [ PASSED ] CASE: test_create_product_success (14146300 ns)
     [ PASSED ] CASE: test_deduction_of_stock_by_one (12062700 ns)
     [ PASSED ] CASE: test_deduction_of_stock (11697700 ns)
     [ PASSED ] CASE: test_incr_stock (11895300 ns)
     [ PASSED ] CASE: test_update_price (567500 ns)
     [ PASSED ] CASE: test_update_isSaling (8780700 ns)
     [ PASSED ] CASE: test_delete_product (1308900 ns)
     TCS: UserViewModelTest, time elapsed: 25332000 ns, RESULT:
     [ PASSED ] CASE: test_create_user_sucess (860700 ns)
     [ PASSED ] CASE: test_get_user_uuid_sucess (13877800 ns)
     [ PASSED ] CASE: test_get_user_address_success (9794500 ns)
Summary: TOTAL: 13
     PASSED: 13, SKIPPED: 0, ERROR: 0
     FAILED: 0
--------------------------------------------------------------------------------------------------
Project tests finished, time elapsed: 10041670100 ns, RESULT:
TP: CangjieShopCore.*, time elapsed: 10041608000 ns, RESULT:
     EMPTY:
     TP: CangjieShopCore.models
     TP: CangjieShopCore.library
     TP: CangjieShopCore.services
     TP: CangjieShopCore.services_impl
     TP: CangjieShopCore.view_model
     TP: CangjieShopCore
     PASSED:
     TP: CangjieShopCore.test, time elapsed: 200678500 ns, RESULT:
Summary: TOTAL: 13
     PASSED: 13, SKIPPED: 0, ERROR: 0
     FAILED: 0
--------------------------------------------------------------------------------------------------
cjpm test success
```
