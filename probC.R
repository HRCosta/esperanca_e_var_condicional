# probC.R - � um programa para an�lise de probabilidade condicional
# Copyright (c) 2021 Henrique Regis Costa <henrique260293@gmail.com>
# Copyright (c) 2021 Tha�s Regis Costa <thasregiscosta@gmail.com>
# Este arquivo � distribuido sob a licen�a GPLv3.

#carga da base de dados e atribui��o da mesma para a vari�vel 't'(table) (formato CSV UTF-8)
#substitua path pelo caminho relativo do seu data_set
t <- read.csv("C:/Users/Henrique/Desktop/probabilidade/problema/data_set_problema.csv", header=TRUE)

#exibe no console o conte�do da vari�vel 't'
t

#atribui � 'a' a tabela de probabilidades oriunda da tabela de contagem (conting�ncia) contida na vari�vel 't'
a <- prop.table(t)
#exibe no console o conte�do da vari�vel 'a'
a

#tranforma 'a' em uma matriz e atribui � vari�vel 'b'
b <- as.matrix(a)
#exibe no console o conte�do da vari�vel 'b'
b

#gera tabela 'mDist' que � b com somas marginais
mDist <- addmargins(b)

#armazena em 'd' a tabela de probabilidades condicionais obtida a partir da tabela de probabilidades contida na vari�vel 'a'
# margin => soma marginal | margin = 1 condi��o na "dimens�o 1" => X | margin = 2 condi��o na "dimens�o 2" => Y
d <- prop.table(b, margin=2)
#exibe no console o conte�do da vari�vel 'd'
d

#atribui � c (colum) o n�mero de colunas da matriz d, l(line) o n�mero de linhas da matriz d
c <- as.integer(ncol(d))
l <- as.integer(nrow(d))
#exibe no console os conte�dos das vari�veis c e l
c
l

#itera��es para gera��o de E e VAR

#contadores iniciados com valor 1 para realizar itera��es at� um n-�simo valor desejado
i <- 1
j <- 1
k <- 1
m <- 1

#vetores de tamanho "c - n�mero de colunas" para acumular resultados
e <- 1:c
e2 <- 1:c
var <- 1:c

#Itera��o para c�lculo de E e Var

#enquanto o contador k estiver entre 1 e c - n�mero de colunas executa as a��es que est�o entre as chaves do la�o externo
for(k in 1:c){
  
  #atribui��o de valor 0 na posi��o k-�sima do vetor 'e' (objetivo de evitar "res�duos")
  e[k] = 0
  
  #la�o da 'expectation' aplica a f�rmula para cada linha e acumula um novo valor ao k-�simo 'e' a cada itera��o
  for(i in 1:l){
    e[k] = e[k] + ((i) * d[i, k])
  }
  
  #atribui��o de valor 0 na posi��o k-�sima do vetor 'e2' (objetivo de evitar "res�duos")
  e2[k] = 0
  
  #la�o do 'e^2' aplica a f�rmula para cada linha e acumula um novo valor ao k-�simo 'e2' a cada itera��o
  for(j in 1:l){
    e2[k] = e2[k] + ((j)^2 * d[j, k])
  }
}

#a partir de 'e' e 'e2', calcula Var da posi��o m = 1 at� c - n�mero de colunas e acumula no vetor var da posi��o m =1 at� c 
for(m in 1:c){
  var[m] = 0
  var[m] = e2[m] - e[m]^2
}

#exibe no console resultados de expectation e var
e
var

#Itera��o para cria��o dos gr�ficos das distribui��es marginais
n <- 1
o <- 1
yMg <- 0
xMg <- 0
y <- 1:c
x <- 1:l

#la�o que cria vetor P(Y)
for(n in 1:c){
  yMg[n] = 0
  yMg[n] = mDist[l+1,n]
}

#la�o que cria vetor P(X)
for(o in 1:l){
  xMg[o] = 0
  xMg[o] = mDist[o,c+1]
}

#Cria��o de tabela com valores de x e seus respectivos P(x)
yplot <- as.table(setNames(yMg,y))
#Exibe tabela xplot
yplot
#Cria��o de tabela com valores de y e seus respectivos P(y)
xplot <- as.table(setNames(xMg,x))
#Exibe tabela yplot
xplot

#exibe tabela mDist (probabilidade e somas marginais)
mDist 

#plota gr�ficos das somas marginais
barplot(yplot, ylab="Probabilidade", xlab="valores de y", col="lightblue")
barplot(xplot, ylab="Probabilidade", xlab="valores de x", col="lightblue")

#plota gr�fico da distribui��o conjunta (usar d como refer�ncia para os valores das barras)
barplot(d, beside=TRUE)
#exibe 'd' no console
d





