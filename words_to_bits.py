words_in_bits = []
in_word = ""

letter_bit = {
    "a": "00000",
    "b": "00001",
    "c": "00010",
    "d": "00011",
    "e": "00100",
    "f": "00101",
    "g": "00111",
    "h": "01000",
    "i": "01001",
    "j": "01010",
    "k": "01011",
    "l": "01111",
    "m": "10000",
    "n": "10001",
    "o": "10010",
    "p": "10011",
    "q": "10100",
    "r": "10101",
    "s": "10110",
    "t": "10111",
    "u": "11000",
    "v": "11001",
    "w": "11010",
    "x": "11011",
    "y": "11100",
    "z": "11101",
}

with open("type_racer_words.txt") as inpf:
    for word in inpf:
        for letter in word:
            if (letter != "\n"):
                in_word += letter_bit[letter]
        words_in_bits.append(in_word)
        in_word = ""

with open("type_racer_words_bits.txt", "w") as outf:
    for word in words_in_bits:
        outf.writelines(word + "\n")

