import json

from bs4 import BeautifulSoup
import requests
import datetime




list_of_result = []
with open("my.json", "r") as file:
    jsonData = json.load(file)

for doc in jsonData:   
    new_data = {}
    new_data['firstRound'] = doc["firstRound"]
    new_data['secondRound'] = doc["secondRound"]
    new_data['provider'] = doc["provider"]
    new_data['date'] = str(datetime.datetime.strptime(doc["date"], '%Y-%d-%m %H:%M:%S.%f') + datetime.timedelta(hours=12))
    list_of_result.append(new_data)
 
       
print(list_of_result)


with open('firstData.json', 'w') as f:
    json.dump(list_of_result, f)





    