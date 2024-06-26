## 参考

+ 图解机器学习 | KNN算法及其应用: https://www.showmeai.tech/article-detail/187

## 机器学习与分类问题

### 分类问题

**分类问题是机器学习非常重要的一个组成部分，它的目标是根据已知样本的某些特征，判断一个样本属于哪个类别**。分类问题可以细分如下：

![df822670920345e2ccf76a6e68db3df0](/Users/vjf/Projects/github/learning-my-note/ai/machine-learning/img/df822670920345e2ccf76a6e68db3df0.png)

- **二分类问题**：表示分类任务中有两个类别新的样本属于哪种已知的样本类。
- **多类分类**（Multiclass classification）问题：表示分类任务中有多类别。
- **多标签分类**（Multilabel classification）问题：给每个样本一系列的目标标签。

### 分类问题的数学抽象

**从算法的角度解决一个分类问题，我们的训练数据会被映射成 n 维空间的样本点（这里的 n 就是特征维度），我们需要做的事情是对 n 维样本空间的点进行类别区分，某些点会归属到某个类别**。

下图所示的是二维平面中的两类样本点，我们的模型（分类器）在学习一种区分不同类别的方法，比如这里是使用一条直线去对两类不同的样本点进行切分。

![ae00c159398a7bcf9a02aed46273bc69](/Users/vjf/Projects/github/learning-my-note/ai/machine-learning/img/ae00c159398a7bcf9a02aed46273bc69.png)

常见的分类问题应用场景很多，我们选择几个进行举例说明：

- **垃圾邮件识别**：可以作为二分类问题，将邮件分为你「垃圾邮件」或者「正常邮件」。
- **图像内容识别**：因为图像的内容种类不止一个，图像内容可能是猫、狗、人等等，因此是多类分类问题。
- **文本情感分析**：既可以作为二分类问题，将情感分为褒贬两种，还可以作为多类分类问题，将情感种类扩展，比如分为：十分消极、消极、积极、十分积极等。

## K近邻算法核心思想

在模式识别领域中，K近邻算法（ KNN 算法，又译 K-最近邻算法）是一种用于分类和回归的非参数统计方法。在这两种情况下，输入包含特征空间中的 K 个最接近的训练样本。

### K近邻核心思想

在 KNN 分类中，输出是一个分类族群。**一个对象的分类是由其邻居的「多数表决」确定的**，K 个最近邻居（ K 为正整数，通常较小）中最常见的分类决定了赋予该对象的类别。

- 若 K=1，则该对象的类别直接由最近的一个节点赋予。

> 在 KNN 回归中，输出是该对象的属性值。该值是其 K 个最近邻居的值的平均值。

![447dea20bf77dd257d0b4d430e340d49](/Users/vjf/Projects/github/learning-my-note/ai/machine-learning/img/447dea20bf77dd257d0b4d430e340d49.png)

**K 近邻居法采用向量空间模型来分类，概念为相同类别的案例，彼此的相似度高**。而可以借由计算与已知类别案例之相似度，来评估未知类别案例可能的分类。KNN 是一种基于实例的学习，或者是局部近似和将所有计算推迟到分类之后的惰性学习。 K- 近邻算法是所有的机器学习算法中最简单的之一。

**最近邻算法的定义**：为了判定未知样本的类别，以全部训练样本作为代表点计算未知样本与所有训练样本的距离，并以最近邻者的类别作为决策未知样本类别的唯一依据。

**最近邻算法的缺陷是对噪声数据过于敏感**。如果一个圈起来的蓝点和两个圈起来的红点到绿点的距离是相等的，根据最近邻算法，该点的形状无法判断。

为了解决这个问题，我们可以把位置样本周边的多个最近样本计算在内，扩大参与决策的样本量，以避免个别数据直接决定决策结果。

![d53bc7a46f0da0789bf4c49132a0e8d3](/Users/vjf/Projects/github/learning-my-note/ai/machine-learning/img/d53bc7a46f0da0789bf4c49132a0e8d3.png)

于是, 这就产生了 **K- 近邻算法的定义**: 选择未知样本一定范围内确定个数的 K 个样本，该 K 个样本大多数属于某一类型，则未知样本判定为该类型。

> 根据 K 近邻算法，离绿点最近的三个点中有两个是红点，一个是蓝点，红点的样本数量多于蓝点的样本数量，因此绿点的类别被判定为红点。

## K近邻算法步骤与示例

首先为大家梳理下 K 近邻算法的步骤，之后通过示例为大家展示 K 近邻算法的计算流程。

![0881a71e482f90f207560ba98fc2669d](/Users/vjf/Projects/github/learning-my-note/ai/machine-learning/img/0881a71e482f90f207560ba98fc2669d.png)

### K近邻算法工作原理

- 存在一个样本数据集合，也称作训练样本集，并且样本集中每个数据都存在标签，即我们知道样本集中每个数据与所属分类的对应关系。
- 输入没有标签的新数据后，将新数据的每个特征与样本集中数据对应的特征进行比较，然后算法提取样本集中特征最相似数据（最近邻）的分类标签。
- **一般来说，只选择样本数据集中前 N) 个最相似的数据。 K 一般不大于 20)** ，最后，选择 K 个中出现次数最多的分类，作为新数据的分类。

### K近邻算法参数选择

- **一个最佳的 K 值取决于数据**。一般情况下，在分类时较大的 K 值能够减小噪声的影响，但会使类别之间的界限变得模糊。一个较好的 K 值能通过各种启发式技术（见超参数优化）来获取。
- 噪声和非相关性特征的存在，或特征尺度与它们的重要性不一致会使 K 近邻算法的准确性严重降低。一个普遍的做法是**利用进化算法优化功能扩展**，还有一种较普遍的方法是**利用训练样本的互信息进行选择特征**。
- 在二元（两类）分类问题中，选**取 K 为奇数有助于避免两个分类平票的情形**。在此问题下，选取最佳经验 K 值的方法是自助法。

> 说明： KNN 没有显示的训练过程，它是「懒惰学习」的代表，它在训练阶段只是把数据保存下来，训练时间开销为 0)，等收到测试样本后进行处理。

## K近邻算法的缺点与改进

### K近邻算法的优缺点

不同类别的样本点，分布在空间的不同区域。 K) 近邻是基于空间距离较近的样本类别来进行分类，本质上是对于特征空间的划分。

![30c992f10782a706148662ab30df02ef](/Users/vjf/Projects/github/learning-my-note/ai/machine-learning/img/30c992f10782a706148662ab30df02ef.png)

- **优点**：精度高、对异常值不敏感、无数据输入假定。
- **缺点**：计算复杂度高、空间复杂度高。
- **适用数据范围**：数值型和标称型。

### K近邻算法的核心要素：距离度量准则

近邻算法能通过一种有效的方式隐含地来计算决策边界, 它也可以显式的计算决策边界，使得计算复杂度(算法执行所需的时间或空间与输入数据大小之间的关系)是边界复杂度的函数, 这意味着算法的性能（速度、资源消耗等）直接受到问题的边界条件或约束的影响。例如，在最近邻搜索中，如果我们使用特定的数据结构如KD树或球树，这些结构可以帮助算法更快地找到点的最近邻，特别是在数据的维度较低时。在这种情况下，算法的效率和复杂度可以明显受到数据分布和维度的影响，即是“边界复杂度的函数”。

K) **近邻算法依赖于空间中相近的点做类别判断，判断距离远近的度量标准非常重要**。距离的度量标准，对很多算法来说都是核心要素（比如无监督学习的 [**聚类算法**](https://www.showmeai.tech/article-detail/197) 也很大程度依赖距离度量），也对其结果有很大的影响。

![1b71a3b48aedb12ef63f943ce0ad6dc1](/Users/vjf/Projects/github/learning-my-note/ai/machine-learning/img/1b71a3b48aedb12ef63f943ce0ad6dc1.png)

Lp) **距离**（**又称闵可夫斯基距离，Minkowski Distance**）不是一种距离，而是**一组距离**的定义。

- 参数 p%3D1) 时为**曼哈顿距离**（又称**L1距离**或**程式区块距离**），表示两个点在标准坐标系上的绝对轴距之和。
- 参数 p%3D2) 时为**欧氏距离**（又称**L2距离**或**欧几里得度量**），是直线距离常见的两点之间或多点之间的距离表示法。
- 参数 p%20%5Cto%20%5Cinfty) 时，就是**切比雪夫距离**（各坐标数值差的最大值）。

### K近邻算法的核心要素：K的大小

对于 KNN 算法而言，K) 的大小取值也至关重要，

+ 如果选择较小的 K) 值，意味着整体模型变得复杂（模型容易发生过拟合），模型学习的近似误差（approximation error）会减小，但估计误差（estimation error）会增大。
+ 如果选择较大的 K) 值，就意味着整体的模型变得简单，减少学习的估计误差，但缺点是学习的近似误差会增大。

在实际的应用中，一般采用一个比较小的 K) 值。并采用交叉验证的方法，选取一个最优的 K) 值。

> 理解: 
>
> 1. **模型复杂度与 𝐾 值的关系**：
>   - K 个最近邻居（ K 为正整数，通常较小）中最常见的分类决定了赋予该对象的类别。若 K=1，则该对象的类别直接由最近的一个节点赋予。
>    - 当 𝐾 值较小，比如 𝐾=1，模型非常依赖于每一个邻近点，这意味着算法会尽可能精确地适应训练数据中的每一个样本点。这种情况下，模型的决策边界（decision boundary）会非常复杂，可能会出现很多锯齿或者曲线来捕捉数据中的每一个细微变化。
>    - 因为 𝐾 值小，模型在训练数据上的表现可能会非常好，因为它可以捕捉数据中的每个小波动和特点。
> 2. **近似误差（Approximation Error）**：
>    - 近似误差是指模型对于问题本质的拟合能力。当 𝐾 值较小，模型试图通过捕获训练数据中的每个小的特征和波动来拟合数据，从而使得近似误差很小。
>    - 这是因为模型几乎完美地拟合了训练数据，但这种拟合程度可能是过度的（过拟合）。
> 3. **估计误差（Estimation Error）**：
>    - 估计误差是指模型在新数据上的表现能力，也就是模型的泛化能力。当 𝐾 值较小, 估计误差会偏大，模型虽然在训练集上表现得很好，但可能在未知的测试数据上表现不佳。
>    - 这是因为当 𝐾 值小，模型更可能捕捉到训练数据中的噪声而非真实的、普遍的数据趋势。这会导致模型在面对新数据时，其预测能力下降，从而估计误差增大。

### K近邻算法的缺点与改进

#### （1）缺点

观察下面的例子，我们看到，对于样本 X)，通过 KNN 算法，我们显然可以得到 X) 应属于红色类别。但对于样本 Y)，从距离上看 Y) 和红色的批次样本点更接近, 但是 KNN 算法判定的结果是 Y) 应属于蓝色类别，因为蓝色的样本数量更多, 权重更大。因此，**原始的 KNN 算法只考虑近邻不同类别的样本数量，而忽略掉了距离。**

![286aa9838967b91159e4516e89a49d8d](/Users/vjf/Projects/github/learning-my-note/ai/machine-learning/img/286aa9838967b91159e4516e89a49d8d.png)

除了上述缺点，KNN 还存在如下缺点：

- **对样本库容量依赖性较强, 导致 KNN 算法在实际应用中的限制较大**：有不少类别无法提供足够的训练样本，使得 KNN 算法所需要的相对均匀的特征空间条件无法得到满足，使得识别的误差较大。
- **K) 值的确定**： KNN 算法必须指定 K) 值，K) 值选择不当则分类精度不能保证。
- 计算复杂度高、空间复杂度高。

#### （2）改进方法

![6d0c30cbad46dbfb37963dd0fd2229e6](/Users/vjf/Projects/github/learning-my-note/ai/machine-learning/img/6d0c30cbad46dbfb37963dd0fd2229e6.png)

1. 对训练样本库进行维护

- 通过将符合某种条件的样本可以加入数据库中，同时对数据库库中已有符合某种条件的样本进行删除, 从而保证训练样本库中的样本**提供 KNN 算法所需要的相对均匀的特征空间**。

2. 加快 KNN 算法的分类速度

- 浓缩训练样本: 当训练样本集中样本数量较大时，从原始训练样本集中**选择最优的参考子集进行 K) 近邻寻找**，从而减少训练样本的存储量和提高计算效率。
- 通过**快速搜索算法**，在较短时间内找到待分类样本的 K) 个最近邻。

## 实战

假如一套房子打算出租，但不知道市场价格，可以根据房子的规格（面积、房间数量、厕所数量、容纳人数等），在已有数据集中查找相似（K近邻）规格的房子价格，看别人的相同或相似户型租了多少钱。