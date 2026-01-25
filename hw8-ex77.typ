#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  project-title: [Algorytmiczna Teoria Gier\ Zadanie domowe 8\ Zadanie 77],
  //title: "Article\ntemplate\ntemplate 2",
  authors: (
    (name: "Adrian Herda (268449)", affiliation: "Informatyka Algorytmiczna, Politechnika Wrocławska"),
  ),
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  date: "25 stycznia 2026 r.",
  content: true,
)

= Treść zadania

Przeanalizuj składy dwóch ostatnich sejmów RP (na dzień zaprzysięnia premiera). Wyznacz indeksy Banzhafa i Shapleya dla partii i klubów poselskich. Możesz użyć komputera.

= Rozwiązanie

Definicja gry

Grą w sejmie nazywamy pare: $ (N, W) $ gdzie:
/ $N$: Zbiór graczy. W przypadku podanego zadania będą to partię lub kluby parlamentarne,
/ $W$: Zbiór wag graczy takie że gracz $i in N$ ma wagę $w_i in W$. W przypadku sejmu oznacza to ilość mandatów danej partii/klubu

Większość w sejmie ozanczać będziemy jako: $ q = min{n in NN: n > 1/2 sum_(w in W) w} $
Koalicją nazywamy $S subset.eq N$. Tak zdefiniowaną kolalicję nazywamy wygrywającą jeśli $sum_(i in S) w_i >= q$. Na tą potrzebę definiujemy funkcję charakterystyczną $v: scr(P)(N) -> {0, 1}$:
$
  v(S) = cases(1", " space sum_(i in S) w_i >= q, 0", " space sum_(i in S) w_i >= q)
$
wtedy jeśli $v(S) = 1$ to $S$ jest koalicją wygrywającą, a przegrywającą w przeciwnym przypadku.

== Definicje indeksów

=== Indeks siły Banzhafa
Jest to odsetek koalicji wygrywających w których dany klub lub partia odgrywa kluczową rolę, tzn. po wycofaniu się, koalicja ta nie miałaby już większości.

Niech liczba takich koalicji dla partii $i in N$:
$
  b_i = |{S subset.eq N \\ {i}: v(S) = 0 and v(S union {i}) = 1}|
$

Wtedy odsetek a więc i indeks Banzhafa ma wzór:
$
  B_i = b_i / (sum_(j in N) b_j)
$

=== Indeks siły Shapleya-Shubika

Niech $R$ to zbiór wszystkich dobrych porządków na zbiorze $N$. To oznacza że każdy porządek jest permutacją zbioru $N$ więc $|R| = |N|!$. Każdy taki porządek oznacza możliwą kolejność przyłączania się do koalicji.

Indeks siły Shapleya-Shubika dla ugrupowania $i in N$ to odsetek porządków $prec in R$, takich że po przyłączeniu się $i$ do koalicji tworzonej w porządku $prec$, ta właśnie stanie się koalicją wygrywającą.

$
  phi_i &= lr(|{prec in R: sum_(j prec i) w_j < q and w_i + sum_(j prec i) w_j}|) / (|R|)\
  &= lr(|{prec in R: sum_(j prec i) w_j < q and w_i + sum_(j prec i) w_j}|) / (|N|!)\
$

== Rozwiązanie

Według trści zadania użycie komputerów było dozwolone, więc do policzenia tych indeksów stworzony został skrypt w języku _Python_.

=== Funkcje pomocnicze

+ Funkcja do obliczania granicy większości. Jako parametr wymaga podania objektu _Dict_ z nazwami ugrupowań i ich liczbę mandatów, następnie oblicza połowę wszystkich mandatów po uwczesnym dodaniu $2 - q mod 2$ które zapewnia że q zawsze będzie większe niż połowa wszystkich mandatów
  ```python
  def calcluate_q(kluby):
    q = sum(kluby.values())
    q = int((q + 2 - q % 2) / 2)
    return q
  ```
+ Funkcja do obliczania wartości silnia.
  ```python
  def factorial(f):
    result = 1
    while f > 1:
        result *= f
        f -= 1
    return result
  ```

=== Funkcja obliczająca indeks siły Banzhafa

Funkcja ta dla każdej partii w paramterze _kluby_, patrzy po wszystkich możliwych koalicjach które jej nie zawierają. Jeśli taka koalicja, przed dodaniem analizowanej partii, nie jest wygrywająca a po dodaniu jest, to partia dostaje punkt. Po takiej analizie każdej partii wartoiści są normalizowane i zwracane
```python
def banzhaf(kluby):
    q = calcluate_q(kluby)
    result = [0 for _ in kluby.keys()]
    # licznik oznaczający liczbę koalicji nie zawierających jednej partii
    counter = 2 ** (len(kluby) - 1)
    for index, klub in enumerate(kluby.keys()):
        # zbiór partii bez analizowanego klubu
        kluby_bez = list(kluby.keys())
        kluby_bez.remove(klub)
        klub_value = kluby[klub]
        # pętla po wszystkich koalicjach, bity w zmiennej i oznaczają które partie należą do koalicji
        for i in range(counter):
            sublist = kluby_bez.copy()
            # usuwanie partii jeśli bit w zmiennej i odpowiajaćy teej partii jest równy 0
            for j in range(len(kluby_bez)):
                if (i >> j) % 2 == 0:
                    sublist.remove(kluby_bez[j])
            # test przekoroczenia granicy większoći (q)
            suma = sum([kluby[klub2] for klub2 in sublist])
            if suma < q and suma + klub_value >= q:
                result[index] += 1
    # normalizacja
    sum_all = sum(result)
    for i in range(len(result)):
        result[i] /= sum_all
    return result
```

=== Funkcja obliczająca indeks siły Shapleya-Shubika

Funkcja iterująca po wszystkich permutacjach zbioru partii oraz patrząca która partia w tej permutacji sprawi, że tworzona w danym porządku koalicja stanie się wygrywająca.

```python
from itertools import permutations

def shapley_shubik(kluby):
    q = calcluate_q(kluby)
    result = [0] * len(kluby)
    possible_perm = factorial(len(kluby))
    # iteracja po wszystkich permutacjach
    for perm in permutations(enumerate(kluby.values())):
        suma = 0
        # dodawanie partii do koalicji według porządku
        for index, value in perm:
            suma += value
            # test na granice większości
            if suma >= q:
                result[index] += 1
                break
    # normalizacja
    for i in range(len(result)):
        result[i] /= possible_perm
    return result
```

== Wyniki
=== Sejm X Kadencji
#align(center)[#table(
  columns: (auto, auto, auto, auto),
  align: (x, y) => if y == 0 { center } else if x == 0 {left} else {right},
  table.header([Partia/Klub\ $i in N$], [Mandaty\ $w_i$], [Indeks Banzhafa\ $B_i$], [Indeks Shapleya-Shubika\ $phi_i$]),
  [PiS], $235$, $1$, $1$,
  [KO], $134$, $0$, $0$,
  [Lewica], $49$, $0$, $0$,
  [Koalicja Polska], $30$, $0$, $0$,
  [Konfederacja], $0$, $0$, $0$,
)]
=== Sejm IX Kadencji
#align(center)[#table(
  columns: (auto, auto, auto, auto),
  align: (x, y) => if y == 0 { center } else if x == 0 {left} else {right},
  table.header([Partia/Klub\ $i in N$], [Mandaty\ $w_i$], [Indeks Banzhafa\ $B_i$], [Indeks Shapleya-Shubika\ $phi_i$]),
  [PiS], $191$, $0.393$, $0.4$,
  [KO], $157$, $0.179$, $0.2$,
  [PL2025], $33$, $0.107$, $0.1$,
  [PSL], $32$, $0.107$, $0.1$,
  [Lewica], $26$, $0.107$, $0.1$,
  [Konfederacja], $18$, $0.107$, $0.1$,
  [Wolni Republikanie], $3$, $0$, $0$,
)]
