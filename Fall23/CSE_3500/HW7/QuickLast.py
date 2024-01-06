import random
import sys

sys.setrecursionlimit(10000)

def generate_random_list(size):
    return [random.randint(1, 10000) for _ in range(size)]

def generate_sorted_list(size):
    return list(range(1, size + 1))

def partition(arr, low, high):
    pivot = arr[high] 
    i = low - 1

    for j in range(low, high):
        if arr[j] <= pivot:
            i += 1
            arr[i], arr[j] = arr[j], arr[i]

    arr[i + 1], arr[high] = arr[high], arr[i + 1]
    return i + 1

def quicksort(arr, low, high):
    if low < high:
        pivot_index = partition(arr, low, high)
        quicksort(arr, low, pivot_index - 1)
        quicksort(arr, pivot_index + 1, high)

#Elements below get changed based on the test
random_list = generate_random_list(1500) 
quicksort(random_list, 0, len(random_list) - 1)
print("Random-Last", len(random_list))