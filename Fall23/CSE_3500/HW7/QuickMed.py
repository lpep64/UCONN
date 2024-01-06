import random
import sys

sys.setrecursionlimit(10000)

def generate_random_list(size):
    return [random.randint(1, 10000) for _ in range(size)]

def generate_sorted_list(size):
    return list(range(1, size + 1))

def partition(arr, low, high, pivot):
    i = low
    for j in range(low, high):
        if arr[j] == pivot:
            arr[j], arr[high] = arr[high], arr[j]
        if arr[j] < pivot:
            arr[i], arr[j] = arr[j], arr[i]
            i += 1
    arr[i], arr[high] = arr[high], arr[i]
    return i

def median_of_medians(arr, low, high):
    if high - low < 5:
        return sorted(arr[low:high + 1])[len(arr[low:high + 1]) // 2]

    medians = []
    for i in range(low, high, 5):
        median = sorted(arr[i:i+5])[len(arr[i:i+5]) // 2]
        medians.append(median)

    return median_of_medians(medians, 0, len(medians))

def quicksort(arr, low, high):
    if low < high:
        pivot = median_of_medians(arr, low, high)
        pivot_index = partition(arr, low, high, pivot)
        quicksort(arr, low, pivot_index - 1)
        quicksort(arr, pivot_index + 1, high)

#Elements below get changed based on the test
random_list = generate_random_list(1500)  
quicksort(random_list, 0, len(random_list) - 1)
print("Random-Mid_mids", len(random_list))