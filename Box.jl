### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ 9e39b191-4f86-4718-b435-e87f08ea6069
begin
function box(color::Symbol = :green, title::Union{String,Nothing} = nothing)
	#@assert color in [:green, :yellow, :blue, :red]
	function green(text)
   		Markdown.MD(Markdown.Admonition("tip", ifelse(isnothing(title),"✍🏻️ 插播", title), [text])) # 绿色
	end

	function yellow(text)
		Markdown.MD(Markdown.Admonition("warning",ifelse(isnothing(title),"👀 注意", title),  [text])) # 黄色
	end

	function blue(text)
		Markdown.MD(Markdown.Admonition("hint", ifelse(isnothing(title),"👁️ 提示", title), [text])) # 蓝色
	end

	function red(text)
		Markdown.MD(Markdown.Admonition("danger", ifelse(isnothing(title), "🚦 警告", title), [text])) # 红色
	end

	function other(text)
		Markdown.MD(Markdown.Admonition("info", ifelse(isnothing(title),"", title), [text])) # 默认
	end

	if color == :green
		return green
	elseif color == :yellow
		return yellow
	elseif color == :blue
		return blue
	elseif color == :red
		return red
	else
		return other
	end
	
end
# ====================================================
#如果直接用名字， 相当于提供信息。
box(text::Markdown.MD) = box(:green,nothing)(text)

# 如果直接用hint， 相当于提示：
hint(text::Markdown.MD) = box(:blue,nothing)(text)
hintbox(text::Markdown.MD) = box(:blue,"")(text)
# 如果直接用无参数box， 相当于给出一个真正的框。
box() = box(:green, "")
# 只给颜色， 用默认标题， 不需要标题， 需要用空字符串表示
box(color::Symbol) = box(color, nothing)
box(title::String) = box(:green, title) # 只给文本， 默认就是绿色
# 文本和颜色，可以交换着给
box(title::String, color::Symbol) = box(color, title)
# 如果给两个Symbol， 则后一个当成标题
box(color::Symbol, title::Symbol) = box(color, String(title))
# 如果给两个Stiring， 则前一个当成颜色
box(color::String, title::String) = box(Symbol(color), title)

	# ==============

	
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

end


# ╔═╡ 2da1b144-5ca4-43b1-b352-0cee59a22b70
begin
struct Foldable{C}
    title::String
    content::C
end

fboxstyle = """
	<style>
details > summary {
  padding: 2px 6px;
  background-color: #ccf;
  border: none;
  <!-- box-shadow: 3px 3px 4px black; -->
  cursor: pointer;
border-radius: 0 25px 25px 0 ;
	border-width:0 0 0 5px;
	border-color: green;
}

details {
  border-radius: 0 0 10px 10px;
  background-color: #ccf;
  padding: 2px 6px;
  margin: 0;
  <!-- box-shadow: 3px 3px 4px black; -->
border-radius: 0 25px 25px 0 ;
	border-width:0 0 0 5px;
	border-color: green;
}

details[open] > summary {
  background-color: #ccf;
}

</style>	


	
"""
function Base.show(io, mime::MIME"text/html", fld::Foldable)

	write(io, fboxstyle)
	write(io,"""<details><summary>$(fld.title)</summary><p>""")
    show(io, mime, fld.content)
    write(io,"</p></details>")
end

function fbox(str::Markdown.MD, title = "参考答案")
	Foldable(title,str)
end

end

# ╔═╡ b216450f-5bda-4fd3-a653-6dc48935e93d
md"""
## 题目定义
下面是定义题目的代码
"""

# ╔═╡ 30026fc0-7d93-41d9-a3ee-d787f6b0652d
	struct Exercise{C}
    content::C
	end

# ╔═╡ ccfa0499-1d08-42d6-b786-3d55dbf1c039
begin
exerstyle = """
<style>
.exercise {
	border-style:dotted solid solid;
    border-radius: 0 25px 25px 0 ;
	border-width:0 0 0 5px;
	border-color: green;
	background-color:#ccf;
}
</style>

"""

function Base.show(io, mime::MIME"text/html", ex::Exercise)

	write(io, exerstyle)
	write(io,"""<div class = "exercise">""")
    show(io, mime, ex.content)
    write(io,"</div>")
end

function timu(str::Markdown.MD)
	Exercise(str)
end

end

# ╔═╡ 89659943-80a3-451e-8e76-ee82c534adc8
md"""
还有一些数学的东西$f(x) = x^2$
""" |> timu

# ╔═╡ 4ec4c5e0-fd8e-4c96-8b2d-3ff0533eb7ac
md"""
# 这里可以学到不少技巧
[看这里](https://www.andreaskroepelin.de/blog/plutoslides/)
"""

# ╔═╡ 84ec26b8-8113-4723-aa8c-85ac69348176
md"""
这里是随便写，f(x) = x$21
""" |>fbox

# ╔═╡ 232dd856-f12b-47f0-a3af-d0465d709763
VERSION

# ╔═╡ 7ea8df5a-1b14-4baa-8ee3-67102dff71a0
md"""
## 双栏

"""

# ╔═╡ dd0cf88d-f3a5-485f-894a-eef9bada7dde
begin
struct TwoColumn{L, R}
    left::L
    right::R
end

function Base.show(io, mime::MIME"text/html", tc::TwoColumn)
    write(io, """<div style="display: flex;"><div style="flex: 80%;">""")
    show(io, mime, tc.left)
    write(io, """</div><div style="flex: 50%;">""")
    show(io, mime, tc.right)
    write(io, """</div></div>""")
end
end

# ╔═╡ b65f5bf6-4ed4-4721-9790-9e7bc2fb0bf3
@doc md"""
```julia
julia> x = "hello"
julia> y = "world"
$(let x = "hello", y = "world"
x*y
end)
end
```
"""

# ╔═╡ 6518f2be-51c3-46c7-ac57-21cb5b11f483
"""
# The Foo Function
`foo(x)`: Foo the living hell out of `x`.
"""
foo(x) = 5

# ╔═╡ ba7981b5-1ccd-4134-ad5d-fa5a29a7232f
@doc foo

# ╔═╡ Cell order:
# ╠═9e39b191-4f86-4718-b435-e87f08ea6069
# ╠═2da1b144-5ca4-43b1-b352-0cee59a22b70
# ╠═b216450f-5bda-4fd3-a653-6dc48935e93d
# ╠═30026fc0-7d93-41d9-a3ee-d787f6b0652d
# ╠═ccfa0499-1d08-42d6-b786-3d55dbf1c039
# ╟─89659943-80a3-451e-8e76-ee82c534adc8
# ╟─4ec4c5e0-fd8e-4c96-8b2d-3ff0533eb7ac
# ╟─84ec26b8-8113-4723-aa8c-85ac69348176
# ╠═232dd856-f12b-47f0-a3af-d0465d709763
# ╠═7ea8df5a-1b14-4baa-8ee3-67102dff71a0
# ╠═dd0cf88d-f3a5-485f-894a-eef9bada7dde
# ╠═b65f5bf6-4ed4-4721-9790-9e7bc2fb0bf3
# ╠═6518f2be-51c3-46c7-ac57-21cb5b11f483
# ╠═ba7981b5-1ccd-4134-ad5d-fa5a29a7232f
