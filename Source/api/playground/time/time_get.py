import time
from datetime import datetime
import json
import pathlib
import sys 

if sys.platform == "win32":
    FILE = pathlib.Path(__file__).parent / 'data.json' # This is for create the data.json in the same folder.


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
except Exception as e:
    print("Error writing data to file")
   

