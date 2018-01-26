"""
A pile of coins is given. They all have positive integer values.
Coins have to be split in two piles that have equal sums.

Example: 3 1 3 1 4 gets split to (3 3) and (1 1 4)
"""
from copy import copy

def accel_asc(n):
    a = [0 for i in range(n + 1)]
    k = 1
    y = n - 1
    while k != 0:
        x = a[k - 1] + 1
        k -= 1
        while 2 * x <= y:
            a[k] = x
            y -= x
            k += 1
        l = k + 1
        while x <= y:
            a[k] = x
            a[l] = y
            yield a[:k + 2]
            x += 1
            y -= 1
        a[k] = x + y
        y = x + y - 1
        yield a[:k + 1]

def part(n):
    p = 0
    for x in accel_asc(n):
        p += 1
    return p

def split_pile(pile):
    p = copy(pile)
    p.sort()
    total_sum = sum(p)
    split_sum = total_sum / 2
    current = p[-1]
    if current == split_sum:
        return [[current,], p[0:-1]]
    A = [current,]
    del p[-1]
    split_sum -= current
    i = -1
    while True:
        if p[i] < split_sum:
            A.append(p[i])
            split_sum -= p[i]
            del p[i]
        elif p[i] == split_sum:
            A.append(p[i])
            del p[i]
            return [A, p]
        i -= 1


# print(split_pile([1]*12))
# print(split_pile([6,3,8,2,3,2,1,1]))
# print(split_pile([14,8,6]))
# print(split_pile([5,10,4,1]))
# print(split_pile([5,11,2,3,5,4,1,1]))
# print(split_pile([1,1,1,3,4]))
# print(split_pile([5,5,4,4,4,4]))
# print(split_pile([5,5,4,4,4,4]))
# print(split_pile([5,4,3,3,3]))
# print(split_pile([5,4,4,3,2,2]))

# from timeit import timeit
# print(timeit('part(13)', number=1000, globals=globals()))
print(part(11))
