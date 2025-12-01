#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: [Algorytmiczna Teoria Gier\ Zadanie domowe 1],
  //title: "Article\ntemplate\ntemplate 2",
  authors: (
    (name: "Adrian Herda (268449)", affiliation: "Informatyka Algorytmiczna, Politechnika Wrocławska"),
  ),
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  date: "14 listopada 2025 r.",
  // content: true,
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

= Treść zadania

Rozważmy zbiór gier dwuosobowych skończonych, gdzie $|S_1|=n$, a $|S_2|=m$ i oznaczamy przez $cal(G)_(n,m)$. Niech $scripts(eq.triple)_(n,m)$ będzie oznaczeniem relacji równoważności dla równoważności gier na $cal(G)_(n,m)$. Ile jest takich nierównoważnych gier, tj. ile wynosi $|cal(G)_(n,m) \/scripts(eq.triple)_(n,m)|$?

= Rozwiązanie
/ $C = S_1 times S_2$: zbiór profili strategii, $|C| = |S_1|dot |S_2| = n m$

== Ilość różnych gier

Każdy z graczy $p in P$ ma swój porządek liniowy nad $C$, dla dwóch graczy będzie to para porządków przypisujących każdemu profilowi miejsce $i in [n m]$. Każdy taki porządek to inna gra, więc liczba porządków dla jednego gracza to $|C|!$, więc liczbę oznaczonych (z etykietami strategii) gier można wyliczyć ze wzoru: $ |cal(G)_(n,m)| = (|C|!)^2 = ((n m)!)^2 $<eq1>

== Ilość nierównoważnych gier
=== Dla $n != m$<nneqm>

$G = cal(S)_1 times cal(S)_2$ to zbiór permutacji, który działa na zbiorze profilów strategii, $|G| = |cal(S)_1| dot |cal(S)_2| = n! dot m!$. Z tego wynika że dwie gry są równoważne jeśli są w tej samej orbicie działania na $C$. Z tego wynika że liczba orbit działania jest równa liczbie gier nierównoważnych.

Według Burnside'a@burnside1909theory liczba orbit jest równa $ |cal(G)_(n,m) \/G| = 1 / (|G|) sum_(g in G) |cal(G)_(n,m)^g| $ gdzie $ cal(G)_(n,m)^g = {x in cal(G)_(n,m): g dot x = x} $ to zbiór różnych gier które pozostają niezmienne po zastosowaniu permutacji.

Każda gra w orbicie musi być różna więc jeśli $g in G ^ g eq.not e$, gdzie $e$ to element neutralny to $|cal(G)_(n,m)^g| = 0$. Z tego z kolei wynika że stabilizator każdej gry jest trywialny więc: 
$ sum_(g in G) |cal(G)_(n,m)^g| &= |cal(G)_(n,m)^e| + sum_(g in G\\{e}) 0\ &= |cal(G)_(n,m)| $<fixed_gs>
i to w połączeniu z @eq1[równaniem] daje:
$ |cal(G)_(n,m) \/scripts(eq.triple)_(n,m)| = |cal(G)_(n,m) \/G| = (|cal(G)_(n,m)|) / (|G|) = ((n m)!)^2 / (n!m!) $

=== Dla $n=m$

Podobnie jak w @nneqm[sekcji] definiujemy $G' = chevron G, tau chevron.r$ gdzie $tau$ oznacza zamiane graczy $tau dot (r_1, r_2) = (r_2, r_1)$

Szukamy 
$ |cal(G)_(n,n) \/G'| &= 1 / (|G'|) sum_(g' in G') |cal(G)_(n,m)^(g')|\ &= 1 / (|G'|) (sum_(g in G) |cal(G)_(n,n)^g| + sum_(g in G) |cal(G)_(n,n)^(tau g)|) $<looked_for>
Wartość $|G'|$ można obliczyć poodbnie jak w sekcji poprzedniej:
$ |G'| = |cal(S)_1| dot |cal(S)_2| + |cal(S)_2| dot |cal(S)_1| = n! dot n! + n! dot n! = 2 (n!)^2 $<size_g_prim>
Wartość pierwszej sumy w @looked_for[równaniu] możemy wziąć z @fixed_gs[równania]: $ sum_(g in G) |cal(G)_(n,n)^g| &= |cal(G)_(n,n)| &= ((n^2)!)^2 $<first_sum>

Teraz obliczymy kiedy element $tau g$ ma punkty stałe. Żeby do tego doszło musi zajsć:
$ (tau g) dot (r_1, r_2) = (r_1, r_2) $
rozpisując:
$ (tau g) dot (r_1, r_2) &= tau (g dot (r_1, r_2))\ &= tau (r_1 circle.small g^(-1), r_2 circle.small g^(-1))\ (r_1, r_2) &= (r_2 circle.small g^(-1), r_1 circle.small g^(-1)) $
To daje układ równań którego rozwiązaniem jest: $ r_1 = r_1 circle.small g^(-2) $ a to jest spełnione wtedy i tylko wtedy gdy $g^2 = e$ czyli $g = (alpha, beta)$ jest inwolucją (funckja, która złożona sama ze sobą daje jednosć). Aby policzyć liczbę inwolucji na zbiorze $S_n$ wykorzystywany jest wzór:
$ a_n = sum_(m=0)^floor(n/2) (n!) / (2^m m! (n - 2m)!) $<a_n>
Takich inwolucji dla gry dwuosobowej jest $a_n^2$ i dla każdej możemy wybrać $r_1$ na $(n^2)!$ sposobów co wybierze jednoznaczne $r_2 = r_1 circle.small g^(-1)$. Znając te wyniki można obliczyć drugą sumę @looked_for[równania]:
$ sum_(g in G) |cal(G)_(n,n)^(tau g)| = (n^2)!a_n^2 $

Podkładając wynik tego równania do wzoru w @looked_for[równaniu] otrzymujemy:
$
  |cal(G)_(n,n) \/G'| &= 1 / (|G'|) ( |cal(G)_(n,n)^g| + sum_(g in G) |cal(G)_(n,n)^(tau g)|)\
  &= 1 / (2(n!)^2) (((n^2)!)^2 +  a_n^2(n^2)!)\
  |cal(G)_(n,n) \/scripts(eq.triple)_(n,n)| &= (n^2)! / (2(n!)^2) ((n^2)! +  a_n^2)
$

== Wyniki

$
  |cal(G)_(n,n) \/scripts(eq.triple)_(n,n)| = cases(
    ((n m)!)^2 / (n!m!)", "&"dla" m eq.not n,
    (n^2)! / (2(n!)^2) ((n^2)! +  a_n^2)", "&"dla" m eq n
  )
$

#bibliography("hw1.bib")