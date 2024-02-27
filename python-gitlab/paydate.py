from datetime import timedelta, date

date1 = date(2024, 2, 13)

for x in range(24):
    date2 = date1 + timedelta(days=14)
    print (date2)
    date1=date2


