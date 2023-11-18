# 7 kyu, 8 yr

def find_next_square(sq):
    # Return the next square if sq is a square, -1 otherwise
    if (sq ** 0.5) % 1 == 0:
        return ((sq ** 0.5) + 1) ** 2
    else:
        return -1