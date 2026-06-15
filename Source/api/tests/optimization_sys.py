import platform
import os

def optimization_system():

    os = platform.system()
    if os == "Windows":
        print("This system is window")
    elif os == "Darwin":
        print("This system is windows")
    else:
        print("There is an issue with the function")

optimization_system()