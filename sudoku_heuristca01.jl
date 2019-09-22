
tam_n=3
#criar matrizes
su = zeros(tam_n, tam_n)
M_adj =zeros(tam_n*tam_n, tam_n*tam_n)
su_cor=zeros(tam_n, tam_n)

cont=1
#enumerando sudoku, definindo vertices
for x in 1:tam_n
    global cont
    for j in 1:tam_n
        su[x,j]=cont
        cont+=1
    end
end

#Montando quadrante
cl = []
quad = Int(tam_n/3)
#(x-linha, y-coluna)
append!(cl,[su[1:quad, 1:quad]])
append!(cl,[su[1:quad, quad+1:2*quad]])
append!(cl,[su[1:quad, 2*quad+1:3*quad]])
append!(cl,[su[quad+1:2*quad, 1:quad]])
append!(cl,[su[quad+1:2*quad, quad+1:2*quad]])
append!(cl,[su[quad+1:2*quad, 2*quad+1:3*quad]])
append!(cl,[su[2*quad+1:3*quad, 1:quad]])
append!(cl,[su[2*quad+1:3*quad, quad+1:2*quad]])
append!(cl,[su[2*quad+1:3*quad, 2*quad+1:3*quad]])

arestas= Dict{Int, Any}()
ps=1
for k in cl
    global ps
    #println("linha $k \n")
    for x in k
        #println("$x")
        i=1
        while i <= tam_n
            if ∈(x, su[i, 1:tam_n])
                ar=[]
                for j in k
                    if j != x
                        append!(ar, j) #QUADRANTE
                    end
                end
                for j in 1:tam_n #LINHA
                    if !(∈(su[i, j], ar)) && su[i, j] != x
                            append!(ar, [su[i, j]])
                    end
                    if ∈(x, su[i, j]) #COLUNA
                        for n in 1:tam_n
                            if !(∈(su[n, j], ar)) && su[n, j] != x
                                    append!(ar, [su[n, j]])
                            end
                        end
                    end
                end
                arestas[ps]=ar
                ps+=1
            end
            i+=1
        end
    end
end
cont =1
for k in cl
    global cont
    #println("\nSetor $k\n")
    for x in k
        for i in arestas[cont]
            #println(Int(x),"X:,Y: $i")
            M_adj[Int(x), Int(i)]=1.0
        end
        cont+=1
    end
end

#COLORIR M_adjFO
cor=1
l_cor=[cor]
t_cor=[]
#deleteat!(t_cor, 1:3)
#println(t_cor)

while ∈(0, su_cor)
    global su_cor, l_cor, cor, t_cor

    #res = 0
    for x in 1:tam_n
        y=1
        while y <= tam_n
            #novo=false
            if su_cor[x, y] == 0.0
                #new_cor=true
                ad = []
                ad = M_adj[Int(su[x, y]), 1:Int(tam_n*tam_n)] #pegando linha Matriz adjacent

                if t_cor == []
                    append!(t_cor, l_cor)
                end
                res = t_cor[1]
                while t_cor != []
                    c=t_cor[1]
                    colorir= true
                    #posição coluna Matriz adjacent, verificar se adj tem MESMA COR
                    for p in 1:length(ad)
                        if ad[p]==1
                            for x2 in 1:tam_n
                                for y2 in 1:tam_n
                                    if su[x2,y2] == p && su_cor[x2, y2] == c #adjacent já tem a cor
                                        colorir = false
                                        break
                                    end
                                end
                                if colorir == false
                                    break
                                end
                            end
                        end
                    end
                    if colorir == true
                        su_cor[x, y] = c
                        popfirst!(t_cor)
                        break
                    end
                    popfirst!(t_cor)
                    if t_cor == []
                        if res != 1
                            append!(t_cor, l_cor[1:res-1])
                            res=1
                        else
                            cor+=1
                            su_cor[x, y] = cor
                            append!(l_cor, [cor])
                        end
                        #res=1
                    end
                end
            end
            y+=1
        end
    end
end

println("\n Cor: $cor")
for kk in 1:tam_n
    println(su_cor[kk, 1:tam_n])
end


l=[]
#montar arestas
for x in 1:tam_n
    #append!(l, x)
    for y in 1:tam_n
        if M_adj[x, y] ==1
            #println("$x -- $y;")
            if !(∈((x,y), l)) && !(∈((y,x), l))
                append!(l, [(x,y)])
            end
        end
    end
end


#mprmr arestas
for x in 1:length(l)
    println(l[x][1]," -- ",l[x][2])
end
#=
cores = Dict{Int, Any}()
cores[1] = "aliceblue"
cores[2] = "blueviolet"
cores[3] = "cyan"
cores[4] = "darkgreen"
cores[5] = "darkorange"
cores[6] = "deeppink"
cores[7] = "firebrick"
cores[8] = "ghostwhite"
cores[9] = "green"
cores[10] = "indigo"
cores[11] = "lawngreen"
cores[12] = "lightsalmon"
cores[13] = "magenta"
cores[14] = "mediumpurple"
cores[15] = "antiquewhite"
cores[16] = "coral"
cores[17] = "cyan"
cores[18] = "darkblue"
cores[19] = "deepskyblue"
cores[20] = "gold"
cores[21] = "lightseagreen"
cores[22] = "yellow"
cores[23] = "goldenrod"
cores[24] = "red"
cores[25] = "olive"
cores[26] = "tomato"
cores[27] = "silver"
cores[28] = "skyblue"
cores[29] = "palegreen"
cores[30] = "gainsboro"

#Montar cor
#println("CORES")
for x in 1:9
    #append!(l, x)
    for y in 1:9
        println(Int(su[x,y])," [style=\"filled\",fillcolor=\"",cores[su_cor[x,y]],"\",shape=box];")
    end
    #println(l)

end=#
