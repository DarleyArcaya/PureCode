import time
import datetime


ts = time.time()
dt = datetime.fromtimestamp(ts)

date = dt.datetimes("The last optimization was: -> Day %d / Month %m")
print(date)

    

