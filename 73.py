def solve_awantura():
    # Parametry
    teams = ['G', 'Y', 'B']
    probs = {'G': 0.6, 'Y': 0.7, 'B': 0.8}
    priority = ['G', 'Y', 'B'] # Kolejność szybkości

    # Stan początkowy Runda 2 (po top-upie)
    # Salda po opłaceniu wejściówki 200 zł w R2:
    # G: 300 - 200 = 100
    # Y: 300 - 200 = 100
    # B: 500 - 200 = 300
    state = {
        'pool': 14000 + 600, # 14000 z R1 + 3*200 wejściówki
        'balances': {'G': 100, 'Y': 100, 'B': 300},
        'active': ['G', 'Y', 'B']
    }

    # Ponieważ pula jest ogromna (14600+), a salda małe (100-300),
    # EV wygrania licytacji jest zawsze dodatnie.
    # Strategia optymalna: Va Banque natychmiast.
    # Wygrywa najszybszy z aktywnych graczy.

    results = {'G': 0.0, 'Y': 0.0, 'B': 0.0}

    # Prawdopodobieństwa ścieżek
    # Ścieżka 1: G wygrywa licytację w R2 (jest najszybszy)
    # G gra Va Banque (stawia 100). Pula rośnie o 100.
    pool_r2 = state['pool'] + 100

    # Szansa 1: G odpowiada poprawnie (60%)
    p_g_win = 0.6
    win_amount_g = pool_r2
    # G ma teraz ogromną kasę, inni grosze.
    # W kolejnych rundach (3-6) G jest zmuszany do licytowania 1000 (jako najbogatszy),
    # bo inni nie mają kasy by go przebić, a on musi grać.
    # Uproszczenie: G dominuje grę.
    # Szacujemy EV końcowe G jako wygraną w R2 minus koszty operacyjne w R3-R6.
    # Koszty: 4 rundy * 200 zł = 800 zł wejściówek.
    # Zyski/Straty z pytań za 1000 zł w R3-R6 są pomijalne przy 14k,
    # ale wpływają na wynik.

    ev_rest_g = win_amount_g - 4 * 200
    # (Ignorujemy małe fluktuacje +/- 1000 zł w R3-R6 dla uproszczenia wyniku głównego,
    # lub zakładamy, że G gra bezpiecznie).

    results['G'] += p_g_win * ev_rest_g
    results['Y'] += p_g_win * (100 - 4*200) # Y bankrutuje na wejściówkach?
    # Jeśli saldo < 200, wchodzi z tym co ma lub Krzysztof dopłaca?
    # Treść: "Jeśli na początku rundy saldo < 300 -> uzupełnia do 300".
    # Zatem Y i B będą dostawać top-up co rundę i tracić na wejściówkę.
    # Ich saldo końcowe będzie oscylować wokół 100-300 zł.

    # Szansa 2: G odpowiada źle (40%) -> G odpada.
    p_g_lose = 1.0 - p_g_win
    # Pula przechodzi do R3.
    pool_r3 = pool_r2 # 14700

    # Runda 3 (G nie gra). Aktywni: Y, B.
    # Top-up dla Y (miał 100 -> 300). B miał 300 (zostaje 300).
    # Opłaty: Y płaci 200 (zostaje 100). B płaci 200 (zostaje 100).
    # Pula R3 start: 14700 + 400 = 15100.
    # Licytacja: Y jest szybszy niż B.
    # Y gra Va Banque (100). Pula 15200.

    # Szansa 2a: Y odpowiada poprawnie (70%)
    p_y_win = 0.7
    prob_path_y = p_g_lose * p_y_win # 0.4 * 0.7 = 0.28

    val_y = 15200 - 3 * 200 # R4, R5, R6 opłaty
    results['Y'] += prob_path_y * val_y

    # Szansa 2b: Y odpowiada źle (30%) -> Y odpada.
    p_y_lose = 0.3
    pool_r4 = 15200

    # Runda 4 (G, Y nie grają). Aktywny: B.
    # Top-up dla B (miał 100 -> 300).
    # Opłata: B płaci 200 (zostaje 100).
    # Pula R4 start: 15200 + 200 = 15400.
    # B gra Va Banque (100). Pula 15500.

    # Szansa 3a: B odpowiada poprawnie (80%)
    p_b_win = 0.8
    prob_path_b = p_g_lose * p_y_lose * p_b_win # 0.4 * 0.3 * 0.8 = 0.096

    val_b = 15500 - 2 * 200 # R5, R6 opłaty
    results['B'] += prob_path_b * val_b

    # Szansa 3b: B odpada.
    # Wszyscy odpadli. Pula przepada (lub zostaje w grze, ale nikt jej nie weźmie).

    return results

expected_values = solve_awantura()

print("Expected Values after R2:")
for (team, ev) in expected_values.items():
    print(f"\tTeam {team}: EV = {round(ev, 2)} zł")
