import time
from datetime import datetime
import json
import pathlib


def last_optimization_date():

    FILE = pathlib.Path(__file__).parent / 'data.json'

    now = time.time()
    datatime = datetime.fromtimestamp(now)

    dt = datatime.strftime("Year: %Y, Month: %m, Day: %d")
    print(dt)


    data = {
        "last_optimization_date" : dt,
        "last_optimization_time": datatime.strftime("%H:%M:%S"),
        "last_optimization_status": "Optimized",
    }
    

    try:
        with open(FILE, 'w') as f:
            json.dump(data, f, indent=4)
            print('Data written successfully')
        return data
    except Exception as e:
        print('Error writing data to file')

