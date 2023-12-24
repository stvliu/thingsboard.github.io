---
layout: docwithnav-trendz
assignees:
- vparomskiy
title: 自定义 Python 模型
description: 批量计算字段


python-prediction-basic-example:
  0:
    image: /images/trendz/python-predict-univariable-barview.png
    title: '创建条形图'
  1:
    image: /images/trendz/python-predict-univariable-enable.png
    title: '启用预测并选择自定义模型'
  2:
    image: /images/trendz/python-predict-univariable-sources.png
    title: '编写用于时间序列预测的 Python 代码'
  3:
    image: /images/trendz/python-predict-univariable-result.png
    title: '条形图，其中包含历史数据和未来 14 天的预测'
---


* TOC
{:toc}

您可以通过编写自定义 Python 代码将新的预测模型添加到 Trendz。此代码将在服务器端执行，并且可以访问整个输入数据集，其中包括必需的遥测和属性数据。
您可以导入必需的 Python 库并在代码中使用它们，以根据输入数据预测必需的指标。

## 启用自定义预测模型
将必需的遥测或计算字段添加到 Trendz 视图后，您可以告诉 Trendz 它应为此字段使用自定义预测模型。
为此，您需要打开“字段设置”对话框，然后在“预测方法”下拉列表中选择“自定义”选项：

## 定义输入数据集
默认情况下，输入数据集中只有原始遥测数据。但是，您可以通过在“用于预测的选定字段”部分中选择它们，将其他遥测和属性添加到输入数据集中。
只需开始键入遥测或属性的名称，然后从下拉列表中选择必需的字段。

## 基本单变量 Python 模型示例
在此示例中，我们将展示如何根据历史数据预测用水量。

* 在 Trendz 中创建条形图视图
* 将“日期”字段添加到 X 轴部分
* 将“消耗”遥测添加到 Y 轴部分
* 将“传感器”设备名称添加到筛选部分并选择必需的设备
* 启用“预测”复选框，然后在“预测方法”下拉列表中选择“自定义”选项
* 将预测时间范围设置为未来 14 天
* 将以下代码写入“模型函数”部分：

```python
import pandas as pd
from prophet import Prophet

print(f"inputX: {inputX}")
print(f"inputY: {inputY}")
print(f"outputX: {outputX}")

df = pd.DataFrame()
df['ds'] = pd.to_datetime(inputX, unit='ms')
df['y'] = inputY

model = Prophet()
model.fit(df)

future = pd.DataFrame()
future['ds'] = pd.to_datetime(outputX, unit='ms')

forecast = model.predict(future)
outputY = forecast['yhat'].tolist()
print(f"result: {outputY}")
return outputY
```

现在，您可以构建视图以查看预测模型的结果。

{% include images-gallery.html imageCollection="python-prediction-basic-example" %}


## 多变量 Python 模型示例
在此示例中，我们将展示如何根据历史消耗量和环境温度预测热量消耗量。

* 在 Trendz 中创建条形图视图
* 将“日期”字段添加到 X 轴部分
* 将“消耗”遥测添加到 Y 轴部分
* 将“传感器”设备名称添加到筛选部分并选择必需的设备
* 启用“预测”复选框，然后在“预测方法”下拉列表中选择“自定义”选项
* 将预测时间范围设置为未来 14 天
* 将“温度”字段添加到**用于预测的选定字段**
* 将以下代码写入“模型函数”部分：

```python
import pandas as pd
import numpy as np
from prophet import Prophet

futureRegressors = []
regressorsCount = len(historyRegressors)

for i in range(0, regressorsCount):
	regressorInputX = inputX
	regressorOutputX = outputX
	regressorInputY = historyRegressors[i]
	regressorOutputY = []

	df = pd.DataFrame()
	df['ds'] = pd.to_datetime(regressorInputX, unit='ms')
	df['y'] = regressorInputY

	model = Prophet()
	model.fit(df)

	future = pd.DataFrame()
	future['ds'] = pd.to_datetime(regressorOutputX, unit='ms')

	forecast = model.predict(future)
	regressorOutputY = forecast['yhat'].tolist()
	futureRegressors.append(regressorOutputY)


for i in range(0, regressorsCount):
	print(f"historyRegressors{i} = {historyRegressors[i]}")
for i in range(0, regressorsCount):
	print(f"futureRegressors{i} = {futureRegressors[i]}")

print(f"inputX: {inputX}")
print(f"inputY: {inputY}")
print(f"outputX: {outputX}")

df = pd.DataFrame()
df['ds'] = pd.to_datetime(inputX, unit='ms')
df['y'] = np.array(inputY)
for i in range(0, regressorsCount):
	df['regressor' + str(i)] = np.array(historyRegressors[i]) 

model = Prophet()
for i in range(0, regressorsCount):
	model.add_regressor('regressor' + str(i), standardize=False) 
model.fit(df)

future = pd.DataFrame()
future['ds'] = pd.to_datetime(outputX, unit='ms')
for i in range(0, regressorsCount):
	future['regressor' + str(i)] = np.array(futureRegressors[i])

forecast = model.predict(future)
outputY = forecast['yhat'].tolist()
print(f"result: {outputY}")
return outputY
```

## 后续步骤

{% assign currentGuide = "CalculatedFields" %}{% include templates/trndz-guides-banner.md %}