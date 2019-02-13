# HCNetDebugDemo

## 概述
这个Demo 是可视化设置Mock，Mock网络数据的能力是用的GYHttpMock_HC [https://github.com/HonchWong/GYHttpMock_HC](https://github.com/HonchWong/GYHttpMock_HC) ，基于GYHttpMock_HC 添加了UI 进行可视化操作。

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


## 的功能展示



## 可视化设置Mock的功能规划

一个URL 都对应五种Mock类型，每种Mock类型可以有多个Mock规则。一个URL和一个Mock规则一一对应。

五种Mock类型按照返回数据的类型进行区分，分别是 错误返回、空返回、增加response中的字段

