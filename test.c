int foo(int cond){
    int x = 0xffff0000;
    short* p1 = (short*)&x;
    short* p2 = p1 + 2;
    int y = 14;
    if (cond > 3){
        *p1 = 0x0000;
        y = 12;
    } else {
        *p2 = 0xffff;
        y = 7;
    }
    return x + y;
}