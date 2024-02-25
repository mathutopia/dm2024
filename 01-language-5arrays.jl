### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ 6e60ede1-184e-44c2-8bd9-580535ba783a
begin
using PlutoUI
include("Box.jl")
TableOfContents(title="目录")
end


# ╔═╡ 3160ac8d-0aae-43ea-a3ac-fa66991f1533
md"""
# 数组Array
为了实现高效的科学计算， 在Julia中， 实现了数组类型。 数组类型具有维度的概念(可以用`ndims`获取一个数组的维度)。 一维数组是向量，二维数据是矩阵。由于向量和矩阵有很多的操作都是跟数组通用的，下面简单介绍一下向量和矩阵的手动构造然后再转入通用的数组的介绍。

## 向量与矩阵
### 向量
向量数据分析中是非常常见的。 跟元组类似，向量也是一列数据。只不过， 向量中的元素是同一种类型。

手动构造向量非常简单， 只要用中括号(元组用的是小括号）和逗号(分号)即可。

```julia
julia> x = [1, 2, 3]
[1,2,3]

julia> x = [1;2;3]
[1,2,3]
```

"""

# ╔═╡ 6485e303-3be0-4683-95c3-68fa4cf8ef0d
[1, 2, 3]

# ╔═╡ 2d5a100b-64d9-4ee1-8ce9-edf4c431d865
[1;2;3]

# ╔═╡ be6e92bc-7cd6-494b-a5d3-2a1ed49c91b9
md"""
向量的数据类型是`Vector{元素类型}`。表示由**元素类型**构成的向量。
"""

# ╔═╡ 3c0c4a27-7ec7-4c9a-9c93-b47d1d298ccb
typeof([1, 2, 3])

# ╔═╡ b766b11c-39af-4b08-af2b-e01569bb2170
md"""
使用**collect函数**可以方便的把一个范围（range）里的所有元素提取到向量中
"""

# ╔═╡ 45d5ab62-2483-4650-9e68-2cf9e779345a
collect(1:10)

# ╔═╡ 3264b2ae-8e0c-411c-9503-b3416b4a951e
collect(range(1,10, 5))

# ╔═╡ d2c94917-6289-4938-bcf8-c4fe5d74ce37
collect(range(1,10,2))

# ╔═╡ 146c3abe-ddfb-4a59-b75e-19fdc91fa1aa
md"""
### 矩阵
矩阵也是一种常见的数据类型。 与向量相比， 矩阵是二维的， 即有行、列两个维度。还是可以使用中括号构造矩阵。 这时候， 空格分隔的元素会按行排列。
"""

# ╔═╡ 075fef83-e55b-426a-9966-0244fd64b38e
# 空格分隔的元素被排成了一行， 请注意返回结果是一个一行的矩阵， Julia中没有行向量。
[1 2 3]

# ╔═╡ 43c28d52-a352-46a3-9907-57c2e09d5333
[1 2 3; 4 5 6]

# ╔═╡ fa5f4c1f-84fb-44e0-a368-19a7886b0c2c
md"""
**数组的维度**
维度是数组特有的一个性质。 在Julia中， 天然的支持多维度的数组。那么，怎么理解维度呢？ 尤其是怎么理解一个多维数组呢？以下，提供一个直观的关于维度的理解--奇怪的图书馆。

想象一个奇怪的图书馆， 其中的书中的文字是按列先从上之下， 再从左至右排列的（这就是奇怪之处）。每一本书就是一个三维数组（对于书来说， 数组中的元素是文字，不是数字）。其中的每一页是一个矩阵。

于是， 第一个维度代表列方向（向下）， 第二个维度代表行方向， 第三个维度是厚度的方向（页数增加的方向）。第四个维度是书架上的最底层，从左到右的方向。第五个维度是书架从低到高增加的方向。 当然还可以继续增加维度， 但实际中用到第五个维度已经很难想象了。

许多数组操作函数都包含一个维度dim参数， 需要结合具体场景理解。
""" |> box

# ╔═╡ 4842c9ff-4571-4c4d-928b-9ec544d584a4
md"""
## 数据类型与构造
`AbstractArray{T,N}`是所有数组类类型的父类型。其中T表示数组的元素类型， N表示数组的维度。通常的数组类型是`Array{T,N} <: AbstractArray{T,N}`. 如果`N=1`, 表示一维数组。其类型是也可以表示为`Vector{T}`, 类似的如果`N=2`表示矩阵，其类型也可以表示为`Matrix{T}`。

有了数据类型可以非常方便的构造相应类型的数据容器。比如我们要构造包含100个元素的向量。可以用如下的方式：

```julia
x = Vector{Int32}(undef, 100);
y = Array{Int32,1}(undef, 100);
```
以上两种构造方式是等价的。大括号中的类型是一个具体类型。比如在这里是32位的整数。我们当然可以改成抽象的类型， 比如`Number`。但一般我们不用抽象类型。因为具体类型的运行效率会更高一点。这里的`undef`是一个特殊的常量, 表示未初始化。

对于向量来说， 还可以用  **类型[]**的方式构造某种类型的向量, 但不能同时指定长度（这时候可以使用push!, append!添加元素）。比如下面构造的是一个32位整数构成的向量。但向量的长度不知道。

```julia
x = Int32[];
``` 
构造矩阵也是类似的方式，可以使用`Matrix{T}(undef, m, n)`，或者`Array{T,2}(undef, m, n)`构造元素类型为t的m行n列的矩阵。

""" 

# ╔═╡ 8c0becc4-dae6-4aca-b232-e0482376903d
md"""
## 特殊数组构造
上面用未初始化的类型去构造的数组，需要在后续编程过程当中去填充所有的元素。有时候我们希望数组是已经初始化为某种类型的元素。下面是一些特殊的构造方法。

我们可以通过`zeros`和`ones`函数构造元素全是0或1的数组。元素类型可以指定，如果没有指定的话，默认为Float64。 dims用于指定数组的维度及其每个维度的元素个数。它可以是一个元组, 也可以是多个数字。
```julia
zeros([T=Float64,] dims::Tuple)
zeros([T=Float64,] dims...)
ones([T=Float64,] dims::Tuple)
ones([T=Float64,] dims...)
```
下面是一些例子。
```julia
julia> zeros(1)
1-element Vector{Float64}:
 0.0

julia> zeros(Int8, 2, 3)
2×3 Matrix{Int8}:
 0  0  0
 0  0  0

julia> ones(1,2)
1×2 Matrix{Float64}:
 1.0  1.0

julia> ones(ComplexF64, 2, 3)
2×3 Matrix{ComplexF64}:
 1.0+0.0im  1.0+0.0im  1.0+0.0im
 1.0+0.0im  1.0+0.0im  1.0+0.0im
```
"""

# ╔═╡ 4b33c26f-222a-4477-a85e-8363727d6636
md"""
如果是想初始化为不同于0、1的值，这时候需要使用fill函数。这个函数的作用是将数组元素填充为给定的值。类似的指定维度也可以使用两种不同的方式。
```julia
fill(value, dims::Tuple)
fill(value, dims...)
```
下面是1个例子:

```julia
julia> fill(1.0, (2,3))
2×3 Matrix{Float64}:
 1.0  1.0  1.0
 1.0  1.0  1.0
```
"""

# ╔═╡ 8e9daf50-296f-492e-991f-44c1a002e5e4
md"""
此外， 有时候， 我们常常需要构造随机数组， 这可以通过下列方法实现：

- rand: 可以通过给定维度长度构造（0,1）间的随机数数组， 例如：rand(m, n)构造m*n的随机矩阵。-
- randn: 可以通过给定维度长度构造符合正态分布的随机数数组
"""

# ╔═╡ 926084f6-8810-41fe-94f3-e2d05e907e9e
md"""
需要注意的是这里填充进去的是同一个值。如果这个值是一个可变结构,比如数组, 意味着所有的值都是这个可变结构.因此改变其中的一个也会改变其他的值。通过下面的例子就明白。
```julia
julia> A = fill(zeros(2), 2) # sets both elements to the same [0.0, 0.0] vector
2-element Vector{Vector{Float64}}:
 [0.0, 0.0]
 [0.0, 0.0]

julia> A[1][1] = 42; # modifies the filled value to be [42.0, 0.0]

julia> A # both A[1] and A[2] are the very same vector
2-element Vector{Vector{Float64}}:
 [42.0, 0.0]
 [42.0, 0.0]
```
""" |> box(:red)

# ╔═╡ 7ccf7108-175a-43f1-b8ac-75f46c766d40
md"""
有时候我们可能会需要构造一个跟给定数组具有相同维度或者相同元素类型的数组这时候可以使用similar函数。
```julia
similar(array, [element_type=eltype(array)], [dims=size(array)])
```
注意，上面的函数中元素类型和维度都是可选的参数。如果都没有给定，那就是一个跟array具有相同内存结构的未初始化的数组.
"""

# ╔═╡ 18dfa55b-3a4c-45c3-9e49-c3d42663b522
md"""
## 数组的索引
除了维度数组的另外一个重要特性是：数组元素具有索引（index）。简单来说就是数组的元素都具有一个编号或者下标（位置）。可以通过这个编号或者下标直接获得数组中的某一个具体的元素。数组有两种形式的索引： 线性索引`IndexLinear`和笛卡尔索引`IndexCartesian`. 

Julia给数组的每一个元素位置按照先低维后高维的顺序(按列存储)都赋予了一个从1开始到数组元素个数(length)的编号。这个编号就是线性索引。

线性索引用一个整数表示一个元素的位置。而笛卡尔索引则是用多个整数表示一个元素的位置。通常情况下每一个维度需要一个数字。比如(m,n)表示数组的第m行n列所在的位置。也可以说第一维的下标取值是m， 第二维的下标取值是n。

对一个数组来说，线性索引跟笛卡尔索引之间可以相互转换。但从笛卡尔索引转换为线性索引要容易（涉及加法和乘法）。从线性索引转化为笛卡尔索引要复杂一些（涉及除法）。Julia中的数组同时实现了上面两种索引方式。

索引的重要作用是可以通过索引去操作数组的对应索引位置的元素。强奸的操作是读取和写入。这两种操作都可以用中括号放入索引的方式实现。 其中`A[index]`用于获取元素， `A[index]=...`用于修改元素。`index`是一个合法的索引值（一个整数，或逗号分隔的多个整数）。

```julia

getindex(A, inds...)

setindex!(A, X, inds...)
A[inds...] = X

```

```julia
julia> A = [10 20; 30 40];

julia> A[1,2]
20

julia> A[3]

```
如果我们要遍历数组去处理他的每一个元素，可以使用`eachindex`函数获得一个数组的所有元素的索引构成的容器， 通过遍历这个容器去处理数组中的元素。这个函数会根据数组的类型返回它最优的索引方式。

```julia
julia> A = [10 20; 30 40];

julia> for i in eachindex(A) # linear indexing
           println("A[", i, "] == ", A[i])
       end
A[1] == 10
A[2] == 30
A[3] == 20
A[4] == 40

```
"""

# ╔═╡ 77f4c1b7-e90b-4bd3-bc64-140d0370146b
md"""
### 数组读取
读取一个数据中某一个或者某一批未知的元素的通用语法是：
```julia
X = A[I_1, I_2, ..., I_n]
```
这里的`I_k`可以是整数、向量、数组、冒号(:)、范围（a:b:c或者a:c)以及任何其他合法的索引。

如果所有的索引`I_k`都是标量， X就是对应位置的元素。 标量的存在会消除对应维度。

如果所有索引`I_k`都是向量，那么X的形状将是`（length(I_1），length(I_2),...，length（I_n）`，位置`(i_1,i_2,...,i_n)`的值包含`A[I_1[i_1],I_2[i_2],...,I_n[i_n]]`。

### 数组改写
修改一个数组某些位置的元素的通用语法是：
```julia
A[I_1, I_2, ..., I_n] = X
```
这里下标的写法和上面是类似的。 赋值能够成功， 要求左边得到的尺寸，跟右边X提供的尺寸或元素个数（向量情形）相同。 如果是一个元素赋值给多个位置， 则需要用到广播运算：
```julia
A[I_1, I_2, ..., I_n] .= X
```
"""

# ╔═╡ 9807c778-e540-4f68-8f13-ca8d1a3ed5f2
md"""

关于笛卡尔索引

[ref](https://julialang.org/blog/2016/02/iteration/)
首先， 可以方便的通过整数或整数元组构建笛卡尔索引（CartesianIndex）。注意， 这构建的是单个索引。
```julia
CartesianIndex(i, j, k...)   -> I
CartesianIndex((i, j, k...)) -> I
```
如果想构建一片区域， 可以通过一个维度对象（整数元组）, 或一个范围元组，放入CartesianIndices中（注意，这是复数）。
```julia
CartesianIndices(sz::Dims) -> R
CartesianIndices((istart:[istep:]istop, jstart:[jstep:]jstop, ...)) -> R
```
当然， 也可以直接通过`CartesianIndices`获取一个数组的所有笛卡尔坐标。
```julia
CartesianIndices(A::AbstractArray) -> R
```
以上只是关于如何构建迪卡尔索引。有趣的是笛卡尔索引还支持简单运算。

简单加减远算会在对应的每个维度上做相应的运算。
```julia
julia> CIs = CartesianIndices((2:3, 5:6))
CartesianIndices((2:3, 5:6))

julia> CI = CartesianIndex(3, 4)
CartesianIndex(3, 4)

julia> CIs .+ CI
CartesianIndices((5:6, 9:10))
```
另一个值得注意的是对两个笛卡尔索引求最大值max和最小值min。他们并不是直接比较两个笛卡尔索引的大小， 而是求得两个索引的对应维度上的最大值和最小值。
```julia
julia> max(CartesianIndex(3,4,5), CartesianIndex(2,5,3))
CartesianIndex(3, 5, 5)

julia> min(CartesianIndex(3,4,5), CartesianIndex(2,5,3))
CartesianIndex(2, 4, 3)

julia> CartesianIndex(3,4,5) > CartesianIndex(2,5,3)
true

```

下面这个函数， 将A的某个维度求和，放入B中。注意`min(Bmax,I)`， 因为在求和的维度上， Bmax会等于1， 其他维度上则是可取到的最大值。 因此， 这里min返回的永远是，求和为都上为1， 其他则是I所对应的位置。
```julia
julia> function sumalongdims!(B, A)
    # It's assumed that B has size 1 along any dimension that we're summing,
    # and otherwise matches A
    fill!(B, 0)
    Bmax = last(CartesianIndices(B))
    for I in CartesianIndices(A)
        B[min(Bmax,I)] += A[I]
    end
    B
end
```

""" |> fbox

# ╔═╡ 5537f878-4e61-43a3-8d27-af4c9b243e21
md"""
## 基本函数

- ndims(A::AbstractArray) -> Integer： 给出数组有多少个维度？
- size(A::AbstractArray, [dim])： 返回数组的每一个维度的长度构成的元组。也可以用于获取指定维度的长度。

- axes(A) : 以元组的形式返回数组的每一个维度的索引范围。
```julia
julia> A = fill(1, (5,6,7));

julia> axes(A)
(Base.OneTo(5), Base.OneTo(6), Base.OneTo(7))
```
- axes(A, d): 返回数组的指定维度的索引范围。
```julia
julia> A = fill(1, (5,6,7));

julia> axes(A, 2)
Base.OneTo(6)

julia> axes(A,3) == 1:7
true
```
- length(A::AbstractArray):返回数组的元素个数。

- **变形**
reshape可以将一个数组变形为另一个给定维度的数组。 前提是变形前后， 元素个数是相同的。
```julia
reshape(A, dims...) -> AbstractArray
reshape(A, dims) -> AbstractArray
```
- **搜索**
|函数名|	搜索的起始点|	搜索方向	|结果值|
|---|---|---|---|
|findfirst|	第一个元素位置|	线性索引顺序|	首个满足条件的元素值的索引号或nothing|
|findlast|	最后一个元素位置|	线性索引逆序|	首个满足条件的元素值的索引号或nothing|
|findnext|	与指定索引号对应的元素位置|	线性索引顺序|	首个满足条件的元素值的索引号或nothing|
|findprev|	与指定索引号对应的元素位置|	线性索引逆序|	首个满足条件的元素值的索引号或nothing|
|findall|	第一个元素位置|	线性索引顺序|	包含了所有满足条件元素值的索引号的向量|
|findmax|	第一个元素位置|	线性索引顺序|	最大的元素值及其索引号组成的元组或NaN|
|findmin|	第一个元素位置|	线性索引顺序|	最小的元素值及其索引号组成的元组或NaN|
"""

# ╔═╡ 1aacc018-59c3-4ca3-9934-266afbcfaa0d
md"""
## 数组的迭代
数据迭代有两种方式：
```julia
for a in A
    # 直接对元素a做操作
end

for i in eachindex(A)
    # 对元素下标 i 或元素 A[i] 同时操作
end
```
"""

# ╔═╡ 9aaa8953-42be-4d00-9105-c40c8f0bfb39
md"""
## 广播与向量化
### 广播
广播是将一个操作同时施加到多个对象上。 使用函数broadcast, 可以方便的将函数f广播到数组，元组，集合，引用或标量上。 如果后面的元素（As...）都是单个元素， 则返回结果是单个元素。如果其中有一个是元组， 返回结果是元组， 其他情况下， 返回结果是数组。
```julia
broadcast(f, As...)
```
下面是是一个简单的例子：
```julia
julia> A = [1, 2, 3, 4, 5]
5-element Vector{Int64}:
 1
 2
 3
 4
 5

julia> B = [1 2; 3 4; 5 6; 7 8; 9 10]
5×2 Matrix{Int64}:
 1   2
 3   4
 5   6
 7   8
 9  10

julia> broadcast(+, A, B)
5×2 Matrix{Int64}:
  2   3
  5   6
  8   9
 11  12
 14  15
```
"""

# ╔═╡ 32c81b82-f8b1-44dd-b1b3-251c62eb592c
md"""
### 向量化

在Python、R等语言中， 为了写出更高效的代码， 一般都尽量使得代码是向量化的。一个函数``f(x)``施加到向量``v``上时，默认会施加到向量中的每一个元素上``f(v[i])``。在Julia中， 也支持向量化。只需要在函数调用的括号前面加一个点即可。例如
```julia
x = rand(10)
sin.(x)
```
可以实现对10个元素同时求正弦sin。 因为运算符也是函数， 所以运算符也可以是向量化的， 可以通过在运算符前加一个点让运算符变成向量化运算符。比如，下面的 **.^**可以实现对向量中的每一个元素求平方。

```julia
x = rand(10)
x.^2
```

多个函数同时向量化也是允许的， 而且在Julia中会比较快。 比如， 我们对一个向量中每一个元素平方之后，求正弦， 再求余弦， 那么可以这么写：

```julia
x = rand(10)
cos.(sin.(x.^2))
```
上面的代码中有三个点， 表明三个相关函数（^这个也是函数）都是向量化的。不过，如果有太多点运算， 可能代码看起来比较繁琐， 这时候可以使用宏`@.`。 宏有点像函数， 但不需要写括号。宏`@.`是告诉Julia， 这个宏后面的代码是向量化的， 只是不需要写点了。因此，上面的代码也可以写成：
```julia
x = rand(10)
@. cos(sin(x^2))
```
这时候， 如果你要告诉Julia， 其中的某个函数不是向量化的， 那么你需要在该函数名前加上美元\$符号。

例如`@. sqrt(abs($sort(v)))`表示对向量排序（sort）之后，再每个元素求绝对值（abs），然后再开方（sqrt）。

在julia中， 你直接写循环会比向量化代码更快， 所以不需要担心自己的代码不是向量化的。 我们还是会写向量化的代码是因为非常方便，仅此而已。
"""

# ╔═╡ ce95d0e9-6d1c-4546-90a9-b2655bf1fd61
md"""
在Julia中， 点运算本质上就是调用了广播函数。比如， `f.(args...)` 本质上调用的是` broadcast(f, args...)`.

""" |> box

# ╔═╡ 39a09e5b-cb30-4631-b479-495388655d94
md"""
##  数组推导
数组推导是构建数组的一个常见形式。与python类似，Julia也提供了数组推导式, 通用的格式如下：
- [f(e) for e in colletion if condition]。 这是遍历collection里面的元素， 当满足条件condition时就进行某种操作f， 最后形成一个数组。 e in colletion 也可以写成 e = colletion， if condition可以省略, 下同。
- [f(x,y) for x in c1, y in c2 if condition]。 这种情况下， x,y分别从两个集合c1,c2取值，如果没有if条件，结果是一个矩阵， 矩阵第i,j位置上的元素是f(x[i],y[j])， 由于Julia中矩阵按列存储， 所以会先计算出第1列，再第二列，依次类推； 如果有if条件， 结果是向量， 相当于先计算一个矩阵，再过滤掉不满足条件的元素。  
**注意：**如果外侧不是用[ ]包裹， 那就不是数组推导。 比如， 用（）包裹得到的可不是python里面的元组， 而是生成器了。
"""

# ╔═╡ 295464e9-4ada-46ae-80f2-5f09fa0ed635
[x for x in 1:100 if iseven(x)]

# ╔═╡ f9efe456-7c51-41de-a80f-4ae26d9c5c35
[(x,y) for x in 1:3,  y in 1:4]

# ╔═╡ 46c6ac52-d33d-45f5-9fbd-05221940a159
md"""
### 向量的拼接cat
如果有多个向量需要拼接为一个向量， 可以使用cat函数。
```julia
cat(A...; dims)
```
该函数有一个关键字参数， dims， 用于给定拼接的维度。 也就是把数据放在哪个维度上（单个维度）。 注意， 这里的参数名是复数， 意味着可以同时给多个维度， 这时候拼接的结果是多个维度同时增加。比如， 构造分块矩阵。

在第一个维度拼接也可以用vcat， 在第二个维度拼接可以用hcat。看[**这里**](https://docs.julialang.org/en/v1/base/arrays/#Base.cat)了解更多。
"""

# ╔═╡ 9b679c06-4c2c-4fac-b531-0f595e01d5ce
md"""
push!函数可以在向量后面增加一个元素， 而pop!函数弹出向量的最后一个元素， 注意， 这两个函数名后面有惊叹号， 表明这种函数会修改参数值。 在这里其实是会修改，输入的数组xv。
"""

# ╔═╡ 1bfa8a99-7fa1-4254-b871-0ad0c6f908aa
md"""
### 向量堆叠stack
矩阵是由列向量按行排列而成的。因此， 如果我们有一系列等长的向量， 可以将其简单拼接起来就好。
"""

# ╔═╡ 7375a318-67e6-4755-9380-11d1b73a69e3
vecs = (1:2, [30, 40], Float32[500, 600]);

# ╔═╡ fe36499e-7dca-47a1-ba28-7d9602a3dd1e
stack(vecs)

# ╔═╡ bce35124-6542-44a9-bf0c-2aaf5c17a4cb
cat([1,2],[3,4], dims=1)# 按第一个维度（行）方向拼接

# ╔═╡ 4ac9bd22-dc28-4a08-be79-a57ef9bb9e39
cat([1,2],[3,4], dims=2)# 按第二个维度（列）方向拼接

# ╔═╡ f11fd7d7-2e36-4cb4-be86-37b22a1f0496
md"""
下面是按第三个维度（厚度）方向拼接的结果。 这本书有两页， 每一页上只有一列。
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.55"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.1"
manifest_format = "2.0"
project_hash = "f64cdffc70331b0a2f407efefd54fd84eb680773"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "c278dfab760520b8bb7e9511b968bf4ba38b7acc"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.0+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "8b72179abc660bfab5e28472e019392b97d0985c"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.4"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "68723afdb616445c6caaef6255067a8339f91325"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.55"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╠═6e60ede1-184e-44c2-8bd9-580535ba783a
# ╟─3160ac8d-0aae-43ea-a3ac-fa66991f1533
# ╠═6485e303-3be0-4683-95c3-68fa4cf8ef0d
# ╠═2d5a100b-64d9-4ee1-8ce9-edf4c431d865
# ╟─be6e92bc-7cd6-494b-a5d3-2a1ed49c91b9
# ╠═3c0c4a27-7ec7-4c9a-9c93-b47d1d298ccb
# ╟─b766b11c-39af-4b08-af2b-e01569bb2170
# ╠═45d5ab62-2483-4650-9e68-2cf9e779345a
# ╠═3264b2ae-8e0c-411c-9503-b3416b4a951e
# ╠═d2c94917-6289-4938-bcf8-c4fe5d74ce37
# ╟─146c3abe-ddfb-4a59-b75e-19fdc91fa1aa
# ╠═075fef83-e55b-426a-9966-0244fd64b38e
# ╠═43c28d52-a352-46a3-9907-57c2e09d5333
# ╟─fa5f4c1f-84fb-44e0-a368-19a7886b0c2c
# ╟─4842c9ff-4571-4c4d-928b-9ec544d584a4
# ╟─8c0becc4-dae6-4aca-b232-e0482376903d
# ╟─4b33c26f-222a-4477-a85e-8363727d6636
# ╟─8e9daf50-296f-492e-991f-44c1a002e5e4
# ╟─926084f6-8810-41fe-94f3-e2d05e907e9e
# ╟─7ccf7108-175a-43f1-b8ac-75f46c766d40
# ╟─18dfa55b-3a4c-45c3-9e49-c3d42663b522
# ╟─77f4c1b7-e90b-4bd3-bc64-140d0370146b
# ╟─9807c778-e540-4f68-8f13-ca8d1a3ed5f2
# ╟─5537f878-4e61-43a3-8d27-af4c9b243e21
# ╟─1aacc018-59c3-4ca3-9934-266afbcfaa0d
# ╟─9aaa8953-42be-4d00-9105-c40c8f0bfb39
# ╟─32c81b82-f8b1-44dd-b1b3-251c62eb592c
# ╟─ce95d0e9-6d1c-4546-90a9-b2655bf1fd61
# ╟─39a09e5b-cb30-4631-b479-495388655d94
# ╠═295464e9-4ada-46ae-80f2-5f09fa0ed635
# ╠═f9efe456-7c51-41de-a80f-4ae26d9c5c35
# ╟─46c6ac52-d33d-45f5-9fbd-05221940a159
# ╟─9b679c06-4c2c-4fac-b531-0f595e01d5ce
# ╟─1bfa8a99-7fa1-4254-b871-0ad0c6f908aa
# ╠═7375a318-67e6-4755-9380-11d1b73a69e3
# ╠═fe36499e-7dca-47a1-ba28-7d9602a3dd1e
# ╠═bce35124-6542-44a9-bf0c-2aaf5c17a4cb
# ╠═4ac9bd22-dc28-4a08-be79-a57ef9bb9e39
# ╠═f11fd7d7-2e36-4cb4-be86-37b22a1f0496
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
