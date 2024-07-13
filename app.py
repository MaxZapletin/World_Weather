from flask import Flask, render_template, request
import requests

app = Flask(__name__)

# Use only the default API key
API_KEY = '02a63c6660f84cb189790638241207'
BASE_URL = "http://api.weatherapi.com/v1/forecast.json"

@app.route('/', methods=['GET', 'POST'])
def index():
    weather_data = None
    if request.method == 'POST':
        city = request.form['city']
        weather_data = get_weather(city)
    return render_template('index.html', weather=weather_data)

def get_weather(city):
    params = {
        'key': API_KEY,
        'q': city,
        'days': 3  # Get 3-day forecast
    }
    response = requests.get(BASE_URL, params=params)
    
    if response.status_code == 200:
        data = response.json()
        return {
            'location': data['location']['name'],
            'country': data['location']['country'],
            'current': {
                'temp_c': data['current']['temp_c'],
                'condition': data['current']['condition']['text'],
                'icon': data['current']['condition']['icon']
            },
            'forecast': [{
                'date': day['date'],
                'max_temp_c': day['day']['maxtemp_c'],
                'min_temp_c': day['day']['mintemp_c'],
                'condition': day['day']['condition']['text'],
                'icon': day['day']['condition']['icon']
            } for day in data['forecast']['forecastday']]
        }
    return None

if __name__ == '__main__':
    app.run(debug=True)
