from flask import Flask, render_template, request, jsonify
import requests

app = Flask(__name__)

# Use only the default API key
API_KEY = '02a63c6660f84cb189790638241207'
BASE_URL = "http://api.weatherapi.com/v1/forecast.json"

@app.route('/', methods=['GET'])
def index():
    # Retrieve the city from the query parameters
    city = request.args.get('city')
    weather_data = None

    # If a city is provided, get the weather data
    if city:
        weather_data = get_weather(city)

    # Check if the client accepts JSON response
    if request.accept_mimetypes.accept_json and not request.accept_mimetypes.accept_html:
        if weather_data:
            return jsonify(weather_data)
        else:
            return jsonify({'error': 'Weather data not found'}), 404
    else:
        # Render the HTML template with weather data
        return render_template('index.html', weather=weather_data)

def get_weather(city):
    # Set up the parameters for the API request
    params = {
        'key': API_KEY,
        'q': city,
        'days': 3  # Get 3-day forecast
    }
    # Send a GET request to the WeatherAPI
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
    app.run(debug=True)
