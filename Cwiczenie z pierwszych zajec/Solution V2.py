import pandas as pd

# Wczytanie plików Excel
df = pd.read_excel('Klucz.xlsx') # wczytywanie kluczów
df_solution = pd.read_excel('Egzaminy rozwiązane.xlsx', 'Tabela przestawna') # wczytywanie rozwiązania 

# Wyświetlenie pierwszych 3 wierszy
#print(df.head(3))

# Przypisywanie poprawnych odpowiedzi do listy
test_1_correct_answers = df['popr'].tolist()
test_2_correct_answers = df['popr.1'].tolist()

#print(test_1_correct_answers[0:3])
#print(test_2_correct_answers[0:3])

# Otwórz plik z odpowiednim kodowaniem UTF-16, 'r' usuwa białe znaki
with open('egzaminy.txt', 'r', encoding='utf-16') as file:
    lines = file.readlines()

# Wyświetl zawartość
#print(lines)

# Striping, usuwa puste znaki z początku i na końcu
tests_responses = []
for line in lines:
    tests_responses.append(line.strip()) # tutaj musiałem doczytać o .strip() 
    

# deklarowanie słownika
dict_of_responses = {} 
#Wyświetl wczytane linie
for line in tests_responses: # usunąć [:8] jeżeli będę chiał sprawdzić wszystkich studentów tests_responses[:8] na tests_responses
    #print(line)  
    student_id = line[0:4] # str type()
    response_card = line[4:5] # str type() 1 and 2
    exam_id = line[6:7] # str
    student_responses = line[7:108] # str type()
    points = 0
    if student_id not in dict_of_responses:
        dict_of_responses[student_id] = [exam_id, student_responses, points] # points to dict_of_responses[student_id][2]
    else: # if student_id exist in dict_of_responses
        dict_of_responses[student_id][1] += student_responses  # += poniewż to string 
        # tutaj musiałem doczytać jak się odwołać do drugiej wartości w liście będącej w słowniku

for student_id, (exam_id, responses, points) in dict_of_responses.items():
    # Wyświetlanie danych dla sprawdzenia
    #print(f"Student ID: {student_id}")
    #print(f"Exam ID: {exam_id}")
    #print(f"Responses: {responses}")
    #print("-" * 30,'\n')  # separator dla czytelności
    
    # Sprawdzanie odpowiedzi
    if exam_id == '1': # ważne aby 1 było pomiędzy '' ponieważ to string, a nie int lub integer
        # pierwsza wersja egzaminu
        for index, response in enumerate(responses):
            #print(index, response, test_1_correct_answers[index])
            if response == test_1_correct_answers[index]:
                points += 1
                #print(points, '\n')
                dict_of_responses[student_id][2] = points
            else:
                continue
            
    if exam_id == '2':
        # druga wersja egzaminu
        for index, response in enumerate(responses):
            #print(index, response, test_2_correct_answers[index])
            if response == test_2_correct_answers[index]:
                points += 1
                #print(points, '\n')
                dict_of_responses[student_id][2] = points
            else:
                continue
        
    # Wrzucamy wyniki do listy by potem sprawdzić poprawność wyników 
    student_id_list = []
    sum_points_list = []
    for student_id, (exam_id, responses, points) in dict_of_responses.items():
        # Wyświetlanie danych
        #print(f"Student ID: {student_id}")
        #print("-" * 30)  # separator dla czytelności
        #print(f"Exam ID: {exam_id}")
        #print(f"Points: {points}\n")
        student_id_list.append(student_id)
        sum_points_list.append(points)
     
# Sprawdzanie poprawności wyniku   
df_solution = df_solution.sort_values(by='Etykiety wierszy')
df_solution_student_id_list = df_solution['Etykiety wierszy'].tolist() 
df_solution_sum_points_list = df_solution['Suma z Punkt'].tolist() 
#print(df_solution_student_id_list[0:4])
#print(df_solution_sum_points_list[0:4])

#print(df_solution_student_id_list == student_id_list)
#print(df_solution_sum_points_list == sum_points_list)

#print(student_id_list)
#print(sum_points_list)

#print('\nWyświetlanie i sprawdzanie indexów')
#print(len(df_solution_student_id_list))
#print(len(student_id_list))
#print(len(df_solution_sum_points_list))
#print(len(sum_points_list))

for index, student_id in enumerate(student_id_list): # Sprawdzanie indeksów
    if student_id != df_solution_student_id_list[index]:
        print('Mamy nie zgodność w: ',index, student_id, df_solution_student_id_list[index])
    else:
        continue
    
for index, sum_points_of_student in enumerate(sum_points_list): # sprawdzanie punktów 
    if sum_points_of_student != df_solution_sum_points_list[index]:
        print('Mamy nie zgodność w: ',index, sum_points_of_student, df_solution_sum_points_list[index])
    else:
        continue

# Wyświetlanie wyników Student id: Punkty 
#print(f'\nStudent id: Punkty')
#for index, id in enumerate(student_id_list):
#    print(f'{id}: {sum_points_list[index]}')
        
# Rezultat do DataFrame by potem przerzucić to do excela
results = pd.DataFrame({
    'Student_id': student_id_list,
    'Suma_punktow': sum_points_list,
})
results = results.sort_values(by='Suma_punktow', ascending=False) # Sortujemy od najlepszych wyników wyników 
#print(results.head(3))
results.to_excel('Python_Solution_Rafał_Olenderski_48561.xlsx', index = False)

