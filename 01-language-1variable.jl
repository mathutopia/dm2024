### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 5c3ad4ef-7e02-4e02-9802-f95dfc0ec626
begin
using PlutoUI
include("Box.jl")
TableOfContents(title="目录")
end


# ╔═╡ 44ea8038-d4d3-4fcf-a0d7-6ef5cc63a3a7
using Kroki

# ╔═╡ 9aae89e6-ddc7-4363-a573-91cde91c943a
md"""
# 概述
"""

# ╔═╡ 5f8ae6a2-0bc0-4f50-a144-6c52281ce834
md"""
该教程粗略的摘录了 Julia 的基本语法，不熟悉 Julia 的同学可以先粗略地通读该教程，以大致熟悉基本操作。

如果想要了解详细内容可以查阅[官方文档](https://docs.julialang.org/en/v1/)。

如果想比较全面的学一下Julia, 可以看看Github上面的这种本[Julia编程基础](https://github.com/hyper0x/JuliaBasics/tree/master/book)
"""

# ╔═╡ 09d1789b-243f-4008-a6a7-d25fe570abf7
md"""
**程序 = 数据结构+算法**， 要学会编程， 你需要知道一些基本的数据结构（类型）以及如何去操作这些数据（算法）。 数据结构可以理解为数据的组织方式。

数据结构的学习大致沿着基本类型（数值类型、字符（串）类型、日期类型），到构造类型（元组、命名元组、pair、字典、数组）， 再到更高级的自定义类型（struct）的顺序。 

而对算法来说， 首先要掌握的是各种数据类型的基本运算符（比如+、*）、基本函数（运算符本质上也是函数）、再到自定义函数。 当然， 在学习自定义函数前， 首先需要掌握流程控制的基本方法。 

本部分主要聚焦基本数据类型和基本运算。

"""

# ╔═╡ fda53176-6e05-4e0e-995b-b5d1d6c0d9f8
md"""
# 变量与值

数据在内存中是以**值（value）**的形式存在的。 如果把代码构建的虚拟世界类比人类世界， 那么值就是这个虚拟世界的各种客观存在（对象）。值的作用是参与运算， 为了方便计算， 很多时候， 我们需要给值取一个名字， 这就是**变量(variable)**的概念。一个变量是一个跟值关联在一起的名字。 通常， 可以用**绑定操作符（=）**将一个值一个变量名关联起来。 比如， 下面的语句`x = 10`， 实现把数值10和变量名x绑定在了一起（绑定的同时**定义了一个变量**x）。 之后， 当我们使用变量x时， 相当于在使用10。

```julia 
# 变量x绑定数值10
julia> x = 10
10
# 用变量x绑定的数字做运算
julia> x + 1
# 重新绑定x的值为一个表达式运算的结果
julia> x = 1 + 1
2
```
注意， 值不一定都有名字，比如数值`10`、字符串`"hello"`等。这些值在参与运算时我们会直接写出来， 因此称为字面值常量。 可以认为这些值的字面形式就是它的名字。

"""

# ╔═╡ ec6af47a-4bc5-49a0-bd3b-e5e9e9eddc4c
md"""
在代码示例中， 
- #符号后面内容表示注释内容。 这是不会被执行的语句。 如果要注释多行， 需要写到#=...=#之间。
- julia> 是命令提示符， 表示此后的语句是代码， 读者可以将其复制到REPL中执行。
- julia> 行之下， 通常是其执行结果。有时候我不会将其写出来(😁)， 这时候我会在语句后写一个分号;。
- 通常，语句后面如果**没有分号；**则该语句执行的结果会打印出来， 如果有分号，则结果不会被打印出来。
－ Julia引入了一些Matlab的特性， 如果你在 `julia> `后输入`ans`， 会自动打印出上一个语句的执行结果

""" |> box

# ╔═╡ fddfa92f-6efd-48cb-ba2a-7408ffef3275
md"""
绑定操作符（=）在很多语言中又叫赋值操作符。这里把它叫做绑定操作符是为了强调它只是把值和一个变量名绑定到一起。而且这是一种很弱的绑定关系，这意味着我们可以随时把这个名字绑定到另外的值， 甚至不同类型的值。比如， 再次运行下面的代码后，x的值就变成了一个字符串。

```julia
julia> x = "Hello World!"
```
由于变量名跟值之间只是一个松散的绑定关系， 相较于强类型语言如C/C++, 在Julia中， 定义变量时， 我们不需要事先声明变量及其类型。 
"""

# ╔═╡ d48dec00-16d4-4970-b9ac-74e02408c1b9
md"""
注意， 写法`a=b=value`表示变量a，b绑定到了同一个值， 值都是value。如果value是一个可变结构，比如向量（后面会讲到）， 那么通过a改变value的值， 会导致b也发生改变， 因为a，b本质上指向同一个对象， 只是名字不同而已。下面中括号构造的就是向量。

```julia
julia> a = b= [1,2,3];
julia> a
[1,2,3]
julia> b
[1,2,3]
julia> a[1]=10;
julia> b
[10,2,3]
```

当然， a、b都可以指向其他的值。比如， 再次写`b=value1`， 这时候， b绑定到了一个新的值，a绑定关系没变。

所以一定要注意， 变量是没有实体的。只有把变量名跟某个值（实体）关联起来， 变量才有意义。
""" |> box(:red)

# ╔═╡ 25be937b-32ee-4594-bf12-67fa7d383622
md"""
## 变量命名规则
前面提到，变量是一个与值绑定的名字。很多语言要求变量名只能是字母数字下划线构成， 在julia中， 你可以使用**几乎所有可能的符号做变量名（变量名必须以字母(A-Z或a-z)、下划线或大于00A0的Unicode码点子集开头（ASCII码都不满足）**, 其后可以跟几乎所有的字符， 参考[这里的解释](https://docs.julialang.org/en/v1/manual/variables/#man-allowed-variable-names))。 
比如， 下面三个（中国、 α 、 ⬠）都是合法的变量名：

```julia
julia> 中国 = 10
julia> α = 100
julia> 中国 + α
110
julia> ⬠ = "我是字符串"
"我是字符串"
```
"""

# ╔═╡ f2346f33-9f66-4220-9fcb-e4772c1e3f5d
md"""
## 值的类型
前面说到， 值是代码构建的虚拟世界中的客观实体。 因此， 每个值都会占有一定的空间。 计算机根据什么决定值应该占有多大的空间，以及存在哪里呢？ 答案是**类型（type）**。 不同类型的值，其存储的位置和方式可能都不同。一般来说， 我们不必关心，值存在哪里。但为了更加高效的处理数据，我们需要知道值的类型。

可以使用`typeof`查看一个值的类型。比如， 字面值10的类型是：$(typeof(10))。即`typeof（10）`的返回结果为 $(typeof(10))。 由于变量是和值绑定到一起的。因此我们也可以查看变量的类型。但请注意。变量的类型只是这个变量绑定的值（或者能绑定的值， 如果限定了话）的类型。

```julia
julia>typeof(10)
Int64

julia> x = 10
julia> typeof(x)
Int64

```

Julia有丰富的数据类型。 这也是Julia语言高效的一个重要原因。在Julia语言中， 类型具有树形层次结构。通常任何类型都会具有一个父类型，可以通过`supertype`函数获取一个类型的父类型。一个类型也可能具有0个或多个子类型， 可以通过`subtypes`函数获取一个类型的所有子类型。注意这两个函数名的单复数形式。它表示了父类型只有一个，而子类型可能有多个的事实。 前面我们知道， 整数10是Int64类型。它的父类型是Signed。而Signed是Integer的子类型。Interger的父类型是Real。而Real具有多个子类型，既有整数（Integer）、分数（Ritaonal），还有浮点数（AbstractFloat）类型等。注意：这里提到的父类型和子类型都是都是类型层次树上的直接父类型和子类型。 一个类型的父类型的父类型，以及沿着类型层次树一直往上直到Any类型所经历的所有类型都可以看成是这个类型的祖先类型（有时候也统称为父类型）。以此类推， 一个类型的所有子类型，以及依类型树往下直到所有的叶子节点经历的类型都是该类型的后代类型（有时候也统称为子类型）。

```julia
julia>supertype(typeof(10))
Signed

julia>supertype(Signed)
Integer

julia>supertype(Integer)
Real

julia>subtypes(Real)
[AbstractFloat,AbstractIrrational,FixedPoint,Integer,Rational]

```

下面两个自编函数print\_supertypes和print\_subtypes可以用于打印一个类型的所有父类型和子类型。暂时看不懂这两个函数也没关系。 后面还会讲到函数的编写。 
```julia
function print_supertypes(T)
        println(T)
        T == Any || print_supertypes(supertype(T))
        return nothing
end
function print_subtypes(T, indent_level=0)
    println(" " ^ indent_level, T)
       for S in subtypes(T)
            print_subtypes(S, indent_level + 2)
       end
       return nothing
end
```

"""

# ╔═╡ 1f12ccdf-6240-4fac-8ea2-298f0f700ef8
begin
function print_supertypes(T)
        println(T)
        T == Any || print_supertypes(supertype(T))
        return nothing
end
function print_subtypes(T, indent_level=0)
    println(" " ^ indent_level, T)
       for S in subtypes(T)
            print_subtypes(S, indent_level + 2)
       end
       return nothing
end
end;

# ╔═╡ e98b4282-b10d-4367-aba0-ba932975f677
print_subtypes(Number, 4)

# ╔═╡ 6213a746-a0c1-4b03-9518-ab204f75d36e
md"""
上面显示了数字类型（Number）的所有子类型。从中可以看到在JUlia中， 数字具有丰富的类型。事实上，从小学学到的整数（integer)、分数(ratinal)到中学学习的实数(Real)、复数(complex)等， 数字概念的学习是一个不断扩展的过程, 数字本身也是有一个层次结构。 Julia语言的类型系统， 正好帮助实现了对这种类型层次的模拟。

丰富的类型系统可以使得在编程过程中充分的利用内存空间，提高计算效率。这也是julia语言相比Python更高效的一个原因。但编程过程中需要考虑值的类型可能也是一种负担， Julia语言考虑到了这一点。 在Julia的类型系统中， 处在这个类型树根部位置的是Any类型，也就是任何类型都是Any类型的子类型。 因此， 在编程过程中，我们可以不用考虑值或者变量的类型。Julia语言会默认它就是Any类型。在不考虑类型的情况下，我们可以把Julia语言当成Python或R语言一样的脚本语言来写。因此Julia语言可以写起来很简单。但它又提供了一种能力，可以让代码很高效。当然真正高效的原因是Julia语言会根据不同类型的值编译不同类型的代码, 使得代码的执行效率很高。

```julia
julia>supertype(Number)
Any

```

"""

# ╔═╡ ca13c3d0-6834-4475-b4f8-ded249f21579
md"""
为了方便， 我们用一个右向的思维导图将Julia中的数字类型树画出来，如下图所示。 这个图是[Koroki.jl包](https://bauglir.github.io/Kroki.jl/stable/)画的[plantuml图形](https://plantuml.com/zh/mindmap-diagram)。
""" |> hintbox

# ╔═╡ cbb38a16-20c3-4376-b8a5-73692a931df6
plantuml"""
	
@startmindmap
<style>
mindmapDiagram {
  .specific {
    BackgroundColor lightgreen
}
  .abstract {
    BackgroundColor #FFBBCC
  }
  .path {
    BackgroundColor lightblue
  }
}
</style>


* Any <<path>>
** Number <<path>>
*** Complex <<specific>>
*** Real <<path>>
**** AbstractFloat <<abstract>>
***** BigFloat <<specific>>
***** Float16 <<specific>>
***** Float32 <<specific>>
***** Float64 <<specific>>

**** AbstractIrrational <<abstract>>
***** Irrational <<specific>>

**** Integer <<path>>
***** Bool <<specific>>
***** Singed <<path>>
****** BigInt <<specific>>
****** Int64 <<specific>>
****** Int32 <<specific>>
****** Int16 <<specific>>
****** Int8 <<specific>>

***** Unsigned <<abstract>>
****** UInt128 <<specific>>
****** UInt64 <<specific>>
****** UInt32 <<specific>>
****** UInt16 <<specific>>
****** UInt8 <<specific>>

*** Rational <<specific>>
@endmindmap
"""

# ╔═╡ 136cb029-5e54-4034-a785-ee35388b24de
md"""
## 抽象类型与具体类型
上面提到Julia类型系统是一个树形结构(如前图所示)。 树的根节点是Any类型。 通常， 这棵树的中间节点对应的类型都是抽象类型， 而叶子节点（绿色节点）对应的是具体类型。 也就是说， 抽象类型肯定有子类型， 子类型可能是抽象的，也可能是具体的。 而具体类型则没有子类型， 一个值的类型是具体的， 但同时也可以认为一个值是它的父类型的一个值。比如， 数值10是Int64类型的（具体类型）， 同时也是整数类型（Integer）。  

具体类型可以看成是跟具体存储实现相关的。 比如Int64表示64位的整数， 对应连续的8个字节的存储空间。 那为什么需要有抽象类型呢？ Julia的类型系统是为了实现Julia的多重分派而引入的。 简单来说， Julia允许用户在抽象类型上定义函数，这样我们用该抽象类型的任意子类型的值去调用该函数。这一点， 可能暂时不好理解， 后续在函数定义中还会进一步解释。
"""

# ╔═╡ b969accc-b93c-420f-9535-5b4124da2aea
md"""
## 类型的修饰与运算
虽然不知道变量的类型，对初学者来说影响不大，但想要写出高效的代码，有时候也是为了看懂别人的代码， 我们还是需要知道如何修饰（限定）变量的类型。

Julia中， 使用**两个冒号::**表示类型注释， 其基本形式是：**`变量名::类型名`**， 用于告诉系统左边的变量能绑定的类型只能是双冒号之后的限定的类型。 比如下面的代码限定变量x只能绑定Int16类型（16位（bit)的整数）的值， 当我们把常量10（Int64类型)与之绑定的时候， Julia会自动对其做类型转换。最终x绑定的值是Int16类型。
```julia
julia> x::Int16 = 10; 
julia> typeof(x)
Int16
```

这种形式的类型限定， 常出现在函数定义时对参数类型的限制上。
"""

# ╔═╡ 2c28f40f-3a22-4ea8-82e1-300eb48b204c
md"""
类型本身也是一种“值”（不管是系统提供的，还是用户定义的）。 因此， 类型也可以做相关的运算。 除了上述提到的获取类型的父、子类型，以及限定变量类型以外， 涉及类型的运算主要还有两种：1）判断类型的大小关系（父子关系）；2）断言值是某种类型。

判断类型关系可以使用**" <: 和 :> "**两种运算符。 一般来说`T1 <: T2` 或者 `T2 >: T1`用于判断在类型树上，T1的层级是否不超过T1的层级（越靠近树根层级越高）。 其返回结果是bool值ture或false。

如果要判断一个值是否是某种类型（或其类型的后代类型）的值， 可以用`isa`函数， 基本用法是`isa(x, type) -> Bool` 。 也可以这样用： ` x is type `。

```julia
julia> Int64 <: Integer
true
julia> Number >: Integer
true
julia> Number <: Number
true
julia> 10 isa Number 
true
julia> isa(10, AbstractFloat)
false
```

"""

# ╔═╡ fdf47379-59c5-46ef-ba25-b491ea7be10a
md"""
当我们把虚拟世界中的值类比到现实生活（客观世界）中的人，很多概念就比较好理解了。

值具有类型就像生活中的人具有“籍贯”一样。在不同的地方，当有人问你，你是哪里人时， 你的答案可能是： 我是❌❌村人或❌❌县人或❌❌省人或中国人或地球人等等。 你看， 这个“你是哪里人”也是有层级的。 如果你是湖南人，那说你是中国人也是对的。 通过这个类比， 应该比较好理解值的类型的层次结构。

当我们说值的类型时， 我们通常说的是它的具体类型。就像我们写籍贯时， 一定要写到你出生的地方。 抽象类型的存在是为了数据的管理和编程的方便， 就像各种行政区（省、市、县、区...)的划分市为了更好的社会管理一样。当我们编写一个只有某种类型的值才能调用的函数的时候， 就像给具有籍贯的人赋予了一种特殊的能力一样。
""" |>box

# ╔═╡ c9d58a4d-8e16-4c4c-88fe-ef4f61ccb3fd
md"""
# 数值类型
数值类型是一门编程语言最基础的数据类型。 前面在讲值的类型的时候，我们已经给出了Julia中所有的数值类型。 
有些语言不关注数值的具体类型， 都统一视为“数字”。 但强于科学计算的Julia语言， 有丰富的数值类型。将数值细分为不同的类型是有意义的， 不仅能减少数据的存储空间， 还可以提高数据的计算效率。 当然， 如果你觉得处理这么多数据类型很麻烦， 你也可以不管数据类型。 Julia会自动选择默认的数据类型。 比如， 通常整数会当成Int64的类型（在64位的机器里）， 而带了小数点的有理数会当成Float64类型。

关于数值类型一个值得注意的点是：逻辑值（true，false）是整数类型。

## 特殊数字
由于内存的限制， 某种类型的能表示的数据总是有限的。 可以通过typemax函数查看一个类型能表示的最大值。类似的，可以通过typemin函数查看类型的最小值。 

在Julia中， Inf 表示无穷大， NaN 表示不是数（Not a Number）， 参考下面的例子。

"""

# ╔═╡ 5cada891-e82e-4a76-ac54-10e514f78ddc
md"""
## 算术运算符
算术运算符是一门语言中常见的， 主要适用于数值类的数据。下表给出了常用的算术运算符。

|运算符| 含义 | 用法|
|-----|------|-----|
| // | 分数 | a//b |
| + | 求和  | a + b |
| - | 求差  | a - b |
| * | 乘法  | a * b |
| / | 除法  | a / b |
| \ | 除法  | a \ b (等价于 b / a) |
| $\div$ | 整除 | a $\div$ b|
| % | 求余数 | a % b|
| ^ | 乘方  | a ^ b|

注意， + - 也可以用作一元运算符， 在变量前添加 + ， 不会改变变量值； 添加 - ， 会将变量变相反数。 上面的$\div$在编辑器中可以通过 \div+[TAB] 键输入。 这也是Julia特殊的地方， 它是完全支持Unicode字符的， 所以我们可以使用类似于数学书写的方式去写各种变量。 以后看到类似的数学符号， 他们都是通过相应的latex符号+ TAB键打印出来的。 你也可以通过复制一个符号， 然后用 `? 符号`的方式在REPL中获得其书写方法帮助， 或者用`@doc 符号`的方式获得相关符号的帮助文档。下面演示的是整除。

注意， 由于Bool值也是数值类型。所以， Bool值， 也就是true和false也可以用于数值运算， 默认情况下， true相当于1， false相当于0。
"""

# ╔═╡ 14e3f7cc-8fa0-4873-a9ec-e77418b9214a
md"""
## 比较运算
比较运算主要用于对值的大小比较，主要有大于、小于、等于，以及衍生的大于等于、小于等于、不等于等6种情况， 比较的结果通常是逻辑值 true 或 false， 常用于 if 语句等逻辑判断场景。 下面是具体用法：

|运算符| 含义 | 用法|
|-----|------|-----|
|>	| 大于: 左操作数大于右操作数时为 true	| x > y |
|<	| 小于: 左操作数小于右操作数时为 true	| x < y |
|==	| 等于： 左操作数等于右操作数时为 true    | x == y |
|!=, ≠	| 不等于： 左操作数不等于右操作数时为 true 	| x != y or x ≠ y |
|>=, ≥	| 大于或等于: 左操作数大于或等于右操作数时为 true	| x >= y or x ≥ y |
|<=, ≤	| 小于或等于: 左操作数小于或等于右操作数时为 true	| x <= y or x ≤ y |

注意， 上面几个特殊符号对应的latex代码≠ （\ne）, ≥ (\geq), ≤ (\leq) 。 
下面是几个例子：

"""

# ╔═╡ 2ae0bca5-8955-4430-b44d-ea70f5cd4657
md"""
关于比较，  遵循基本的准则如下：

- 有限的数以通常的方式排序。
- 正零(+0)等于但不大于负零(-0)。
- Inf等于自身，大于除NaN以外的一切。
- -Inf等于自身，小于除NaN以外的所有值。
- **NaN不等于，不小于，也不大于任何东西，包括它自己。**

上面的规则很好理解， 但比较头痛的是NaN。 有时候， 当我们碰到这个值， 又希望判断它是否是NaN时， 可以通过函数`isequal`去判断。

```julia
julia> NaN == NaN
false

julia> [1 NaN] == [1 NaN]
false

julia> isequal(NaN, NaN)
true

julia> isequal([1 NaN], [1 NaN])
true

```
"""

# ╔═╡ d1685ebb-f87f-4b11-9346-86ba6bfd26c9
md"""
关于比较运算， 最值得一提的是：比较运算可以连写
```julia
julia> 1 < 2 < 3 
ture
```
"""

# ╔═╡ 3cb76072-79bf-45b1-ae7d-1ee03df06135
md"""
## 逻辑运算符
逻辑运算符是施加到逻辑值（true，false）上的运算符。 逻辑运算符主要用于构造复合条件， 多用于程序流程控制。 主要是三种： 与（and）, 或（or）, 非（not）。 具体用法如下：

|运算符| 含义 | 用法|
|---|---|---|
| &&	| 与: 当且仅当两个操作数都是 true 时， 结果为true	| x && y|
|  \|\|	|或： 当至少有一个操作数为true时， 结果为true |	x \|\| y | 
| !	| 非： 将true变为false， false变为true | !x |

下面是几个例子， 其中`isodd`, `iseven`分别用于判断一个数是奇数和偶数。
"""

# ╔═╡ 6a3cee7c-9291-4d03-a79e-0e8c21ec4de2
md"""
## 运算符的优先级
完整的优先级列表可以参考[文档](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Operator-Precedence-and-Associativity)。 这里列出几个常用的。

```

单目运算符 
乘除 
加减 
冒号: 
比较 < >= <= == === != !== <: 
逻辑运算&& followed by || followed by ?
Pair => 
更新赋值 = += -= *= /= //= \= ^= ÷= %=
```
冒号运算符常见于构造向量， Pair用于构造配对数据。这些以后还会讲到。
"""

# ╔═╡ 73c0e3eb-1865-4858-99d8-2c40a7036e9a
!true + 3

# ╔═╡ f9254465-52be-44b4-befe-2a9e8af505cd
md"""
## 类型转化
在计算过程中， 需要的类型和提供的类型不同时， 系统通常会自动做合适的类型转化， 比如把整数变为浮点数等。 有时候， 如果我们要做强制的类型转化可以采用如下方式获得。
- **类型名（数值或数值变量）**
- **变量::类型名 = 数字**

```julia
julia> x = 16.0
julia> Int(x)
```
注意：当转化过程发生精度损失时， 转化会发生错误。 比如， 将带小数的浮点数转化为整数通常会出错（而不是截断小数部分）。
"""

# ╔═╡ 287b8da8-1b21-4c2a-b8cf-565bd294d8b4
typemax(Int64), typemax(Float64), 1/0, 0 * Inf

# ╔═╡ dda040fd-c623-4f1b-b77c-33014940beb3
md"""
## 常用数学函数
Julia 预定义了非常丰富的数学函数。一些常用的函数如下：

- 数值类型转换： 主要有T(x)和convert(T, x)。其中，T代表目的类型，x代表源值。
- 数值特殊性判断： 有isequal、isfinite、isinf和isnan。
- 舍入： 有四舍五入的round、向正无穷舍入的ceil、向负无穷舍入的floor，以及总是向0舍入的trunc。
- 绝对值获取： 用于获取绝对值的函数是abs(x)。一个相关的函数是，用于求平方的abs2(x)。
- 求根： 函数sqrt(x)用于求取x的平方根，而函数cbrt(x)则用于求取x的立方根。
- 求指数： 函数exp(x)会求取x的自然指数。另外还有expm1(x)，为接近0的x计算exp(x)-1。
- 求对数： log(x)会求取x的自然对数，log(b, x)会求以b为底的x的对数，而log2(x)和log10(x)则会分别以2和10为底求对数。另外还有log1p(x)，为接近0的x计算log(1+x)。

除了以上函数之外，Julia 的Base包中还定义了很多三角函数和双曲函数，比如sin、cos、atanh、acoth等等。另外，在SpecialFunctions.jl包里还有许多特殊的数学函数。不过这个包就需要我们手动下载了。

通常可以用`@doc 函数名`获取一个函数的帮助文档。
"""

# ╔═╡ 92ce7d04-5860-4de5-a0b3-3f77f3642be2
md"""

# 字符与字符串
字符和字符串也是一种常见的数据形式。简单来说， 字符串就是由字符构成的有限序列。 真正需要理解的是什么是字符。 由于Julia可以方便的处理Unicode编码。这里对字符与字符串做一个深入介绍。

## Unicode字符集
最常见的字符是英文字母、数字、一些标点符号等构成的常见字符集。 这个字符集通常采用ASCII编码，即：用0～127之间的整数来表示这些字符。

Unicode是国际标准字符集，它将世界各种语言的每个字符定义一个唯一的编码，以满足跨语言、跨平台的文本信息转换。 Unicode字符集的编码范围是0x0000 - 0x10FFFF , 可以容纳一百多万个字符， 每个字符都有一个独一无二的编码，也即每个字符都有一个二进制数值和它对应，这里的二进制数值也叫 **码点**, 比如：汉字 “中” 的码点是 0x4E2D, 大写字母 A 的码点是 0x41. 

理论上来说， 要表示所有Unicode字符， 需要三个字节。但如果每个字符都用三个字节， 那有些字符（比如英文字母等）就要浪费很多的存储空间。 UTF－8是一种unicode字符的存储方案， 它采用1～3个变长字节去存储码点值。 UTF－8的具体规则这里不讨论。 我们只需要知道， 每一个unicode字符都有一个“码点”，相当于整数。 然后其存储可能涉及1～3个字节就行， 其一个字节存储的，刚好是ASCII编码的字符， 也就是UTF－8是兼容ASCII编码的。

在Julia中， 用单引号包裹的单个对象就是一个字符， 其类型是： Char。 每一个Char在Julia中是一个32位（4个字节的）对象(可以通过sizeof查看其字节数）。 可以使用Int、Char非常方便的获得一个字符的码点（整数）以及将整数转化为一个字符。
```julia

julia> c = 'x'
'x': ASCII/Unicode U+0078 (category Ll: Letter, lowercase)

julia> sizeof(c)
32

julia> typeof(c)
Char

julia> c = Int('x')
120

julia> Char(120)
'x': ASCII/Unicode U+0078 (category Ll: Letter, lowercase)
```

在Julia中， 可以使用\u后跟最多四个十六进制数字或\U后跟最多八个十六进制数字（最长的有效值只需要六个）表示Unicode字符。

```julia

julia> '\u0'
'\0': ASCII/Unicode U+0000 (category Cc: Other, control)

julia> '\u78'
'x': ASCII/Unicode U+0078 (category Ll: Letter, lowercase)

julia> '\u2200'
'∀': Unicode U+2200 (category Sm: Symbol, math)

julia> '\U10ffff'
'\U10ffff': Unicode U+10FFFF (category Cn: Other, not assigned)
```
此外， Julia支持C风格的转义字符表示形式
```julia
julia> Int('\0')
0

julia> Int('\t')
9

julia> Int('\n')
10

julia> Int('\e')
27

julia> Int('\x7f')
127

julia> Int('\177')
127
```

由于字符是用整数表示的， 因此， 其可以做有限的一些数值运算和比较运算。

```julia

julia> 'A' < 'a'
true

julia> 'A' <= 'a' <= 'Z'
false

julia> 'A' <= 'X' <= 'Z'
true

julia> 'x' - 'a'
23

julia> 'A' + 1
```
"""

# ╔═╡ 83eaa69c-6e33-4b89-b4ab-ce42f3fff085
md"""
## 字符串 
字符串是用双引号或三引号包裹的字符序列。 三引号的表示方式的存在是为了方便表示字符串中本身存在双引号的情形。
```julia
julia> str = "Hello, world.\n"
"Hello, world.\n"

julia> \"""包含 "双引号" 的字符串\"""
"包含 \"双引号\" 的字符串"

```

有时候， 字符串可能跨行， 这只要用反斜杠加回车就行

```julia
julia> "这一行有点长，所以 \
       后面有一个回车！"
"这一行有点长，所以后面有一个回车！"
```



"""

# ╔═╡ 7df6d109-d148-403e-b5a5-8dbe80cfd419
md"""
## 字符串索引
由于字符串是一个序列，可以使用整数下标索引（index）这个序列。 只是要注意： 在julia中， **下标是从1开始的**。

```julia
julia> str[begin]
'H': ASCII/Unicode U+0048 (category Lu: Letter, uppercase)

julia> str[1]
'H': ASCII/Unicode U+0048 (category Lu: Letter, uppercase)

julia> str[6]
',': ASCII/Unicode U+002C (category Po: Punctuation, other)

julia> str[end]
'\n': ASCII/Unicode U+000A (category Cc: Other, control)
```

上面出现的两个关键字`begin`和`end`分别表示一个序列的最开始和最后一个元素的**合法下标**。 这两个关键字在索引的场景很常用。 可以把这两个关键词理解为两个整数。因此， 也可以用于运算。 


```julia

julia> str[end-1]
'.': ASCII/Unicode U+002E (category Po: Punctuation, other)

julia> str[end÷2]
' ': ASCII/Unicode U+0020 (category Zs: Separator, space)
```
有时候， 我们希望提取一个字符串的中间某些字符（子字符串）， 这时候可以使用冒号运算符:构建一个**下标范围**去提取。不过请注意：**用范围提取的结果是一个字符串， 就算只是提取了一个字符"**。

```julia
julia> str[4:9]
"lo, wo"

julia> str[6:6]
","

```

用下标范围的方式提取的子字符串，会自动复制一份返回。 但在有些场景下， 这个操作浪费时间和空间。 这时候， 可以使用`Substring(str, from, to)`实现构建字符串str的从from到to之间的视图, 其类型是SubString。 这样可以避免数据的复制。

```julia

julia> str = "long string"
"long string"

julia> substr = SubString(str, 1, 4)
"long"

julia> typeof(substr)
SubString{String}
```
"""

# ╔═╡ dab8c745-baa3-41e8-a8e9-3c33298aeb81
md"""
## 令人沮丧的字符串索引
你可能已经注意到， 上面在字符串提取的时候， 我强调要用合法的下标。 下标会不合法吗？ 由于Julia支持Unicode字符， 一个字符串里每一个字符所占用的空间通常为1～4不等。而下标表示的是基本的字符存储单位(**code unit**)—在这里是1个字节。通常， 如果一个下标在字符串所在的字节范围内就是一个**可行的下标**。不可行的下标意味着下标越界了。如果某个下标（相当于某个字节）是一个字符的中间某个字节， 这就不是一个**合法的下标**。只有当下标表示的字节位置刚好是一个字符的开始字节时， 下标才是合法的。 

```julia

julia> s = "\u2200 x \u2203 y"
"∀ x ∃ y"

julia> s[1]
'∀': Unicode U+2200 (category Sm: Symbol, math)

julia> s[2]
ERROR: StringIndexError: invalid index [2], valid nearby indices [1]=>'∀', [4]=>' '
Stacktrace:
[...]

julia> s[3]
ERROR: StringIndexError: invalid index [3], valid nearby indices [1]=>'∀', [4]=>' '
Stacktrace:
[...]

julia> s[4]
' ': ASCII/Unicode U+0020 (category Zs: Separator, space)

```

上面的第一个字符`∀`占了三个字节（三个单位）的存储空间。所以， 只有下标1是合法的。 下标2、3都不合法，得到的结果就是错误ERROR 。


"""

# ╔═╡ e65b2454-552a-4311-9bd3-a3c5135791fc
md"""
如果你处理的是英文文档， 下标的合法性是不需要考虑的（只要不越界就行）。 但如果处理中文文本， 这时候可能会比较棘手， 因为判断一个下标是否合法是一件很麻烦的事情。

为了解决这个问题， Julia提供了`lastindex(s)`:表示字符串s的最后一个合法下标；`firstindex(s)`表示字符串s的第一个合法下标(等价于`begin`和`end`两个下标关键字)。 这两个整数可以看做字符串合法下标的边界。 
此外， `nextind`和`prevind`两函数可以用于从一个给定的下标获取其后或其前的合法下标。其中：

- `nextind(s, i, n=1)`表示字符串s的第i个可行下标之后的第n个合法下标。
- `prevind(s, i, n=1)`表示字符串s的第i个可行下标之前的第n个合法下标。
以上两个函数的更多细节， 请参考帮助文档。 这两个函数可以方便的从两个方向遍历合法下标。 

如果想要得到所有的合法下标， 可以使用`collect(eachendex(s))`, 这里`eachindex`获取一个字符串的所有合法下标的“可迭代对象”， `collect`收集所有这些值。 后续介绍“容器”数据类型时还会进一步介绍这两个函数。

"""

# ╔═╡ ce2b97ef-b46b-4dbf-a568-f22f0764c08f
md"""
由于Julia支持Unicode编码， 一个常见的问题是：字符串的长度length(s)不一定等于字符串的最右一个下标(lastindex(s))。 
""" |> box(:yellow)

# ╔═╡ dc2792b8-8505-41c9-99af-c4105631a573
md"""
## 字符串拼接
尝尝需要将两个或多个字符串拼接成一个字符串， 在Julia中， 可以使用`string`函数:

```julia
julia> greet = "Hello"
"Hello"

julia> whom = "world"
"world"

julia> string(greet, ", ", whom, ".\n")
"Hello, world.\n"
```
有时候， 也可以使用＊运算符实现字符串拼接：
```julia
julia> greet * ", " * whom * ".\n"
```
"""

# ╔═╡ 93a96e12-9de1-4b3c-bfb1-59433178e0df
md"""
为什么用乘法＊而不是加法＋表示字符串拼接， 一个小理由是：Julia更强调符合数学习惯。在很多数学系统中， 加法是满足交换律的，而乘法不满足， 比如对矩阵来说就是这样。 字符串的拼接明显不符合交换律。所以采用了乘法符号*。
""" |> box

# ╔═╡ bc5f95ff-c8b5-4dec-bef8-4608fa6d8a19
md"""
一个更加强悍的拼接的函数是`join`。只是要拼接的对象需要构建在一个向量中（本质上可迭代对象中，后面再解释）

```julia

julia> join(["apples", "bananas", "pineapples"], ", ", " and ")
"apples, bananas and pineapples"

julia> join([1,2,3,4,5])
```

"""

# ╔═╡ 7cd671db-de36-492f-b63b-7f8347f8d5c0
md"""
## 字符串插值
字符串插值就是把一个值插入一个字符串。 Julia提供了非常方便的字符串插值方法。 只需要用一个\$符号，就可以把一个变量插入一个字符串。

```julia

julia> greet = "Hello"; whom = "world";

julia> "$greet, $whom.\n"
"Hello, world.\n"
```
"""

# ╔═╡ 73dc83ca-6f3f-4235-858e-b10e5fdf4cf2
md"""
你可以在下面的文本框中输入任何名字， 观察下面一行文本的变化。 `@bind name TextField(default="不告诉你")`, 注意， 这一行代码只是把你输入的内容，TextField的值，绑定@bind到了一个变量name。 如果你想了解更多这种UI项目， 可以参考Pluto的主界面上的介绍。 
"""

# ╔═╡ c35c0304-4d4e-4ee2-8695-5c3580a4a32e
@bind name TextField(default="不告诉你")

# ╔═╡ 9ee4481f-781e-416b-8da2-11d77a939c2e
"我的名字叫：$name"

# ╔═╡ 301e8bbc-e508-4035-8585-acaf05aaa21c
md"""
 上面只是简单的把一个变量的值插入字符串， 更有趣的场景是，把一个计算表达式的结果直接插入一个字符串。这时候， 只需要在\$符号后紧跟一对括号包裹表达式就好。

```julia
julia> "1 + 2 = $(1 + 2)"
"1 + 2 = 3"

julia> x = 10;
julia> "x=10，则sin(x)=$(sin(x))."
"x=10, 则sin(x)=-0.5440211108893698"
```
"""

# ╔═╡ 9095f986-815e-476a-8a1c-f3a2b5839d3a
md"""
## 常用操作汇总
- `sizeof` 获取字符串（任何对象都可以）占用的字节数。
- `length` 获取字符串的字符数量。
- `*` 字符串拼接， 也可以使用`string`函数。
- [i] 字符串索引(获取第i个字符）， 不过请注意Unicode字符串索引可能引发的问题。
- [i:j] 字符串截取（获取索引号从i到j的所有字符）。
- `$(var)` 用变量var的值插入字符串中。
- **搜索**。 `findfirst`, `findlast`, 请使用`@doc 函数名` 的方式获取其使用方法。
- occursin, contains 判断一个字符串是否包含某个子串（或模式）
- startswith， endswith 判断字符串是否以某个子串开头或结尾
- first, last 获取字符串前面或结尾的n个字符。
- `parse(type, str)`把一个字符串解释为某种类型。通常用于字符串转数值。
- `string`可以把数字转字符串。
"""

# ╔═╡ 52b91a5f-275f-4617-b132-c3522ad9226b
md"""
## 符号Symbol
在Julia中，有一种跟字符串非常相似的数据类型－－符号类型（Symbol）。 符号类型是在已解析的julia代码中用于表示标识符的类型， 也经常用作标识实体的名称或标签(例如，作为字典键)。 可以使用:操作符构建。 

符号跟变量名是不同的东西。变量名绑定了值。访问变量名就是访问相应的值。而符号代表的是被解析的代码（抽象语法树）中的标识符。通过对表达式求值eval，可以获得对应的值。 每一个变量名都会有一个对应的符号, 但Symbol不一定是变量。比如一个字典变量中的键。

**千万不要混淆Symbol和字符串。**
"""

# ╔═╡ c6e8c2eb-d77c-47b9-87aa-0a37a003ee7f
html"""
<style>
	pluto-helpbox header {
		/* uncomment the line below to see the effect! */
		/* background-color: red; */
	}
</style>
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Kroki = "b3565e16-c1f2-4fe9-b4ab-221c88942068"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
Kroki = "~0.2.0"
PlutoUI = "~0.7.55"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.3"
manifest_format = "2.0"
project_hash = "811b1193fe265d49ff91e218e74921884e7f1405"

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

[[deps.BitFlags]]
git-tree-sha1 = "2dc09997850d68179b69dafb58ae806167a32b1b"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.8"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "cd67fc487743b2f0fd4380d4cbd3a24660d0eec8"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.3"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "8cfa272e8bdedfa88b6aefbbca7c19f1befac519"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.3.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "dcb08a0d93ec0b1cdc4af184b26b591e9695423a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.10"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "abbbb9ec3afd783a7cbd82ef01dcd088ea051398"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.1"

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

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "7e5d6779a1e09a36db2a7b6cff50942a0a7d0fca"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.5.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.Kroki]]
deps = ["Base64", "CodecZlib", "DocStringExtensions", "HTTP", "JSON", "Markdown", "Reexport"]
git-tree-sha1 = "a3235f9ff60923658084df500cdbc0442ced3274"
uuid = "b3565e16-c1f2-4fe9-b4ab-221c88942068"
version = "0.2.0"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "c1dd6d7978c12545b4179fb6153b9250c96b0075"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.3"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "cc6e1927ac521b659af340e0ca45828a3ffc748f"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.12+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.2"

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
deps = ["SHA", "Serialization"]
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

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

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

[[deps.TranscodingStreams]]
git-tree-sha1 = "1fbeaaca45801b4ba17c251dd8603ef24801dd84"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.10.2"
weakdeps = ["Random", "Test"]

    [deps.TranscodingStreams.extensions]
    TestExt = ["Test", "Random"]

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
version = "1.2.13+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╟─5c3ad4ef-7e02-4e02-9802-f95dfc0ec626
# ╠═44ea8038-d4d3-4fcf-a0d7-6ef5cc63a3a7
# ╟─9aae89e6-ddc7-4363-a573-91cde91c943a
# ╟─5f8ae6a2-0bc0-4f50-a144-6c52281ce834
# ╟─09d1789b-243f-4008-a6a7-d25fe570abf7
# ╟─fda53176-6e05-4e0e-995b-b5d1d6c0d9f8
# ╟─ec6af47a-4bc5-49a0-bd3b-e5e9e9eddc4c
# ╟─fddfa92f-6efd-48cb-ba2a-7408ffef3275
# ╟─d48dec00-16d4-4970-b9ac-74e02408c1b9
# ╟─25be937b-32ee-4594-bf12-67fa7d383622
# ╟─f2346f33-9f66-4220-9fcb-e4772c1e3f5d
# ╠═1f12ccdf-6240-4fac-8ea2-298f0f700ef8
# ╠═e98b4282-b10d-4367-aba0-ba932975f677
# ╟─6213a746-a0c1-4b03-9518-ab204f75d36e
# ╟─ca13c3d0-6834-4475-b4f8-ded249f21579
# ╟─cbb38a16-20c3-4376-b8a5-73692a931df6
# ╟─136cb029-5e54-4034-a785-ee35388b24de
# ╟─b969accc-b93c-420f-9535-5b4124da2aea
# ╟─2c28f40f-3a22-4ea8-82e1-300eb48b204c
# ╟─fdf47379-59c5-46ef-ba25-b491ea7be10a
# ╟─c9d58a4d-8e16-4c4c-88fe-ef4f61ccb3fd
# ╟─5cada891-e82e-4a76-ac54-10e514f78ddc
# ╟─14e3f7cc-8fa0-4873-a9ec-e77418b9214a
# ╟─2ae0bca5-8955-4430-b44d-ea70f5cd4657
# ╟─d1685ebb-f87f-4b11-9346-86ba6bfd26c9
# ╟─3cb76072-79bf-45b1-ae7d-1ee03df06135
# ╟─6a3cee7c-9291-4d03-a79e-0e8c21ec4de2
# ╠═73c0e3eb-1865-4858-99d8-2c40a7036e9a
# ╟─f9254465-52be-44b4-befe-2a9e8af505cd
# ╠═287b8da8-1b21-4c2a-b8cf-565bd294d8b4
# ╟─dda040fd-c623-4f1b-b77c-33014940beb3
# ╟─92ce7d04-5860-4de5-a0b3-3f77f3642be2
# ╟─83eaa69c-6e33-4b89-b4ab-ce42f3fff085
# ╟─7df6d109-d148-403e-b5a5-8dbe80cfd419
# ╟─dab8c745-baa3-41e8-a8e9-3c33298aeb81
# ╟─e65b2454-552a-4311-9bd3-a3c5135791fc
# ╟─ce2b97ef-b46b-4dbf-a568-f22f0764c08f
# ╟─dc2792b8-8505-41c9-99af-c4105631a573
# ╟─93a96e12-9de1-4b3c-bfb1-59433178e0df
# ╟─bc5f95ff-c8b5-4dec-bef8-4608fa6d8a19
# ╟─7cd671db-de36-492f-b63b-7f8347f8d5c0
# ╠═73dc83ca-6f3f-4235-858e-b10e5fdf4cf2
# ╠═c35c0304-4d4e-4ee2-8695-5c3580a4a32e
# ╠═9ee4481f-781e-416b-8da2-11d77a939c2e
# ╟─301e8bbc-e508-4035-8585-acaf05aaa21c
# ╟─9095f986-815e-476a-8a1c-f3a2b5839d3a
# ╟─52b91a5f-275f-4617-b132-c3522ad9226b
# ╠═c6e8c2eb-d77c-47b9-87aa-0a37a003ee7f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
