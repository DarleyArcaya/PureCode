import platform

def optimization_system():

    os = platform.system()
    if os == "Windows":
        print("This system is window")
    elif os == "Darwin":
        print("This system is Darwin")
    else:
        print("This system is other")
    

optimization_system()