#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  project-title: [Algorytmiczna Teoria Gier\ Zadanie domowe 3],
  //title: "Article\ntemplate\ntemplate 2",
  authors: (
    (name: "Adrian Herda (268449)", affiliation: "Informatyka Algorytmiczna, Politechnika Wrocławska"),
  ),
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  date: "2 grudnia 2025 r.",
  content: true,
)

= Treść zadania

Wsk. Wszystkie punkty tego zadania się łączą.
== a)
Pokaż, że skończony produkt zbiorów zwartych w przestrzeniach metrycznych jest zwarty (w topologii produktowej).
== b)
Pokaż, że skończony produkt zbiorów wypukłych w przestrzeniach liniowych jest wypukły (w sumie prostej przestrzeni liniowych).
== c)
Pokaż, że domknięty podzbiór zbioru zwartego jest zwarty.
== d)
Niech $(S, d_S)$ i $(I, d_I)$ będą skończonymi przestrzeniami z topologiami dyskretnymi. Jakie funkcje $f: S arrow I$ są ciągłe
(funkcja jest ciągła, gdy przeciwobraz dowolnego zbioru otwartego jest otwarty).
== e)
Gra w Natarczywego Adoratora. Kobieta lubi spędzać czas na Spacerze w parku albo w Galerii. Natarczywy Adorator o
tym wie i próbuje ją spotkać w jednym z tych dwóch miejsc, czego kobieta pragnie uniknąć. Wypłaty Kobiety, dla tej gry o sumie zerowej, podane są poniżej:
#align(horizon+center)[#table(
  columns: 4,
  // inset: auto,
  align: horizon + center,
  table.header([#gcell([$s_K$], [$s_A$])], $S$, $G$, []),
  row-gutter: (2.2pt, auto),
  column-gutter: (2.2pt, auto),
  stroke: (x, y) => (
    top: if y > 0 { black },
    bottom: if y == 0 { black },
    left: if x > 0 { black },
    right: if x == 0 { black }
  ),
  $S$, $-1$, $1$, $p$,
  $G$, $1$, $-1$, $1-p$,
  [], $q$, $1-q$, []
)]
Podaj wszystkie równowagi Nasha dla tej gry.
== f)
Czy funkcje wypłat $u_i$ w grze w _NA_ są wklęsłe ze względu na $s_i in S_i$ (przy ustalonych $s_(-i)$ in $S_(-i)$)?
== g)
Dla wszystkich profili strategii $s$, określamy $F(s)$ jako profil strategii, w którym $F_i (s)$ jest zbiorem najlepszych odpowiedzi gracza $i$ na $s_(-i)$. Czy $F$ ma własność wykresu domkniętego w grze w _NA_?
== h)
Dlaczego gra w _NA_ nie ma czystych równowag Nasha? Uzasadnij na bazie dowodu Twierdzenia Nasha (lub innego pokrewnego). Uwzględnij założenia tych twierdzeń.

= Rzowiązanie

== a) Produkt zbiorów zwartych

#proof[
  Niech $(X, d_X)$ i $(Y, d_Y)$ będą przestrzeniami metrycznymi, a $K_X subset.eq X$ i $K_Y subset.eq Y$ zbiorami zwartymi. Rozważmy produkt $K = K_X times K_Y$ z metryką produktową (np. maksimum). W przestrzeniach metrycznych zwartość jest równoważna zwartości ciągowej.
  Weźmy dowolny ciąg $z_n = (x_n, y_n)$ w $K$.
  + Ponieważ $x_n in K_X$, a $K_X$ jest zwarty, istnieje podciąg $x_{n_k}$ zbieżny do pewnego $x in K_X$.
  + Rozważmy odpowiadający podciąg $y_{n_k}$ w $K_Y$. Ponieważ $K_Y$ jest zwarty, z ciągu $y_{n_k}$ można wybrać dalszy podciąg $y_{n_{k_l}}$ zbieżny do pewnego $y in K_Y$.
  + Wtedy podciąg $z_{n_{k_l}} = (x_{n_{k_l}}, y_{n_{k_l}})$ jest zbieżny do punktu $(x, y) in K_X times K_Y$.

  Zatem każdy ciąg w $K$ posiada podciąg zbieżny, co oznacza, że produkt jest zwarty. (Indukcyjnie rozszerza się to na dowolny skończony produkt).
]

== b) Produkt zbiorów wypukłych <point_b>

#proof[
  Niech $C_1$ i $C_2$ będą zbiorami wypukłymi w przestrzeniach liniowych odpowiednio $V_1$ i $V_2$. Niech $x, y in C_1 times C_2$, gdzie $x = (x_1, x_2)$ i $y = (y_1, y_2)$.
  Dla dowolnego $lambda in [0, 1]$ musimy pokazać, że $lambda x + (1-lambda)y in C_1 times C_2$.
  Działania w przestrzeni produktowej wykonujemy "po współrzędnych":
  $ lambda (x_1, x_2) + (1-lambda)(y_1, y_2) = (lambda x_1 + (1-lambda)y_1, lambda x_2 + (1-lambda)y_2) $
  Ponieważ $C_1$ jest wypukły, $lambda x_1 + (1-lambda)y_1 in C_1$. \
  Ponieważ $C_2$ jest wypukły, $lambda x_2 + (1-lambda)y_2 in C_2$. \
  Zatem cały punkt należy do iloczynu kartezjańskiego $C_1 times C_2$.
  (Ten dowód ponownie można rozszerzyć indukcyjnie na dowolny skończony produkt).
]

== c) Domknięty podzbiór zbioru zwartego

#proof[
  Niech $K$ będzie zbiorem zwartym, a $F subset.eq K$ zbiorem domkniętym.
  Weźmy dowolne pokrycie otwarte $cal(U) = {U_i}_(i in I)$ zbioru $F$.
  Zbiór $F^c = K without F$ jest zbiorem otwartym (jako dopełnienie zbioru domkniętego).
  Rodzina $cal(U) union {F^c}$ stanowi pokrycie otwarte całego zbioru $K$.
  Ponieważ $K$ jest zwarty, istnieje skończone pokrycie tego zbioru, powiedzmy ${U_(i_1), dots, U_(i_n), F^c}$ (ewentualnie bez $F^c$, jeśli nie jest potrzebne).
  Odrzucając zbiór $F^c$ (który nie zawiera żadnych punktów z $F$), otrzymujemy skończoną rodzinę ${U_(i_1), dots, U_(i_n)}$, która pokrywa $F$.
  Zatem $F$ jest zwarty.
]

== d) Funkcje ciągłe między przestrzeniami dyskretnymi

W topologii dyskretnej każdy podzbiór jest zbiorem otwartym.
Definicja ciągłości mówi, że funkcja $f$ jest ciągła, jeśli przeciwobraz dowolnego zbioru otwartego w przeciwdziedzinie jest otwarty w dziedzinie.
Niech $U subset.eq I$ będzie dowolnym zbiorem (jest on otwarty w $I$). Wtedy $f^(-1)(U)$ jest pewnym podzbiorem $S$. Ponieważ w $S$ (topologia dyskretna) każdy zbiór jest otwarty, warunek ciągłości jest zawsze spełniony.

*Odpowiedź:* Wszystkie funkcje $f: S arrow I$ są ciągłe.

== e) Równowagi Nasha w grze natarczywego adoratora

=== Macierz wypłat
Gra o sumie zerowej. Wiersze: Kobieta ($K$), Kolumny: Adorator ($A$).
Kobieta unika spotkania ($S eq.not G$), Adorator dąży do spotkania ($S=S$ lub $G=G$).

#figure(
  align(horizon+center)[#table(
    columns: 3,
    inset: 0pt,
    align: horizon + center,
    table.header([#gcell([$s_K$], [$s_A$])], $S$, $G$),
    row-gutter: (2.2pt, auto),
    column-gutter: (2.2pt, auto),
    // stroke: (x, y) => (
    //   top: if y > 0 { black },
    //   bottom: if y >= 0 { black },
    //   left: if x > 0 { black },
    //   right: if x >= 0 { black }
    // ),
    $S$, gcell($-1$, $1$), gcell($1$, $-1$),
    $G$, gcell($1$, $-1$), gcell($-1$, $1$),
  )],
  caption: [Macierz wypłat w grze Natarczywego Adoratora]
)

=== Analiza
Gra nie posiada równowag w strategiach czystych, cykl preferencji:
$ (S_K, S_A) lt.eq_K (G_K, S_A) lt.eq_A (G_K, G_A) lt.eq_K (S_K, G_A) lt.eq_A (S_K, S_A) $ <cyclon>
Szukamy równowagi w strategiach mieszanych.

/ $p$: prawdopodobieństwo, że K wybierze S.
/ $q$: prawdopodobieństwo, że A wybierze S.

- *Dla Kobiety (chce zmaksymalizować $u_K$):*
  $
    EE [u_K (S)] &= -1 dot q + 1 dot (1-q) = 1 - 2q \
    EE [u_K (G)] &= 1 dot q + (-1) dot (1-q) = 2q - 1
  $
  W równowadze wypłaty muszą być równe:
  $ 1 - 2q &= 2q - 1\ 2 &= 4q\ q = 1/2 &and 1 - q = 1/2 $
  Wartość oczekiwana dla Kobiety w równowadze to $ EE [u_K] = 1 - 2 dot 1/2 = 0 $.

- *Dla Adoratora (chce zmaksymalizować $u_A$):*
  $
    EE [u_A (S)] &= 1 dot p + (-1) dot (1-p) = 2p - 1\
    EE [u_A (G)] &= -1 dot p + 1 dot (1-p) = 1 - 2p
  $
  W równowadze:
  $ 2p - 1 &= 1 - 2p\ 4p &= 2\ p = 1/2 &and 1 - p = 1/2 $
  Podobnie jak dla Kobiety, wartość oczekiwana dla Adoratora w równowadze to $ EE [u_A] = 2 dot 1/2 - 1 = 0 $

*Odpowiedź:* Jedyna równowaga Nasha to profil strategii mieszanych $((1/2, 1/2), (1/2, 1/2))$.

== f) Wklęsłość funkcji wypłat dla ustalonej strategii przeciwnika

W rozszerzeniu mieszanym gry, funkcja wypłaty gracza $i$, oznaczana jako $u_i (sigma_i, sigma_(-i))$ jest definiowana wzorem:
$
  u_i (sigma_i, sigma_(-i)) = sum_(s_i in S_i) sum_(s_(-i) in S_(-i)) sigma_i (s_i) dot sigma_(-i) (s_(-i)) dot u_i (s_i, s_(-i))
$
Strategia przeciwnika jest ustalona z treści zadanie więc
$
  u_i (sigma_i, sigma_(-i)) = sum_(s_i in S_i) sigma_i (s_i) C(s_i)
$ gdzie $
  C(s_i) = sigma_(-i) (s_(-i)) dot u_i (s_i, s_(-i))
$
A więc jest to funkcja liniowa względem zmiennych $sigma_i (s_i)$. Każda funkcja liniowa jest jednocześnie wklęsła i wypukła (spełnia nierówność Jensena jako równość).
Zatem warunek wklęsłości jest spełniony.

*Odpowiedź:* *Tak.*

== g) Własność wykresu domkniętego

Definicja: dla każdego profilu strategii $s$ definiujemy korespondencję
$ F(s)= (F_1 (s), dots,  F_n (s)) $
gdzie $F_i (s)$ jest zbiorem najlepszych odpowiedzi gracza $i$ na strategie pozostałych $s_(-i)$ przy ustalonej $s_i$ (w treści zadania jest drobna nieścisłość zapisu, ale interpretujemy to klasycznie: $F_i (s_(-i))$ to zbiór najlepszych odpowiedzi na $s_(-i)$).

Pytanie: czy $F$ ma wykres domknięty? (Mówiąc formalnie: czy zbiór ${(s,t): t in F(s)}$ jest domknięty.)

#theorem[Tak, przy standardowych założeniach (przestrzenie strategii są zwarte i wypukłe, funkcje wypłat są ciągłe), wykres korespondencji najlepszych odpowiedzi jest domknięty.]

#proof[
  Niech $(s^k,t^k)$ być ciągiem punktów z wykresu, tzn. $t^k in F(s^k)$ dla każdego $k$. Załóżmy, że $(s^k,t^k) arrow (s^*,t^*)$. Musimy pokazać, że $t^* in F(s^*)$, czyli że komponenty $t^*_i$ są najlepszymi odpowiedziami na $s^*_(-i)$. Dla każdego gracza $i$ i dowolnej strategii alternatywnej $y_i$ mamy (skoro $t^k_i$ jest najlepszą odpowiedzią na $s^k_(-i)$)
  $ u_i (t^k_i,s^k_{-i}) >= u_i (y_i,s^k_{-i}) $
  Ponieważ zbiory odpowiedzi są zwarte wiemy że wartości maksymalne istnieją, a dzięki wypukłości tych zbiorów i ciągłości funkcji wypłat, po przejściu do granicy otrzymujemy
  $ u_i (t^*_i,s^*_{-i}) >= u_i (y_i,s^*_{-i}) $
  dla każdego $y_i$, czyli $t^*_i$ jest najlepszą odpowiedzią na $s^*_(-i)$. To kończy dowód, pokazując, że wykres jest domknięty.
]

== h) Brak czystych równowag Nasha a Twierdzenie Nasha

=== Powód braku czystych równowag

Nie ma żadnych równowag Nasha w strategiach czystych, ponieważ w każdym profilu strategii jeden gracz może zmienić strategie aby zwiększyć swoją wypłatę. Zmiany i zapętlenie porządku profili strategii pokazuje @cyclon[Równanie].

=== Uzasadnienie poprawności
Twierdzenie Nasha  @nash1950equilibrium o istnieniu równowagi opiera się na Twierdzeniu Kakutaniego @kakutani1941generalization (czyli równowagi), zbiór, na którym określona jest korespondencja najlepszych odpowiedzi, musi być:
1. Zwarty.
2. *Wypukły*.

Rozważając *tylko* strategie czyste:
- Przestrzeń strategii to zbiór skończony ${S, G} times {S, G}$. Jest to zbiór dyskretny.
- Zbiór dyskretny składający się z więcej niż jednego punktu *nie jest wypukły*.

Brak wypukłości przestrzeni strategii czystych sprawia, że nie możemy zastosować twierdzenia o punkcie stałym w tej przestrzeni. Dopiero przejście do strategii mieszanych tworzy przestrzeń wypukłą (odcinek $[0,1]$ dla każdego gracza), co, zgodnie z @point_b[Sekcją], zachowuje wypukłość produktu tych zbiorów, umożliwiając znalezienie równowagi (punktu przecięcia ciągłych reakcji).

W strategiach czystych "przecięcie" krzywych reakcji może "trafić w próżnię" między punktami dyskretnymi.


#bibliography("hw3.bib")
