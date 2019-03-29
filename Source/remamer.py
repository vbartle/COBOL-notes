import sys


def rename(f:str, r:bool=True):
    r = open(f, "r")
    w = open(f, "w")
    if r:
        sub_num(r, w)
    else:
        add_num(r, w)

def sub_num(r, w):
    t = ""
    for l in r:
        print(l)
        t += l[7:len(l)]+"\n"
    print(t)
    w.write(t)

def add_num(r, w):
    t = ""
    for n, l in enumerate(r):
        n = str((n-1)*100)
        while len(n) > 6:
            n = "0"+n
        t += n + l
    w.write(t)

rename(sys.argv[1], sys.argv[2])