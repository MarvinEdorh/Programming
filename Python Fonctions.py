############################### Initiation Python pour Calculs et Fonctions ###################################

import os; os.chdir('C:/Users/marvi/Desktop/MsMDA/AutoFormation/Python')
import pandas as pd
data_test = pd.read_csv('Data_analyst_test.csv', sep=";")

############################################### Fonctions D'aggrégation ########################################## 

data_test.mean() #par défaut moyenne de toutes les colonnes avec variable numérique
data_test['CONNECTED'].sum() #pour une variable precise (ici la variable "CONNECTED")
data_test.min() 
data_test.max()
data_test.prod() 
data_test.var()
data_test.std() #standard deviation (normalisés par défaut par n - 1)
data_test.median() 
data_test.quantile(q = 0.25) #quantile
data_test.mad() #median absolute deviate.
data_test.nunique() #nombre de valeurs uniques.
data_test.rank() #rang dans le groupe.

#dataframe avec la moyenne de toutes les variables numérique
data_test_avg=pd.DataFrame(data_test.mean(), columns = ['Avg'])
print(data_test_avg)
 
#dataframe avec la sum de toutes les variables numérique groupée par une vriable
data_test_sum_OS = pd.DataFrame(data_test.groupby('OS').sum()) 
print(data_test_sum_OS)

#dataframe avec la sum de toutes les variables numérique groupée par plusieurs vriable
data_test_avg_OS_COUNTRY = pd.DataFrame(data_test.groupby(['OS','COUNTRY']).sum()) 
print(data_test_avg_OS_COUNTRY)

################################ Calculer une nouvelle variable #################################### 
data_test_sum_OS['average_likes_sent'] = data_test_sum_OS['LIKES_SENT'] / data_test_sum_OS['CONNECTED']

##################################### fonction #################################################

def compteur3():
    i = 0
    while i < 3:
        print(i)
        i = i + 1
compteur3()

# fonctions paramétriques
def compteur(stop):
    i = 0
    while i < stop:
        print(i)
        i = i + 1

compteur(15)

def compteur_complet(start, stop, step):
    i = start
    while i < stop:
        print(i)
        i = i + step

compteur_complet(1, 7, 2)

#procedures
def cube(w):
    return w**3

cube(3)
a = cube(4)
a

#paramètre par défaut
def politesse(nom, titre ="Mr"):
    print("Veuillez agréer,", titre, nom, ", mes salutations distinguées.")
    
politesse("Dupont")
politesse('Durand', 'Ms')

def mesure(sujet="je", verbe="mesure", quantite=175, unite="cm"):
    print(sujet, verbe, quantite, unite)

mesure()
mesure('il')
mesure(verbe='pese')
mesure(unite = "kg", verbe = "pese"  )
mesure(unite = "kg", verbe = "pese", quantite = 80 )


 #V=(4/3)πR**3

def cube(n):
    return n**3
        
def volume_sphere(r):
    return 4 / 3 * np.pi * cube(r)

r = float(input("Entrez la valeur du rayon : "))
print("Le volume de cette sphere vaut", volume_sphere(r))
