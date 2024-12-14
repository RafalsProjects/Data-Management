--Najczęściej stosowane constrainty (ograniczenia tabel):
PRIMARY KEY
//*
Zapewnia unikalność każdej wartości w kolumnie (lub zestawie kolumn).
Każda tabela powinna mieć klucz główny, który jednoznacznie identyfikuje każdy wiersz.
*//
FOREIGN KEY
//*
Używany do tworzenia relacji między tabelami.
Zapewnia, że wartość w kolumnie odpowiada wartości w kluczu głównym innej tabeli.
*//
NOT NULL
//*
Gwarantuje, że w kolumnie nie może znajdować się wartość NULL.
*//
UNIQUE
//*
Zapewnia, że wszystkie wartości w kolumnie (lub zestawie kolumn) są unikalne.
*//
CHECK
//*
Definiuje warunek, który musi być spełniony przez wartości w kolumnie. Na przykład: CHECK (wiek >= 18).
*//
DEFAULT
//*
Ustawia wartość domyślną dla kolumny, jeśli użytkownik nie wprowadzi wartości.
*//
INDEX (chociaż nie zawsze traktowany jako constraint)
//*
Poprawia wydajność wyszukiwania danych w tabeli.
*//
