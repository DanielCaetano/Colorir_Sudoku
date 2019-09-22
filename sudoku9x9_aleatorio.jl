su = zeros(9, 9)
gra =zeros(81, 81)
su_cor=zeros(9, 9)

cont=1
#enumerando sudoku, definindo vertices
for x in 1:9
    global cont
    for j in 1:9
        su[x,j]=cont
        cont+=1
    end
end

#Montando quadrante
cl = []
append!(cl,[su[1:3, 1:3]])
append!(cl,[su[1:3, 4:6]])
append!(cl,[su[1:3, 7:9]])
append!(cl,[su[4:6, 1:3]])
append!(cl,[su[4:6, 4:6]])
append!(cl,[su[4:6, 7:9]])
append!(cl,[su[7:9, 1:3]])
append!(cl,[su[7:9, 4:6]])
append!(cl,[su[7:9, 7:9]])

#
arestas= Dict{Int, Any}()
ps=1
for k in cl
    global ps
    #println("linha $k \n")
    for x in k
        #println("$x")
        i=1
        while i <= 9
            if ∈(x, su[i, 1:9])
                ar=[]
                for j in k
                    if j != x
                        append!(ar, j) #QUADRANTE
                    end
                end
                for j in 1:9 #LINHA
                    if !(∈(su[i, j], ar)) && su[i, j] != x
                            append!(ar, [su[i, j]])
                    end
                    if ∈(x, su[i, j]) #COLUNA
                        for n in 1:9
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
            gra[Int(x), Int(i)]=1.0
        end
        cont+=1
    end
end


#println(gra[33, 1:81])
#COLORIR GRAFO
loop = 0
geracao = 0
while ∈(0, su_cor)
    global loop, su_cor, geracao
    if loop ==500
        falta=0
        for xx in 1:9
            for yy in 1:9
                if su_cor[xx,yy]==0.0
                    falta+=1
                end
            end
        end
        println("\n Geração: $geracao , Falta: $falta")
        for kk in 1:9
            println(su_cor[kk, 1:9])
        end
        su_cor=zeros(9, 9)
        loop=0
        geracao+=1
    end
    cor=rand(1:10)
    posX=0
    posY=0
    res=false

    for x in 1:9
        res=false
        for y in 1:9
            if su_cor[x, y] == 0.0
                posX=x
                posY=y
                res=true
                break
            end
        end
        if res==true
            break
        end
    end
    #posX= rand(1:9)
    #posY= rand(1:9)
    if su_cor[posX, posY] == 0.0
        ad=[]
        ad= gra[Int(su[posX, posY]), 1:81]
        colorir= true
        for p in 1:length(ad)
            if ad[p]==1
                for x in 1:9
                    for y in 1:9
                        if su[x,y] == p && su_cor[x, y] == cor
                            colorir = false
                        end
                    end
                end
            end
        end
        if colorir == true
            su_cor[posX, posY] = cor
        end
    end
    loop+=1
end

falta=0
for xx in 1:9
    for yy in 1:9
        if su_cor[xx,yy]==0.0
            falta+=1
        end
    end
end
loop-=1
println("\n Geração: $geracao , Falta: $falta, Loop: $loop")
for kk in 1:9
    println(su_cor[kk, 1:9])
end
l=[]
for x in 1:81
    #append!(l, x)
    for y in 1:81
        if gra[x, y] ==1
            #println("$x -- $y;")
            if !(∈((x,y), l)) || !(∈((y,x), l))
                append!(l, [(x,y)])
            end
        end
    end
    #println(l)

end

for x in 1:length(l)
    println(l[x][1]," -- ",l[x][2])
end
#println(l)

#Montar cor
println("CORES")
for x in 1:9
    #append!(l, x)
    for y in 1:9
        println("\"",su[x,y],"\"","[style=\"filled\",fillcolor=\"",su_cor[x,y],"\",shape=box];")
    end
    #println(l)

end
