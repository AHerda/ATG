from itertools import permutations

def factorial(f):
    result = 1
    while f > 1:
        result *= f
        f -= 1
    return result

def calcluate_q(kluby):
    q = sum(kluby.values())
    q = int((q + 2 - q % 2) / 2)
    return q

def banzhaf(kluby):
    q = calcluate_q(kluby)
    result = [0 for _ in kluby.keys()]
    counter = 2 ** (len(kluby) - 1)
    for index, klub in enumerate(kluby.keys()):
        kluby_bez = list(kluby.keys())
        kluby_bez.remove(klub)
        klub_value = kluby[klub]
        for i in range(counter):
            sublist = kluby_bez.copy()
            for j in range(len(kluby_bez)):
                if (i >> j) % 2 == 0:
                    sublist.remove(kluby_bez[j])

            suma = sum([kluby[klub2] for klub2 in sublist])
            if suma < q and suma + klub_value >= q:
                result[index] += 1
    sum_all = sum(result)
    for i in range(len(result)):
        result[i] /= sum_all
    return result


def shapley_shubik(kluby):
    q = calcluate_q(kluby)
    result = [0] * len(kluby)
    possible_perm = factorial(len(kluby))
    for perm in permutations(enumerate(kluby.values())):
        suma = 0
        for index, value in perm:
            if suma + value >= q:
                result[index] += 1
                break
            else:
                suma += value

    for i in range(len(result)):
        result[i] /= possible_perm
    return result

# Kadencja 9

kluby = {"PiS": 235, "KO":134, "Lewica":49, "Koalicja Polska":30, "Konfederacja": 11}
banzhaf_values = banzhaf(kluby)
print(banzhaf_values)
ss = shapley_shubik(kluby)
print(ss)

# Kadencja 10

kluby = {"PiS": 191, "KO":157, "PL2025":33, "PSL":32, "Lewica":26, "Konfederacja": 18, "Wolni Republikanie":3}
banzhaf_values = banzhaf(kluby)
print(banzhaf_values)
ss = shapley_shubik(kluby)
print(ss)
