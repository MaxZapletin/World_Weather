from flask import Flask, render_template, request, jsonify
import requests

app = Flask(__name__)

API_KEY = '02a63c6660f84cb189790638241207'
BASE_URL = "http://api.weatherapi.com/v1/forecast.json"

@app.route('/', methods=['GET', 'POST'])
def index():
    weather_data = None
    city = None

    if request.method == 'POST':
        city = request.form.get('city')
    else:
        city = request.args.get('city')

    if city:
        weather_data = get_weather(city)

    if request.accept_mimetypes.accept_json and not request.accept_mimetypes.accept_html:
        if weather_data:
            return jsonify(weather_data)
        else:
            return jsonify({'error': 'Weather data not found'}), 404
    else:
        return render_template('index.html', weather=weather_data)

def get_weather(city):
    params = {
        'key': API_KEY,
        'q': city,
        'days': 3  
    }
    response = requests.get(BASE_URL, params=params)
    
    
    if response.status_code == 200:
        data = response.json()
        try:
            location = data.get('location', {})
            current = data.get('current', {})
            forecast = data.get('forecast', {}).get('forecastday', [])
            
            return {
                'location': location.get('name', 'Unknown location'),
                'country': location.get('country', 'Unknown country'),
                'current': {
                    'temp_c': current.get('temp_c', 'N/A'),
                    'condition': current.get('condition', {}).get('text', 'N/A'),
                    'icon': current.get('condition', {}).get('icon', '')
                },
                'forecast': [{
                    'date': day.get('date', 'N/A'),
                    'max_temp_c': day.get('day', {}).get('maxtemp_c', 'N/A'),
                    'min_temp_c': day.get('day', {}).get('mintemp_c', 'N/A'),
                    'condition': day.get('day', {}).get('condition', {}).get('text', 'N/A'),
                    'icon': day.get('day', {}).get('condition', {}).get('icon', '')
                } for day in forecast]
            }
        except KeyError as e:
            print(f"KeyError: {e}")
            return None
    else:
        print(f"Request failed with status code: {response.status_code}")
        return None

if __name__ == '__main__':
    app.run(host="0.0.0.0")


