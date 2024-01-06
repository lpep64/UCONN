from count import add5

def test1_integers():
    assert(add5(5) == 10)

def test2_integers():
    assert(add5(50) == 55)
    
def test3_integers():
    assert(add5(60) == 65)