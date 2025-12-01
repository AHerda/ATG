#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  project-title: [Algorytmiczna Teoria Gier\ Zadanie domowe 2],
  //title: "Article\ntemplate\ntemplate 2",
  authors: (
    (name: "Adrian Herda (268449)", affiliation: "Informatyka Algorytmiczna, Politechnika Wrocławska"),
  ),
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  date: "18 listopada 2025 r.",
  content: true,
)

= Treść zadania - Zadanie 28
Za siedmioma górami, za siedmioma pustyniami, 
w królestwie zwierząt, król Skaza i kandydat na króla - Simba,
biorą udział w pisemnym konkursie. Podług bardzo rzetelnego obserwatora tj. Drzewa Życia,
w tym bardzo wyrównanym konkursie, Skaza powinien dostać 49 punktów, a Simba - 51.
Niestety, obserwator nie jest obywatelem królestwa zwierząt i nie moze wybierać za nich.
Dlatego o wygraniu konkursu mają zadecydować średnie oceny prac kandydatów dokonanywane przez zwierzęcych wyborców.
Wygrywa ten kandydat, który osiągnie większą srednią ocen wsród wyborców. Wiadomo, że 15% zwierząt jest inteligentne.
Podobnie, 15% zwierząt jest nierozsądnych. Pozostałe zwierzęta nazwijmy przeciętnymi.
Wiadomo, ze wariancje ocen dokonywanych przez zwierzęcych wyborców różnią się tylko ze wzglgędu na powyższą klasyfikację inteligencji.
Dla inteligentnego zwierzęcia, błąd popełniany względem oceny Drzewa Życia to zmienna losowa o rozkładzie zgodnym z $X$,
dla przeciętnego - ze zmienną $Y$, a nierozsądnego - ze zmienną $Z$.
Zakładamy, że $X$, $Y$, $Z$ mają niezalezne rozkłady normalne, o wspólnej średniej $0$,
oraz wariancjach: $"Var"(X) = 1$, $"Var"(Y) = 4$ i $"Var"(Z) = 9$, odpowiednio.
Ponadto wiemy, że wszystkie zwierzęta każdą ocenę przeprowadzają niezależnie od innych ocen (także tych innych zwierząt).

Początkowo tylko $10$ zwierząt wie o wyborach i planuje oceniać prace kandydatów. Są wsród nich $2$ zwierzęta inteligentne, $6$ przeciętnych i $2$ nierozsądne.

== a)

Niech $N_1 tilde cal(N)(0, sigma_1)$, $N_2 tilde cal(N)(0, sigma_2)$ będą niezależnymi zmiennymi losowymi. Jaki rozkład ma $N_1 + N_2$?

== b)

Jakie rozkłady mają zmienne opisujące sumy ocen od $10$ początkowych wyborców (liczone osobno dla Skazy i Simby)?\
A jaki rozkład ma różnica tych sum?\
Jaki rozkład ma różnica średnich ocen dla poszczególnych kandydatów?

== c)

Jakie jest prawdopodobieństwo, że przy wskazanych $10$ wyborcach, Skaza wygra wybory (będzie miał większą średnią ocen)?\
Wskazówka: Znormalizuj odpowiednią zmienną i skorzystaj tablicy dystrybuanty standardowego rozkładu normalnego $cal(N)(0,1)$.

== d)

Kapituła konkursowa rozważa kilka strategii reklamy wyborów aby zwiększyć liczbę wyborców.
Liczbę nowych wyborców danego typu w zależności od wybranego typu reklamy, przedstawia poniższa tabela:
#table(
  columns: 5,
  align: center,
  table.header([Reklama], [brak], [hieny], [poczta Zazu], [zebranie u Rafikiego]),
  row-gutter: (2.2pt, auto),
  stroke: (x, y) => (
    top: if y > 0 { black },
    bottom: if y == 0 { black } ,
    left: if x > 0 { black }
  ),
  [Inteligentne], $+0$, $+0$, $+3$, $+9$,
  [Przeciętne], $+0$, $+10$, $+12$, $+1$,
  [Nierozsądne], $+0$, $+10$, $+5$, $+0$
)
Ponadto Skaza ma dwie strategie: przekonać $5$ nowych nierozsądnych wyborców albo nie mówić nikomu o wyborach.\
Wypłata Skazy to prawdopodobieństwo wygrania konkursu przez niego,
a kapituły (reprezentującej ccałe królestwo zwierząt) - prawdopodobieństwo wyborów zgodnych z rzetelną oceną Drzewa Życia (czyli wygranej Simby).\
Przedstaw grę między Skazą a Kapitułą w postaci macierzowej (jedna komórka wynika z poprzedniego podpunktu).

== e)

Znajdź mieszane równowagi Nasha dla tej gry.

== f)

Co charakteryzuje grupę, która zwiększa uczciwość wyborów?

== PS.
Zadanie zainspirowane m.in. wierszem Ewy Lipskiej pt. _"Egzamin"_.

= Rozwiązanie

== a) Distribution of sum <e_var_of_sum>

$ N_1 tilde cal(N)(mu_1, sigma_1), space N_2 tilde cal(N)(mu_2, sigma_2) $

Niech $N = N_1 + N_2$, szukamy $mu$ oraz $sigma$ takich że $N tilde cal(N)(mu, sigma)$

=== Expected value of sum

$ 
  mu &= EE[N_1 + N_2]\ &= integral_(-infinity)^infinity integral_(-infinity)^infinity (n_1 + n_2) f_N_1 (n_1) f_N_2 (n_2) space d n_1  space d n_2\
  &= integral_(-infinity)^infinity (integral_(-infinity)^infinity n_1 dot f_N_1 (n_1) dot f_N_2 (n_2)  space d n_2 + integral_(-infinity)^infinity n_2 dot f_N_1 (n_1) dot f_N_2 (n_2)  space d n_2)  space d n_1\
  &= integral_(-infinity)^infinity (n_1 dot f_N_1 (n_1) dot underbrace(integral_(-infinity)^infinity f_N_2 (n_2) space d n_2, 1) + f_N_1 (n_1) dot integral_(-infinity)^infinity n_2 dot f_N_2 (n_2)  space d n_2) space d n_1\
  &= integral_(-infinity)^infinity (n_1 dot f_N_1 (n_1) + f_N_1 (n_1) dot mu_2) space d n_1\
  &= integral_(-infinity)^infinity n_1 dot f_N_1 (n_1) space d n_1 + integral_(-infinity)^infinity f_N_1 (n_1) dot mu_2 space d n_1\
  &= mu_1 + mu_2 underbrace(integral_(-infinity)^infinity f_N_1 (n_1) space d n_1, 1)\
  &= mu_1 + mu_2\
$

=== Variance of sum

$
  sigma &= "Var"(N_1 + N_2)\
  &= EE[((N_1 + N_2) - EE[N_1 + N_2])^2]\
  &= EE[((N_1 - EE[N_1]) + (N_2 - EE[N_2]))^2]\
  &= EE[(N_1 - EE[N_1])^2 + (N_2 - EE[N_2])^2 - 2 (N_1 - EE[N_1]) (N_2 - EE[N_2])]\
  &= EE[(N_1 - EE[N_1])^2] + EE[(N_2 - EE[N_2])^2] - EE[2 (N_1 - EE[N_1]) (N_2 - EE[N_2])]\
  &= "Var"(N_1) + "Var"(N_2) - 2 EE[(N_1 - EE[N_1]) (N_2 - EE[N_2])]\
  &= sigma_1 + sigma_2 - 2 "Cov"(N_1, N_2)
$

W przypadku gdy $N_1$ oraz $N_2$ są niezalżne to $"Cov"(N_1, N_2) = 0$ a wtedy: $ sigma = sigma_1 + sigma_2 $ <var>

=== Podsumowanie

$ N tilde cal(N)(0, sigma_1 + sigma_2 + 2 dot "Cov"(N_1, N_2)) $

== b) Rozkłady dla różnie zdefiniowanych zmiennych losowych

Na podstawie wyników z @e_var_of_sum[sekcji] oraz treści zadania, mówiącej o niezależności ocen wyborców, wiadomo że wystarczy zsumować wartości oczekiwane oraz wariancję każdego z wyborców.

Wartość oczekiwana punktacji jest taka sama jak rzetelna ocena obserwatora.

Oznaczenia:
/ $S$: Simba,
/ $S k$: Skaza,
/ $cal(Z) = {I, I, P, P, P, P, P, P, N, N}$: zbiór wyborców, gdzie $I$ oznacza wyborce inteligentnego, $P$ - preciętnego a $N$ - nierozsądnego,
/ $n = |cal(Z)|$: liczba wyborców
/ $X_(i, j)$: ocena wyborcy $i$ dla kandydata $j$, gdzie $i in cal(Z)$ oraz $j in {S, S k}$,
/ $EE_S = 51$: wartość oczekiwana oceny pracy Simby,
/ $EE_(S k) = 49$: wartość oczekiwana oceny pracy Skazy,
/ $sigma_i$: warianjca oceny wyborcy, gdzie $i in cal(Z)$ to oznaczenia na, odpowiednio, wyborce inteligentnego, przeciętnego i nierozsądnego,

Z treści zadania wiadomo, że:

$
  (forall_(i in cal(Z))) (EE[X_(i, S)] = EE_S and EE[X_(i, S k)] = EE_(S k))
$

=== Wyniki Simby

$
  Y_S &= sum_(i in cal(Z)) X_i \ \
  EE_(Y_S) &= sum_(i in cal(Z)) EE[X_i]\
  &= sum_(i in cal(Z)) EE_S\
  &= 10 dot EE_S\
  &= 510 \ \
  sigma_(Y_S) &= 2 sigma_I + 6 sigma_P + 2 sigma_N\
  &= 2 dot 1 + 6 dot 4 + 2 dot 9\
  &= 2 + 24 + 18\
  &= 44
$
A więc:
$
  Y_S tilde cal(N)(510, 44)
$

=== Wyniki Skazy

$
Y_(S k) &= sum_(i in cal(Z)) X_i \ \
  EE_(Y_(S k)) &= 10 * EE_(S k) = 490 \ \
  sigma_(Y_(S k)) &= 2 sigma_I + 6 sigma_P + 2 sigma_N\
  &= sigma_(Y_S)\
  &= 44
$

A więc

$
  Y_(S k) tilde cal(N)(490, 44)
$

=== Róznica sum

$ 
  Z &= Y_S - Y_(S k)\ \
  EE[Z] &= EE[Y_S - Y_(S k)]\ &= EE[Y_S] - EE[Y_(S k)]\ &= 510 - 490\ &= 20 \ \
  sigma_Z &= "Var"(Y_S + (-1) dot Y_(S k))\
  &= sigma_(Y_S) + (-1)^2 sigma_(Y_(S k))\
  &= sigma_Y_S + sigma_Y_(S k)\
  &= 88
$

A więc:
$ Z tilde cal(N)(20, 88) $

=== Różnica średnich ocen <mean_dist>

Teraz niech $Z$ będzie oznaczało różnice średnich ocen kandydatów.

$
  Z &= 1 / n sum_(i in cal(Z)) X_(i, S) - 1 / n sum_(i in cal(Z)) X_(i, S k)\ \
  EE[Z] &= EE[1 / n sum_(i in cal(Z)) X_(i, S) - 1 / n sum_(i in cal(Z)) X_(i, S k)]\
  &= EE[1 / n sum_(i in cal(Z)) X_(i, S) -  X_(i, S k)]\
  &= 1 / n sum_(i in cal(Z)) EE[X_(i, S) -  X_(i, S k)]\
  &= 1 / n sum_(i in cal(Z)) EE[X_(i, S)] -  EE[X_(i, S k)]\
  &= 1 / n sum_(i in cal(Z)) EE_S -  EE_(S k)\
  &= 1 / n dot n dot (EE_S -  EE_(S k))\
  &= EE_S -  EE_(S k)\
  &= 51 -  49\
  &= 2
$ <mean_diff_e>
$
  sigma_Z &= "Var"(1 / n sum_(i in cal(Z)) X_(i, S) - 1 / n sum_(i in cal(Z)) X_(i, S k))\
  &= "Var"(1 / n sum_(i in cal(Z)) X_(i, S) -  X_(i, S k))\
  &= 1 / n^2 sum_(i in cal(Z)) "Var"(X_(i, S) -  X_(i, S k))\
  &= 1 / n^2 sum_(i in cal(Z)) "Var"(X_(i, S)) +  "Var"(X_(i, S k))\
  &= 1 / n^2 sum_(i in cal(Z)) sigma_i + sigma_i\
  &= 1 / n^2 dot 2 dot (2 sigma_I + 6 sigma_P + 2 sigma_N)\
  &= 2 / 10^2 dot 44\
  &= 0.88\ \
$ <mean_diff_var>

A więc:
$ Z tilde cal(N)(2, 0.88) $

== c) Prawdopodobieństwo zwycięstwa Skazy <pr_skaza_win>

Skaza wygra wtedy gdy:

$ 1 / n sum_(i in cal(Z)) X_(i, S k) > 1 / n sum_(i in cal(Z)) X_(i, S)\ arrow.double.b\ 0 > 1 / n sum_(i in cal(Z)) X_(i, S) - 1 / n sum_(i in cal(Z)) X_(i, S k) $

W @mean_dist[sekcji] policzona została dokładnie ta różnica. Dla ułatwienia obliczeń wykonywanych w tej sekcji, warto znormalizować tak zdefiniowaną zmienną, więc niech
$ Z' = (Z - 2) / sqrt(0.88) tilde cal(N)(0, 1) $

Teraz można wyliczyć, że
$
  PP("wygrana Skazy") &= PP(Z < 0)\
  &= PP(Z' dot sqrt(0.88) + 2 < 0)\
  &= PP(Z' < -2/sqrt(0.88))\
  &approx PP(Z' < -2.132)
$ <sk_win_pr_eq>

Tą wartość można pozyskać wykorzystując tablice dystrybuanty $cal(N)(0, 1)$

$ PP("wygrana Skazy") approx Phi(-2.132) = 0.016503 approx 1.65% $

== d) Gra między skazą a kapitułą

=== Oznaczenia

/ $n_i$: liczba wyborców z podziałem na klasyfiakcje, gdzie $i in {I, P, N}$,
/ $n = n_I + n_P + n_N$: liczba wszystkich wyborców biorących udział,
/ $p_S$: prawdopodobieństwo zwycięstwa Simby,
/ $p_(S k)$: prawdopodobieństwo zwycięstwa Skazy

Ponownie niech $Z$ będzie oznaczało różnice średnich ocen kandydatów.

=== Ogólny wzór na prawdopodobieństwo zwycięstwa Skazy

W @mean_diff_e[równaniu] widać jasno, że wartośc oczekiwana różnicy średnich ocen jest niezależna od ilości zwierząt oraz niezależnie od klasyfikacji ich inteligencji i jest równa:

$
  EE[Z] = 2
$

Podobnie można wykorzystać @mean_diff_var[równanie] do szybkiego znalezienia wzoru na wariancję różnicy średnich ocen:

$
  sigma_Z' &= "Var"(1 / n sum_(i in cal(Z)) X_(i, S) - 1 / n sum_(i in cal(Z)) X_(i, S k))\
  &= 1 / n^2 sum_(i in cal(Z)) sigma_i + sigma_i\
  &= 2 / n^2 dot (n_I sigma_I + n_P sigma_P + n_N sigma_N)\
  &= 2 / n^2 dot (n_I + 4 n_P + 9 n_N)
$

A więc:

$ Z tilde cal(N)(2, 2 / n^2 dot (n_I + 4 n_P + 9 n_N)) $ <mean_diff_dist>

Normalizując tą zmienną:

$ Z' = (Z - 2) / sqrt(2 / n^2 dot (n_I + 4 n_P + 9 n_N)) $

Pnownie wykorzustując poprzednie @sk_win_pr_eq[równanie] można obliczyć wzór na prawdopodobieństwo zwycięstwa Skazy:

$
  p_(S k) &= PP(Z < 0)\
  &= PP(Z' * sqrt(sigma_Z') + 2 < 0)\
  &= PP(Z' < -2 / sqrt(sigma_Z'))\
  &= Phi(-2 / sqrt(sigma_Z'))
$

=== Ogólny wzór na wygraną Simby

Mając już prawdopodobieństwo na wygraną Skazy łatwo policzyć prawdopodobieństwo wygranej Simby gdyż jest to jedyny inny wynik wyborów. Więc:
$
  p_S &= 1 - p_(S k)\
  &= 1 - Phi(-2 / sigma_Z')
$

=== Obliczenia

- Skaza nie zaprasza $5$ nierozsądnych wyborców, brak reklamy.

  Ten profil strategii już rozważyliżmy w @pr_skaza_win[sekcji]:
  $ p_(S k) &approx 1.65%\
  p_S &= 1 - p_(S k) approx 98.35% $

- Skaza nie zaprasza $5$ nierozsądnych wyborców, kapituła robi reklame poprzez hieny.

  Taki prfil strategii przynosi $10$ więcej wyborców przeciętnych oraz nierozsądnych. A zatem $n = 30$, bez zmian pozostaje $n_I = 2$, natomiast po 10 wyborców dochodzi do $n_P = 16$ oraz $n_N = 12$.
  $ p_(S k) &= Phi(-2 / sqrt(2 / 30^2 dot (2 + 4 dot 16 + 9 dot 12)))\ &= Phi(-2 / sqrt(2 / 900 dot (2 + 64 + 108)))\ &= Phi(-2 / sqrt(1/450 dot 174))\ &approx Phi(-3.216)\ &= 0.065%\
  p_S &= 1 - 0.065% = 99.935 $

- Skaza nie zaprasza $5$ nierozsądnych wyborców, kapituła robi reklamę poprzez pocztę Zazu

  Taka reklama przynosi $3$ wyborców inteligentnych, $12$ wyborców przeciętnych oraz $5$ wyborców nierozsądnych. $n_I = 5, n_P = 18, n_N = 7 => n = 30$
  $ p_(S k) &approx Phi(-3.586)\ &= 0.0168%\
  p_S &= 99.9832% $

- Skaza nie zaprasza $5$ nierozsądnych wyborców, kapituła robi reklamę na spotkaniu Rafikiego.

  Taki profil strategi przynosi aż $9$ inteligentnych wyborców, $1$ przeciętnego i żadnego nierozsądnego, $n_I = 11, n_P = 7, n_N = 2 => n = 20$.
  $ p_(S k) &approx Phi(-3.746)\ &= 0.009%\
  p_S &= 99.991% $

- Skaza zaprasza $5$ nierozsądnych wyborców, kapituła nie robi reklamy.

  Taki profil strategi przynosi tylko $5$ nierozsądnych wyborców, $n_I = 2, n_P = 6, n_N = 7 => n = 15$.
  $ p_(S k) &approx Phi(-2.249)\ &= 1.2256%\
  p_S &= 98.7744% $

- Skaza zaprasza $5$ nierozsądnych wyborców, kapituła robi reklamę poprzez hieny.

  Taki profil strategi nie przynosi żadnego inteligentnego wyborcę, natomiast przynosi $10$ przeciętnych i $15$ nierozsądnych, $n_I = 2, n_P = 16, n_N = 17 => n = 35$.
  $ p_(S k) &approx Phi(-3.345)\ &= 0.0412%\
  p_S &= 99.9588% $

- Skaza zaprasza $5$ nierozsądnych wyborców, kapituła robi reklamę poprzez pocztę Zazu.

  Taki profil strategi przynosi $3$ inteligentnych wyborców, $12$ przeciętnych i $10$ nierozsądnych, $n_I = 5, n_P = 18, n_N = 12 => n = 35$.
  $ p_(S k) &approx Phi(-3.639)\ &= 0.0137%\
  p_S &= 99.9863% $

- Skaza zaprasza $5$ nierozsądnych wyborców, kapituła robi reklamę na spotkaniu u Rafikiego.

  Taki profil strategi przynosi $9$ inteligentnych wyborców, $1$ przeciętnych i $5$ nierozsądnych, $n_I = 11, n_P = 7, n_N = 7 => n = 25$.
  $ p_(S k) &approx Phi(-3.501)\ &= 0.0232%\
  p_S &= 99.9768% $

=== Gra w postaci macierzowej
#figure(
  align(center)[#table(
    columns: 5,
    align: horizon + center,
    inset: 0pt,
    gcell([nierozsądni], [reklama]),
    [brak], [hieny], [poczta Zazu], [spotkanie\ u Rafikiego],
    $+ 0$, gcell($1.65%$, $98.35%$), gcell($0.065%$, $99.935%$), gcell($0.0168%$, $99.9832%$), gcell($0.009%$, $99.991%$),
    $+5$, gcell($1.2256%$, $98.7744%$), gcell($0.0412%$, $99.9588%$), gcell($0.0137%$, $99.9863%$), gcell($0.0232%$, $99.9768%$)
  )],
  caption: [Gra pomiędzy Skazą a kapitułą],
)<game>

== e) Mieszane równowagi Nasha

Niech:
/ $S_1, S_2$: strategie Skazy na, odpowiednio, nie namawianie nikogo lub na namówienie $5$ nierozsądnych wyborców.
/ $K_1, K_2, K_3, K_4$: strategie kapituły na reklame poprzez, odpowiednio, brak, hieny, pocztę Zazu, spotkanie u Rafikiego.
/ $s_(i,j)$: profil strategii, łączący strategie $S_i$ Skazy oraz $K_j$ kapituły, dla $i in {1,2}, space j in {1,2,3,4}$
\
Ta gra jest o sumie zerowej.
Patrząc na @game[tabele] widać, że dla kapituły strategie $K_3$ oraz $K_4$ ściśle dominuja strategie $K_1$ i $K_2$.
To oznacza, że racjonalna kapituła nigdy nie wybierze tych drugich strategii,
a więc na potrzeby tego podpunktu możemy usunąć z tabeli niepotrzebne komórki.

#align(center)[#table(
  columns: 3,
  align: horizon + center,
  inset: 0pt,
  gcell([nierozsądni], [reklama]),
  [poczta Zazu\ ($K_3$)], [spotkanie\ u Rafikiego\ ($K_4$)],
  $+ 0 space (S_1)$, gcell($0.0168%$, $99.9832%$), gcell($0.009%$, $99.991%$),
  $+5 space (S_2)$, gcell($0.0137%$, $99.9863%$), gcell($0.0232%$, $99.9768%$)
)]

- Dla Kapituły:
  $
    s_(1,3) < s_(1,4)\
    s_(2,3) > s_(2,4)
  $
- Dla Skazy:
  $
    s_(1,3) > s_(2,3)\
    s_(1,4) < s_(2,4)
  $

=== Mieszana strategia Skazy

Niech:
/ $p$: prawdopodobieństwo, że Skaza wybierze $S_1$,
/ $1 - p$: prawdopodobieństwo, że Skaza wybierze $S_2$,

Oczekiwana wypłata dla kapituły:
$
  EE[v(K_3)] = p s_(1, 3) + (1-p)s_(2,3)\
  EE[v(K_4)] = p s_(1, 4) + (1-p)s_(2,4)
$

W równowadze kapituła:
$
  EE[v(K_3)] &= EE[v(K_4)]\
  p s_(1, 3) + (1-p)s_(2,3) &= p s_(1, 4) + (1-p)s_(2,4)\
  p s_(1, 3) + s_(2,3) - p s_(2,3) &= p s_(1, 4) + s_(2,4) - p s_(2,4)\
  p s_(1, 3) + p s_(2,4) - p s_(2,3) - p s_(1, 4) &= s_(2,4) - s_(2,3)\
  p (s_(1, 3) + s_(2,4) - s_(2,3) - s_(1, 4)) &= s_(2,4) - s_(2,3)\
  p &= (s_(2,4) - s_(2,3)) / (s_(1, 3) + s_(2,4) - s_(2,3) - s_(1, 4))\
$ A więc: $
  p = (99.9768% - 99.9863%) / (99.9832% + 99.9768% - 99.9863% - 99.991%)
  approx 54.913%\ \
  1 - p approx 45.087%
$

Skaza gra $S_1$ z prawdopodobieństwem $54.913%$ a $S_2$ z prawdopodobieństwem $45.087%$.

=== Mieszana strategia kapituły

Niech:
/ $q$: prawdopodobieństwo, że kapituła wybierze $K_3$,
/ $1 - q$: prawdopodobieństwo, że kapituła wybierze $K_4$,

Oczekiwana wypłata Skazy:
$
  EE[v(S_1)] = q s_(1, 3) + (1-q)s_(1,4)\
  EE[v(S_2)] = q s_(2, 3) + (1-q)s_(2,4)
$

W równowadze Skaza musi być obojętny:
$
  EE[v(S_1)] &= EE[v(S_2)]\
  q s_(1, 3) + (1-q)s_(1,4) &= q s_(2, 3) + (1-q)s_(2,4)\ 
  q s_(1, 3) + s_(1,4) - q s_(1,4) &= q s_(2, 3) + s_(2,4) - q s_(2,4)\ 
  q s_(1, 3) + q s_(2,4) - q s_(1,4) - q s_(2, 3) &= s_(2,4) - s_(1,4)\ 
  q (s_(1, 3) + s_(2,4) - s_(1,4) - s_(2, 3)) &= s_(2,4) - s_(1,4)\ 
  q &= (s_(2,4) - s_(1,4)) / (s_(1, 3) + s_(2,4) - s_(1,4) - s_(2, 3))\ 
$ A więc: $
  q = (0.0232% - 0.009%) / (0.0168% + 0.0232% - 0.009% - 0.0137%)
  approx 82.081%\ \
  1 - q approx 17.919%
$

Kapituła gra $K_3$ z prawdopodobieństwem $82.081%$ a $K_4$ z prawdopodobieństwem $17.919%$

=== Wartość gry

Z perspektywy Skazy
$
  v &= EE[v(S_1)] = EE[v(S_2)]\
  &= q s_(1, 3) + (1-q)s_(1,4)\
  &= 0.82081 dot 0.000168 + 0.17919 dot 0.00009\
  &approx 0.000154\
  &= 0.0154%
$

Z perspektywy kapituły
$
  v &= EE[v(K_3)] = EE[v(K_2)]\
  &= p s_(1, 3) + (1-p)s_(2,3)\
  &= 0.54913 dot 0.999832 + 0.45087 dot 0.999863\
  &approx 0.999846\
  &= 99.9846%
$

Te wartości się ze sobą zgadzają sumując się do $100%$

== f) Grupa zwiększająca uczciwość

Uczciwość wyborów to zgodność wyników z rzetelną oceną obserwatora, czyli Drzewa Życia.
Drzewo Życia oceniło, że prawdziwie lepszą pracą jest praca Simby z $51$pkt,
więc w uczciwych wyborach to on powinien wygrać.
Klasyfikacja wyborców na gruby odbywa się jedynie za pomocą wariancji różnicy ich ocen z rzeetlną oceną obserwatora. 

W @mean_diff_dist[równaniu] opisany został rozkład różnicy średnich ocen a zatem i wzór na wariancję:

$
  sigma = 2 / n^2 (n_i + 4n_P + 9n_N)
$

Im większy udział wyborców nierozsądnych tym większa będzie wariancja.
Jeśli wkład wyborców inteligentnych w wybory będzie większy, a tych nierozsądnych mniejszy, wariancja nie będzie aż tak duża,
tym samym upewniając się że oceny będą bardziej precyzyjne i Skaza nie wygra "przez przypadek".

Z tego wynika, że zwiększanie udziału wyborów inteligentnych zwieksza uczciwość wyborów.
Zwiększanie udziału wyborców nierozsądnych zmniejsza poziom uczciwosci wyborów, zwiększając prawdopodobieństwo, że Skaza wygra.

Wyborcy przeciętni nie zwiększają wariancji w takim stopniu jak nierozsądni sprawiając, że też mozna ich uznać za grupę zwiekszającą uczciwość wyborów.

Te wnioski potwierdza strategia kapituły opierająca się na zwiększaniu wkładu wyborców przeciętnych oraz inteligentnych.
Strategią kapituły jest zwiększanie ilości wyborców co wdług wzoru w @mean_diff_dist[równaniu] zmniejsza wariancję kwadratowo.

*Grupa zwiększająca uczciwość wyborów będzie się charakteryzowała dużą liczbą wyborców,
dużym udziałem osób inteligentnych oraz małym udziałem osób nierozsądnych.*

