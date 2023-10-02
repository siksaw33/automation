In a Jupyter Notebook, you can set or modify a global variable from any cell. The variable will be accessible across all cells, including those that define and run threads.

Here's a simple example that demonstrates this:

1. Run this cell to initialize the thread and the global flag:

```python
import threading
import time

# Flag to control the loop
keep_running = True

def keep_kernel_busy(total_time_in_seconds=7200, interval_in_seconds=600):
    global keep_running
    start_time = time.time()
    while keep_running:
        elapsed_time = time.time() - start_time
        if elapsed_time >= total_time_in_seconds:
            print("2 hours have passed. Exiting loop.")
            break
        print(f"Kernel is busy. Elapsed time: {int(elapsed_time)} seconds")
        time.sleep(interval_in_seconds)

# Create a thread to keep the kernel busy
t = threading.Thread(target=keep_kernel_busy)

# Start the thread
t.start()
```

2. Run this cell whenever you want to stop the thread:

```python
# To stop the loop, set keep_running to False
keep_running = False
```

Because `keep_running` is a global variable, setting it to `False` in a different cell will affect the thread's execution, causing the loop to exit and the thread to stop.