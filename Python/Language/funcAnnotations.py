#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Feb  1 10:52:13 2020

Function annotations demo 
@author: yubin
"""

#http://www.jeepxie.net/article/105674.html

def sum(a, b:int, c:'The default value is 5' = 5) -> float:
    return a + b + c

sum(1,2)
#>>> 8


sum('Hi',',','Python!')

#>>> Hi,Python!

#显然，注释对函数的执行没有任何影响。
#在这两种情况下，sum() 都做了正确的事情，只不过注释被忽略了而已。
    
type(sum.__annotations__)
#>>> dict


def sum( a, b ) ->0:
    r = a + b
    sum.__annotations__['return'] += r 
    return r



def sum( a, b ) ->0:
    r = a + b
    __annotations__['return'] += r ## undefined __annotations__
    self.__annotations__['return'] += r ## undefined self 
    return r


def div( a: dict( type=float, help='The dividend'),
         b: dict( type=float, help='The divisor, must be different than 0')
         ) -> dict( type=float, help='The result of dividing a by b' ):
    return a/b

def div( a: { 'type':float, 'help':'The dividend'},
         b: dict( type=float, help='The divisor, must be different than 0')
         ) -> dict( type=float, help='The result of dividing a by b' ):
    return a/b
