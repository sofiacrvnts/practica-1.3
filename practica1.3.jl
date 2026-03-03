# Usuarios de DataScienceter
usuarios = [
    (id=1, nombre="Hero", experiencia=5.0, salario=80000),
    (id=2, nombre="Dunn", experiencia=2.0, salario=40000),
    (id=3, nombre="Sue", experiencia=5.0, salario=75000),
    (id=4, nombre="Chi", experiencia=8.0, salario=110000),
    (id=5, nombre="Thor", experiencia=2.0, salario=45000),
]

#Implementacion de Insertion Sort
function insertion_sort!(A, by)
    n = length(A)
    for j in 2:n
        key = A[j]
        i = j - 1
        while i > 0 && by(A[i]) > by(key)
            A[i + 1] = A[i]
            i -= 1
        end
        A[i + 1] = key
    end
    return A
end

#Uso: Ordenar por salario 
#insertion_sort!(usuarios, x -> x.salario)

#Implemetación de Selection Sort
function selection_sort!(A, by)
    n = length(A)
    for i in 1:n-1
        #min_index es el indice del elemento mas pequeño encontrado
        min_index = i
        for j in i+1:n
            #by(A[j]) compara por la columna elegida
            #Comparar el elemento actual con el elemento más pequeño encontrado
            #Si el elemento actual es más pequeño, actualizar min_index
            if by(A[j]) < by(A[min_index])
                min_index = j
            end
        end
        A[i], A[min_index] = A[min_index], A[i]
    end
    return A
end

#Implementación de Bubble Sort
function bubble_sort!(A, by)
    n = length(A)
    for i in 1:n-1
        for j in 1:n-i
            #Comparar el elemento actual con el siguiente elemento
            #Si el elemento actual es mayor que el siguiente, intercambiarlos
            if by(A[j]) > by(A[j + 1])
                A[j], A[j + 1] = A[j + 1], A[j]
            end
        end
    end
    return A
end

#---Demostracion de estabilidad---

#Experimento con Selection Sort
#Ordena a los usuarios por experiencia 
println("Selection Sort:")
usuarios_selection = copy(usuarios)
selection_sort!(usuarios_selection, x -> x.salario)
selection_sort!(usuarios_selection, x -> x.experiencia)
for u in usuarios_selection
    println(u)
end

#Experimento con Insertion Sort
#Ordena a los usuarios por salario 
println("\nInsertion Sort:")
usuarios_insertion = copy(usuarios)
insertion_sort!(usuarios_insertion, x -> x.salario)
insertion_sort!(usuarios_insertion, x -> x.experiencia)
for u in usuarios_insertion
    println(u)
end

#---Series de tiempo---
using Random
#Generar datos aleatorios para salarios y experiencia
function generar_serie_tiempo(N)
    #Genera N timestamps ordenados 
    tiempos = collect(1:N)
    #Desordena aleatoriamente solo el 2% de los datos (ruido de red)
    ruido = Int(floor(N * 0.02))
    for _ in 1:ruido
        idx1 = rand(1:N)
        idx2 = rand(1:N)
        tiempos[idx1], tiempos[idx2] = tiempos[idx2], tiempos[idx1]
    end
    return tiempos
end
#Crear los datos de la serie de tiempo
N = 20_000
datos_casi_ordenados = generar_serie_tiempo(N)
datos_aleatorios = shuffle(collect(1:N))

#Medir tiempos de ejecución
println("\nTiempos de ejecución:")
t1 = @elapsed insertion_sort!(copy(datos_aleatorios), x -> x) 
t2 = @elapsed insertion_sort!(copy(datos_casi_ordenados), x -> x)
t3 = @elapsed selection_sort!(copy(datos_aleatorios), x -> x)
t4 = @elapsed selection_sort!(copy(datos_casi_ordenados), x -> x)

println("Insertion Sort - Datos Aleatorios: $t1 segundos")
println("Insertion Sort - Datos Casi Ordenados: $t2 segundos")
println("Selection Sort - Datos Aleatorios: $t3 segundos")
println("Selection Sort - Datos Casi Ordenados: $t4 segundos")
