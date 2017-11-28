"""
A pile of coins is given. They all have positive integer values.
Coins have to be split in two piles that have equal sums.

Example: 3 1 3 1 4 gets split to (3 3) and (1 1 4)
"""
from copy import copy

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

print(split_pile([1]*12))
print(split_pile([6,3,8,2,3,2,1,1]))
print(split_pile([14,8,6]))
print(split_pile([5,10,4,1]))
print(split_pile([5,11,2,3,5,4,1,1]))
print(split_pile([1,1,1,3,4]))



