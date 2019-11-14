#!/usr/bin/env python
# Copyright (c) 2019, Sergio Arroutbi Braojos <sarroutbi (at) yahoo.es>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
"""
Program to test Quick Sort implementation in Python
Usage:
${0} "list of numbers to sort"
Example
${0} 2 4 8 3 19 5
"""
import sys

def partition(numbers, start, end):
    """ Partition function, returns sorted array to left
        and right of the pivot, returning pivot index """
    pivot_index = start
    pivot = numbers[end]
    for i in range(start, end):
        if numbers[i] <= pivot:
            next_nu = numbers[pivot_index]
            numbers[pivot_index] = numbers[i]
            numbers[i] = next_nu
            pivot_index += 1
    numbers[end] = numbers[pivot_index]
    numbers[pivot_index] = pivot
    return pivot_index

def quick_sort(numbers, start, end):
    """ quick sort implementation """
    if start < end:
        pivot_index = partition(numbers, start, end)
        quick_sort(numbers, start, pivot_index-1)
        quick_sort(numbers, pivot_index+1, end)

def sort(numbers):
    """ call quick sort specifying init and end """
    quick_sort(numbers, 0, len(numbers)-1)

def parse_args(args):
    """ parse arguments to integer list """
    args_list = []
    for arg in range(1, len(args)):
        args_list.append(int(args[arg]))
    return args_list

def main():
    """ main """
    numbers = parse_args(sys.argv)
    print("Numbers:", numbers)
    sort(numbers)
    print("Quick Sort Ordered Numbers:", numbers)

if __name__ == "__main__":
    main()
