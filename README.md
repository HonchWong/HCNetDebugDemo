# HCNetDebugDemo

## 概述
这个Demo 是可视化设置Mock，可以分成两部分去理解这个Demo的功能，分别是Mock能力和可视化设置。
 - Mock网络数据的能力是用的GYHttpMock_HC [https://github.com/HonchWong/GYHttpMock_HC](https://github.com/HonchWong/GYHttpMock_HC) ，下面会列举Mock的使用方式。
 - 提供了两个页面去进行可视化设置，具体可以看Demo或下面的Gif图。

## GYHttpMock_HC 提供的Mock方式

GYHttpMock_HC 提供了三种Mock数据的方式，下面提供使用示例和时序图

- 方式1：返回本地数据，数据来自本地json文件或代码生成的json字符串 ``

```objc
mockRequest(@"GET", @"http://www.google.com").andReturn(200).withBody(@"google.json");
```

- 方式2：修改网络回来的json，如增加字段 `mockRequest(@"GET", @"http://www.google.com");`

```objc
mockRequest(@"POST", @"http://www.google.com").
isUpdatePartResponseBody(YES).
withBody(@"{\"name\":\"abc\"}".regex);
andReturn(200).
withBody(@"google.json");
```

- 方式3：使用另一个网络请求返回的response来mock数据

```objc
mockRequest(@"GET", http://www.google.com).
isUseNetJsonResponse(YES).
andReturn(200).
withBody(@"{\"replaceURL\":\ohterurl\"}");
```

![时序图](http://m.qpic.cn/psb?/V10JaO4w40EHz4/Rr2Xq1p5g3ZN82Bh*0sezyTSpNQpSFjI6CJLhq5cCBw!/b/dC4BAAAAAAAA&bo=YAIeAwAAAAADB10!&rf=viewer_4)


## 可视化设置Mock规则

### Mock规则
一个URL 都对应五种Mock类型，每种Mock类型可以有多个Mock规则。一个URL和一个Mock规则一一对应。

五种Mock类型按照返回数据的类型进行区分，分别是 
- 错误返回
- 空返回
- 增加response中的字段
- 使用本地json作为response返回
- 使用另一个请求的response返回数据

用图表示就是：

![mock策略](http://m.qpic.cn/psb?/V10JaO4w40EHz4/*TuvFOzK5zB1rHAa4EdQHem55cT2cnbvs0EkPlSg398!/b/dLYAAAAAAAAA&bo=wQMeAwAAAAADB*0!&rf=viewer_4)

### 应用场景
错误返回、空返回、使用另一个请求的response返回数据 这三种Mock类型应该是比较常用的。

- 其中错误返回和空返回可以用来调试业务的容错场景
- 使用最高频的应该是“使用另一个请求的response返回数据”，比如，某个页面有这样的需求，该页面针对不同的用户身份有不同的展示规则，每周日晚八点还固定会展示某个活动按钮，一共有七八种样式，都是依赖网络数据进行展示的，如果有个按钮去选择返回场景A的数据或场景B的数据，而不用在代码里修改再编译或使用代理软件，岂不是很方便？“使用另一个请求的response返回数据”这个Mock类型正好解决这个问题。

在开发的时候和服务端约定好了协议，可以在公司的协议管理平台列举好一个协议都有多少种返回，如果公司没协议管理平台，我推荐这个开源的协议管理平台 [https://www.easy-mock.com/](https://www.easy-mock.com/)

![http://m.qpic.cn/psb?/V10JaO4w40EHz4/aLPsXo9Kq.f*FdXUiWBUaIDNeYk74tuVOACz1XCwMIE!/b/dL8AAAAAAAAA&bo=JQSbAgAAAAADB5o!&rf=viewer_4](http://m.qpic.cn/psb?/V10JaO4w40EHz4/aLPsXo9Kq.f*FdXUiWBUaIDNeYk74tuVOACz1XCwMIE!/b/dL8AAAAAAAAA&bo=JQSbAgAAAAADB5o!&rf=viewer_4)

同一个协议不同的场景数据，用平台管理还有另一个优点就是方便多人协作，而不是放在App端内作为本地数据，只能自己用。

数据源有了，再看一下切换数据的“按钮”

## UI 展示

gift图中，调试页面有三个按钮“TestBookList”、“Mock网络数据”、“FLEX”

- “TestBookList”：点击按钮发起网络请求，URL是：https://www.easy-mock.com/mock/5b877ba37eb5e51ccf7d4db1/example/testBookList
- “FLEX”： 点击按钮展示用来抓包的工具
- “Mock网络数据”： 点击按钮展示Mock设置的界面

gift图的操作展示了，点击“Mock网络数据” 设置 【 https://www.easy-mock.com/mock/5b877ba37eb5e51ccf7d4db1/example/testBookList 】的Mock规则，规则是使用另一个请求的response返回数据，通过FLEX抓包查看，Mock成功

![gift图](https://github.com/HonchWong/imageSrc/blob/master/gif/teseNetMock.gif?raw=true)

## 完成进度

这个Demo的功能，分别是Mock能力和可视化设置。Mock能力已经完成了。可视化设置只完成了，设置针对URL指定Mock规则“使用另一个请求的response返回数据”。

待完成的点有：
- 可视化设置所有的Mock规则
- Mock规则存储到服务器上，服务器提供获取、修改Mock规则的API

